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
    let store: StoreOf<Counter> = Store(initialState: Counter.State(),
                                        reducer: Counter())

    var body: some View {
        Form {
          Section {
            CounterView(store: self.store)
              .frame(maxWidth: .infinity)
          }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
