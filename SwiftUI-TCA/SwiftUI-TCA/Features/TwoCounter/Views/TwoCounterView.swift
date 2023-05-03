//
//  TwoCounterView.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/03.
//  
//

import ComposableArchitecture
import SwiftUI

struct TwoCountersView: View {
    let store: StoreOf<TwoCounters>

    var body: some View {
        HStack {
            Text("Counter 1")
            Spacer()
            CounterView(
                store: self.store.scope(state: \.counter1, action: TwoCounters.Action.counter1)
            )
        }

        HStack {
            Text("Counter 2")
            Spacer()
            CounterView(
                store: self.store.scope(state: \.counter2, action: TwoCounters.Action.counter2)
            )
        }
    }
}
