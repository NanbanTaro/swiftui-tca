//
//  CounterStore.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/03.
//
//

import ComposableArchitecture

struct Counter: ReducerProtocol {
    struct State: Equatable {
        var count = 0
    }

    enum Action: Equatable {
        case decrementButtonTapped
        case incrementButtonTapped
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            return .none
        case .incrementButtonTapped:
            state.count += 1
            return .none
        }
    }
}
