//
//  SharedStateStore.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/04.
//  
//

import ComposableArchitecture
import SwiftUI

struct SharedState: ReducerProtocol {
    enum Tab {
        case counter, profile
    }

    struct State: Equatable {
        var counter = Counter.State()
        var currentTab = Tab.counter

        /// The Profile.State can be derived from the Counter.State by getting and setting the parts it
        /// cares about. This allows the profile feature to operate on a subset of app state instead of
        /// the whole thing.
        var profile: Profile.State {
            get {
                Profile.State(
                    currentTab: self.currentTab,
                    count: self.counter.count,
                    maxCount: self.counter.maxCount,
                    minCount: self.counter.minCount,
                    numberOfCounts: self.counter.numberOfCounts
                )
            }
            set {
                self.currentTab = newValue.currentTab
                self.counter.count = newValue.count
                self.counter.maxCount = newValue.maxCount
                self.counter.minCount = newValue.minCount
                self.counter.numberOfCounts = newValue.numberOfCounts
            }
        }
    }

    enum Action: Equatable {
        case counter(Counter.Action)
        case profile(Profile.Action)
        case selectTab(Tab)
    }

    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.counter, action: /Action.counter) {
            Counter()
        }

        Scope(state: \.profile, action: /Action.profile) {
            Profile()
        }

        Reduce { state, action in
            switch action {
            case .counter, .profile:
                return .none
            case let .selectTab(tab):
                state.currentTab = tab
                return .none
            }
        }
    }

    struct Counter: ReducerProtocol {
        struct State: Equatable {
            var alert: AlertState<Action>?
            var count = 0
            var maxCount = 0
            var minCount = 0
            var numberOfCounts = 0
        }

        enum Action: Equatable {
            case alertDismissed
            case decrementButtonTapped
            case incrementButtonTapped
            case isPrimeButtonTapped
        }

        func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
            switch action {
            case .alertDismissed:
                state.alert = nil
                return .none

            case .decrementButtonTapped:
                state.count -= 1
                state.numberOfCounts += 1
                state.minCount = min(state.minCount, state.count)
                return .none

            case .incrementButtonTapped:
                state.count += 1
                state.numberOfCounts += 1
                state.maxCount = max(state.maxCount, state.count)
                return .none

            case .isPrimeButtonTapped:
                state.alert = AlertState {
                    TextState(
                        isPrime(state.count)
                        ? "👍 The number \(state.count) is prime!"
                        : "👎 The number \(state.count) is not prime :("
                    )
                }
                return .none
            }
        }
    }

    struct Profile: ReducerProtocol {
        struct State: Equatable {
            private(set) var currentTab: Tab
            private(set) var count = 0
            private(set) var maxCount: Int
            private(set) var minCount: Int
            private(set) var numberOfCounts: Int

            fileprivate mutating func resetCount() {
                self.currentTab = .counter
                self.count = 0
                self.maxCount = 0
                self.minCount = 0
                self.numberOfCounts = 0
            }
        }

        enum Action: Equatable {
            case resetCounterButtonTapped
        }

        func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
            switch action {
            case .resetCounterButtonTapped:
                state.resetCount()
                return .none
            }
        }
    }
}

/// Checks if a number is prime or not.
private func isPrime(_ p: Int) -> Bool {
    if p <= 1 { return false }
    if p <= 3 { return true }
    for i in 2...Int(sqrtf(Float(p))) {
        if p % i == 0 { return false }
    }
    return true
}
