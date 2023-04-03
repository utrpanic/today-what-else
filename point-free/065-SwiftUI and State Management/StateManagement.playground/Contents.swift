import SwiftUI

// https://developer.wolframalpha.com/portal/myapps/
let wolframAlphaApiKey = ""

struct WolframAlphaResult: Decodable {
  
  let queryresult: QueryResult
  
  struct QueryResult: Decodable {
    let pods: [Pod]
    struct Pod: Decodable {
      let primary: Bool?
      let subpods: [SubPod]
      struct SubPod: Decodable {
        let plaintext: String
      }
    }
  }
}

func wolframAlpha(query: String, callback: @escaping (WolframAlphaResult?) -> Void) -> Void {
  var components = URLComponents(string: "https://api.wolframalpha.com/v2/query")!
  components.queryItems = [
    URLQueryItem(name: "input", value: query),
    URLQueryItem(name: "format", value: "plaintext"),
    URLQueryItem(name: "output", value: "JSON"),
    URLQueryItem(name: "appid", value: wolframAlphaApiKey),
  ]
  URLSession.shared.dataTask(with: components.url(relativeTo: nil)!) { data, response, error in
    callback(data.flatMap { try? JSONDecoder().decode(WolframAlphaResult.self, from: $0) })
  }
  .resume()
}

func requestNthPrime(_ n: Int, callback: @escaping (Int?) -> Void) -> Void {
  wolframAlpha(query: "prime \(n)") { result in
    callback(
      result.flatMap {
        $0.queryresult
          .pods
          .first(where: { $0.primary == .some(true) })?
          .subpods
          .first?
          .plaintext
      }
        .flatMap(Int.init)
    )
  }
}

struct ContentView: View {
  
  @ObservedObject var state: AppState
  
  var body: some View {
    NavigationStack {
      List {
        NavigationLink(destination: CounterView(state: self.state)) {
          Text("Counter demo")
        }
        NavigationLink(destination: FavoritePrimesView(state: .init(state: self.state))) {
          Text("Favorite primes")
        }
      }
      .navigationTitle("State management")
    }
  }
}

private func ordinal(_ n: Int) -> String {
  let formatter = NumberFormatter()
  formatter.numberStyle = .ordinal
  return formatter.string(for: n) ?? ""
}

import Combine

class AppState: ObservableObject {
  
  @Published var count = 0
  @Published var favoritePrimes: [Int] = []
  @Published var loggedInUser: User?
  @Published var activityFeed: [Activity] = []
  
  struct User {
    let id: Int
    let name: String
    let bio: String
  }
  
  struct Activity {
    let timestamp: Date
    let type: ActivityType
    enum ActivityType {
      case addedFavoritePrime(Int)
      case removedFavoritePrime(Int)
    }
  }
  
  func addFavoritePrime() {
    self.favoritePrimes.append(self.count)
    self.activityFeed.append(.init(timestamp: Date(), type: .addedFavoritePrime(self.count)))
  }
  
  func removeFavoritePrime(_ prime: Int) {
    self.favoritePrimes.removeAll(where: { $0 == prime })
    self.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(prime)))
  }
  
  func removeFavoritePrime() {
    self.removeFavoritePrime(self.count)
  }
}

struct CounterView: View {
  
  @ObservedObject var state: AppState
  @State var isPrimeModalShown: Bool = false
  @State var isNthPrimeAlertShown: Bool = false
  @State var nthPrime: Int?
  @State var isNthPrimeButtonDisabled = false
  
  var body: some View {
    VStack {
      HStack {
        Button(action: { self.state.count -= 1 }) {
          Text("-")
        }
        Text("\(self.state.count)")
        Button(action: { self.state.count += 1 }) {
          Text("+")
        }
      }
      Button(action: { self.isPrimeModalShown = true }) {
        Text("Is this prime")
      }
      Button(action: self.nthPrimeButtonAction) {
        Text("What is the \(ordinal(self.state.count)) prime")
      }
      .disabled(self.isNthPrimeButtonDisabled)
    }
    .font(.title)
    .navigationTitle("Counter demo")
    .sheet(isPresented: self.$isPrimeModalShown) {
      IsPrimeModalView(state: self.state)
    }
    .alert(
      "The \(ordinal(self.state.count)) prime is \(self.nthPrime ?? 0)",
      isPresented: self.$isNthPrimeAlertShown,
      actions: { }
    )
  }
  
  func nthPrimeButtonAction() {
    self.isNthPrimeButtonDisabled = true
    requestNthPrime(self.state.count) { prime in
      self.nthPrime = prime
      self.isNthPrimeAlertShown = true
      self.isNthPrimeButtonDisabled = false
    }
  }
}

private func isPrime(_ p: Int) -> Bool {
  if p <= 1 { return false }
  if p <= 3 { return true }
  for i in 2...Int(sqrtf(Float(p))) {
    if p % i == 0 { return false }
  }
  return true
}

struct IsPrimeModalView: View {
  
  @ObservedObject var state: AppState
  
  var body: some View {
    VStack {
      if isPrime(self.state.count) {
        Text("\(self.state.count) is prime 🎉")
        if self.state.favoritePrimes.contains(self.state.count) {
          Button(action: {
            self.state.removeFavoritePrime()
          }) {
            Text("Remove from favorite primes")
          }
        } else {
          Button(action: {
            self.state.addFavoritePrime()
          }) {
            Text("Save to favorite primes")
          }
        }
      } else {
        Text("\(self.state.count) is not prime :(")
      }
    }
  }
}

class FavoritePrimesState: ObservableObject {
  
  private var state: AppState
  var favoritePrimes: [Int] {
    get { self.state.favoritePrimes }
    set { self.state.favoritePrimes = newValue }
  }
  var activityFeed: [AppState.Activity] {
    get { self.state.activityFeed }
    set { self.state.activityFeed = newValue }
  }
  
  init(state: AppState) {
    self.state = state
  }
  
  func removeFavoritePrimes(at indexSet: IndexSet) {
    for index in indexSet {
      self.state.removeFavoritePrime(self.favoritePrimes[index])
    }
  }
}

struct FavoritePrimesView: View {
  
  @ObservedObject var state: FavoritePrimesState
  
  var body: some View {
    List {
      ForEach(self.state.favoritePrimes, id: \.self) { prime in
        Text("\(prime)")
      }
      .onDelete {
        self.state.removeFavoritePrimes(at: $0)
      }
    }
    .navigationBarTitle(Text("Favorite Primes"))
  }
}

import PlaygroundSupport

PlaygroundPage.current.liveView = UIHostingController(
  rootView: ContentView(state: AppState())
)
