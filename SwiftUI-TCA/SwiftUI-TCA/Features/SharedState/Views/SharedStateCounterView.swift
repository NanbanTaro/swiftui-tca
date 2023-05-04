//
//  SharedStateCounterView.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/04.
//  
//

import ComposableArchitecture
import SwiftUI

struct SharedStateCounterView: View {
    let store: StoreOf<SharedState.Counter>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 64) {
                VStack(spacing: 16) {
                    HStack {
                        Button {
                            viewStore.send(.decrementButtonTapped)
                        } label: {
                            Image(systemName: "minus")
                        }

                        Text("\(viewStore.count)")
                            .monospacedDigit()

                        Button {
                            viewStore.send(.incrementButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    Button("Is this prime?") { viewStore.send(.isPrimeButtonTapped) }
                }
            }
            .padding(.top)
            .navigationTitle("Shared State Demo")
            .alert(self.store.scope(state: \.alert), dismiss: .alertDismissed)
        }
    }
}
