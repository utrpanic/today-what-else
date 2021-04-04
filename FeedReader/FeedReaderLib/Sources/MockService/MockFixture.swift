import Foundation

func mockFixture(name: String) -> Data {
    guard let mockFixtureURL = Bundle.module.url(forResource: name, withExtension: nil),
          let data = try? Data(contentsOf: mockFixtureURL) else {
        fatalError("Mock fixture \(name) not found.")
    }
    return data
}
