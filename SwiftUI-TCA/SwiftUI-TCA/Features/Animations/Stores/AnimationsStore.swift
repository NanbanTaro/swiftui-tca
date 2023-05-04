//
//  AnimationsStore.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/04.
//  
//

import ComposableArchitecture
@preconcurrency import SwiftUI

struct Animations: ReducerProtocol {
    struct State: Equatable {
        var alert: AlertState<Action>?
        var circleCenter: CGPoint?
        var circleColor = Color.black
        var isCircleScaled = false
    }

    enum Action: Equatable, Sendable {
        case alertDismissed
        case circleScaleToggleChanged(Bool)
        case rainbowButtonTapped
        case resetButtonTapped
        case resetConfirmationButtonTapped
        case setColor(Color)
        case tapped(CGPoint)
    }

    @Dependency(\.continuousClock) var clock

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        enum CancelID {}

        switch action {
        case .alertDismissed:
            state.alert = nil
            return .none

        case let .circleScaleToggleChanged(isScaled):
            state.isCircleScaled = isScaled
            return .none

        case .rainbowButtonTapped:
            return .run { send in
                for color in [Color.red, .blue, .green, .orange, .pink, .purple, .yellow, .black] {
                    await send(.setColor(color), animation: .linear)
                    try await self.clock.sleep(for: .seconds(1))
                }
            }
            .cancellable(id: CancelID.self)

        case .resetButtonTapped:
            state.alert = AlertState {
                TextState("Reset state?")
            } actions: {
                ButtonState(
                    role: .destructive,
                    action: .send(.resetConfirmationButtonTapped, animation: .default)
                ) {
                    TextState("Reset")
                }
                ButtonState(role: .cancel) {
                    TextState("Cancel")
                }
            }
            return .none

        case .resetConfirmationButtonTapped:
            state = State()
            return .cancel(id: CancelID.self)

        case let .setColor(color):
            state.circleColor = color
            return .none

        case let .tapped(point):
            state.circleCenter = point
            return .none
        }
    }
}
