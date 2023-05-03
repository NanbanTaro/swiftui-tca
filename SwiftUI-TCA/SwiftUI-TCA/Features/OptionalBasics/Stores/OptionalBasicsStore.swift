//
//  OptionalBasicsStore.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/03.
//  
//

import ComposableArchitecture

struct OptionalBasics: ReducerProtocol {
    struct State: Equatable {
        var optionalCounter: Counter.State?
    }

    enum Action: Equatable {
        case optionalCounter(Counter.Action)
        case toggleCounterButtonTapped
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .toggleCounterButtonTapped:
                state.optionalCounter = state.optionalCounter == nil ? Counter.State() : nil
                return .none
            case .optionalCounter:
                return .none
            }
        }
        .ifLet(\.optionalCounter, action: /Action.optionalCounter) {
            Counter()
        }
    }
}
