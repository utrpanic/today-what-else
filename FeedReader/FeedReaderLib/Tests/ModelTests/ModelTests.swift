import XCTest

@testable import Model

class ModelTests: XCTestCase {
    
    let feedFirstURL = URL(string: "https://www.cocoawithlove.com/blog/swiftui-natural-pattern.html")!
    
    func test_Reload() {
        // Given a newly initialized model and an expectation that stops on the second feed value
        let model = Model()
        let secondValue = expectation(description: "feed should emit 2 values.")
        let cancellable = model.$feed
            .dropFirst()
            .sink { _ in secondValue.fulfill() }
        
        // When the automatically invoked 'reload()' completes
        wait(for: [secondValue], timeout: 30.0)
        
        // Then the first feed URL should be the expected swiftui-natural-pattern.html
        XCTAssertEqual(model.feed?.items.map(\.url).first, feedFirstURL)
    }
}
