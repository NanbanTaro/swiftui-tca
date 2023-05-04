//
//  SharedStateView.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/04.
//  
//

import ComposableArchitecture
import SwiftUI

struct SharedStateView: View {
    let store: StoreOf<SharedState>

    var body: some View {
        WithViewStore(self.store, observe: \.currentTab) { viewStore in
            VStack {
                Picker(
                    "Tab",
                    selection: viewStore.binding(send: SharedState.Action.selectTab)
                ) {
                    Text("Counter")
                        .tag(SharedState.Tab.counter)

                    Text("Profile")
                        .tag(SharedState.Tab.profile)
                }
                .pickerStyle(.segmented)

                if viewStore.state == .counter {
                    SharedStateCounterView(
                        store: self.store.scope(state: \.counter, action: SharedState.Action.counter))
                }

                if viewStore.state == .profile {
                    SharedStateProfileView(
                        store: self.store.scope(state: \.profile, action: SharedState.Action.profile))
                }

                Spacer()
            }
        }
        .padding()
    }
}
