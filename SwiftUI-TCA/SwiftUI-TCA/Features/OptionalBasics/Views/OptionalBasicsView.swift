//
//  OptionalBasicsView.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/03.
//  
//

import ComposableArchitecture
import SwiftUI

struct OptionalBasicsView: View {
    let store: StoreOf<OptionalBasics>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Button("Toggle counter state") {
                viewStore.send(.toggleCounterButtonTapped)
            }

            IfLetStore(
                self.store.scope(
                    state: \.optionalCounter,
                    action: OptionalBasics.Action.optionalCounter
                ),
                then: { store in
                    Text("`CounterState` is non-`nil`")
                    CounterView(store: store)
                        .buttonStyle(.borderless)
                        .frame(maxWidth: .infinity)
                },
                else: {
                    Text("`CounterState` is `nil`")
                }
            )
        }
    }
}
