//
//  CounterView.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/03.
//
//

import ComposableArchitecture
import SwiftUI

struct CounterView: View {
    let store: StoreOf<Counter>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
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
        }
    }
}
