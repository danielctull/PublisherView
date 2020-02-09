
import SwiftUI

extension PublisherView
    where
    InitialView == EmptyView
{
    /// Create a publisher view, showing nothing initially.
    ///
    /// - Parameters:
    ///   - publisher: The publisher to subscribe to.
    ///   - output: Function to create the view for a given output value.
    ///   - failure: Function to create the view for the given failure.
    public init(publisher: Publisher,
                output: @escaping (Output) -> OutputView,
                failure: @escaping (Failure) -> FailureView) {

        self.init(publisher: publisher,
                  initial: EmptyView.init,
                  output: output,
                  failure: failure)
    }
}

extension PublisherView
    where
    Publisher.Failure == Never,
    FailureView == EmptyView
{
    /// Create a publisher view for a publisher which never fails.
    ///
    /// - Parameters:
    ///   - publisher: The publisher to subscribe to.
    ///   - initial: Function to create the view shown before a value is
    ///              received.
    ///   - output: Function to create the view for a given output value.
    public init(publisher: Publisher,
                initial: @escaping () -> InitialView,
                output: @escaping (Output) -> OutputView) {

        self.init(publisher: publisher,
                  initial: initial,
                  output: output,
                  failure: { _ in EmptyView() })
    }
}

extension PublisherView
    where
    Publisher.Failure == Never,
    FailureView == EmptyView,
    InitialView == EmptyView
{
    /// Create a publisher view showing nothing initially for a publisher which
    /// never fails.
    ///
    /// - Parameters:
    ///   - publisher: The publisher to subscribe to.
    ///   - output: Function to create the view for a given output value.
    public init(publisher: Publisher,
                output: @escaping (Output) -> OutputView) {

        self.init(publisher: publisher,
                  initial: EmptyView.init,
                  output: output,
                  failure: { _ in EmptyView() })
    }
}
