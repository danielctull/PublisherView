
import Combine
import SwiftUI

/// A view which shows views depending on the state of a Combine publisher.
///
/// The initial view is shown before a value or failure is received by the
/// publisher. For each output value received, a view is created and displayed.
/// If the publisher fails, the failure view will be displayed.
public struct PublisherView<Publisher, InitialView, OutputView, FailureView>
    where
    Publisher: Combine.Publisher,
    InitialView: View,
    OutputView: View,
    FailureView: View
{
    public typealias Output = Publisher.Output
    public typealias Failure = Publisher.Failure

    @ObservedObject private var loader: Loader

    /// Create a publisher view, showing nothing initially.
    ///
    /// - Parameters:
    ///   - publisher: The publisher to subscribe to.
    ///   - initial: Function to create the view shown before a value or failure
    ///              is received.
    ///   - output: Function to create the view for a given output value.
    ///   - failure: Function to create the view for the given failure.
    public init(publisher: Publisher,
                initial: () -> InitialView,
                output: @escaping (Output) -> OutputView,
                failure: @escaping (Failure) -> FailureView) {

        loader = Loader(publisher: publisher,
                        initial: initial,
                        output: output,
                        failure: failure)
    }
}

// MARK: Display state

extension PublisherView {

    fileprivate enum Display {
        case initial(InitialView)
        case output(OutputView)
        case failure(FailureView)
    }
}

// MARK: Loader

extension PublisherView {

    fileprivate final class Loader: ObservableObject {

        @Published var display: Display
        private var cancellable: AnyCancellable?

        init(publisher: Publisher,
             initial makeInitialView: () -> InitialView,
             output makeOutputView: @escaping (Output) -> OutputView,
             failure makeFailureView: @escaping (Failure) -> FailureView) {

            display = .initial(makeInitialView())
            cancellable = publisher
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    guard case .failure(let error) = completion else { return }
                    self.display = .failure(makeFailureView(error))
                }, receiveValue: { output in
                    self.display = .output(makeOutputView(output))
                })
        }
    }
}

// MARK: View

extension PublisherView: View {

    public var body: some View {
        ZStack {
            initialView
            outputView
            failureView
        }
    }

    private var initialView: InitialView? {
        guard case .initial(let view) = loader.display else { return nil }
        return view
    }

    private var outputView: OutputView? {
        guard case .output(let view) = loader.display else { return nil }
        return view
    }

    private var failureView: FailureView? {
        guard case .failure(let view) = loader.display else { return nil }
        return view
    }
}
