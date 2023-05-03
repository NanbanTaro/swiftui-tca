//
//  BindingFormStore.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/03.
//  
//

import ComposableArchitecture

struct BindingForm: ReducerProtocol {
    struct State: Equatable {
        @BindingState var sliderValue = 5.0
        @BindingState var stepCount = 10
        @BindingState var text = ""
        @BindingState var toggleIsOn = false
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case resetButtonTapped
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.$stepCount):
                state.sliderValue = .minimum(state.sliderValue, Double(state.stepCount))
                return .none
            case .binding:
                return .none
            case .resetButtonTapped:
                state = State()
                return .none
            }
        }
    }
}
