//
//  ContentView.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/02.
//  
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let counterStore: StoreOf<Counter> = Store(initialState: Counter.State(),
                                        reducer: Counter())
    let twoCounterStore: StoreOf<TwoCounters> = Store(initialState: TwoCounters.State(),
                                                      reducer: TwoCounters())

    var body: some View {
        Form {
            Section {
                CounterView(store: self.counterStore)
                    .frame(maxWidth: .infinity)
            }
            Section {
                TwoCountersView(store: self.twoCounterStore)
                    .frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(.borderless)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
