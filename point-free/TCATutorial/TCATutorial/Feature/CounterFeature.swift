import ComposableArchitecture

@Reducer
struct CounterFeature {
  struct State: Equatable {
    var count = 0
  }
  
  enum Action {
    case incrementButtonTapped
    case decrementButtonTapped
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .incrementButtonTapped:
        state.count += 1
        return .none
      case .decrementButtonTapped:
        state.count -= 1
        return .none
      }
    }
  }
}
