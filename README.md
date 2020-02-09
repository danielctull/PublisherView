# PublisherView

[![Latest release][release shield]][releases] [![Swift 5.1][swift shield]][swift] ![Platforms: iOS, macOS, tvOS, watchOS][platforms shield]

A SwiftUI view that subscribes to a Combine publisher to show different views for values and failures.

## Usage

This can be used with a data task publisher which then decodes the data into model objects. In this example We display a list of posts when they are received or show the error message on screen if the task fails.

```swift
struct PostsView: View {
  // Get this publisher from somewhere, maybe a data task publisher
  let publisher: AnyPublisher<[Post], Error>
  var body: some View {
    PublisherView(publisher: publisher,
                  initial: LoadingView.init,
                  output: Content.init,
                  failure: FailureView.init)
  }
}

extension PostsView {

  fileprivate struct Content: View {
    let posts: [Post]
    var body: some View {
      List(posts) { post in
        Text(post.title)
      }
    }
  }
}

struct LoadingView: View {
  var body: some View {
    // Some awesome loading view
  }
}

struct FailureView: View {
  let error: Error
  var body: some View {
    Text(error.localizedDescription)
  }
}
```

[releases]: https://github.com/danielctull/PublisherView/releases
[release shield]: https://img.shields.io/github/v/release/danielctull/PublisherView
[swift]: https://swift.org
[swift shield]: https://img.shields.io/badge/swift-5.1-F05138.svg "Swift 5.1"
[platforms shield]: https://img.shields.io/badge/platforms-iOS_macOS_tvOS_watchOS-lightgrey.svg?style=flat "iOS, macOS, tvOS, watchOS"
