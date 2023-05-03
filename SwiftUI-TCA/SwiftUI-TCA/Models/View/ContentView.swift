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
    let bindingFormStore: StoreOf<BindingForm> = Store(initialState: BindingForm.State(),
                                                       reducer: BindingForm())
    let optionalBasicsStore: StoreOf<OptionalBasics> = Store(initialState: OptionalBasics.State(),
                                                             reducer: OptionalBasics())

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
            Section {
                BindingFormView(store: self.bindingFormStore)
            }
            Section {
                OptionalBasicsView(store: self.optionalBasicsStore)
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
