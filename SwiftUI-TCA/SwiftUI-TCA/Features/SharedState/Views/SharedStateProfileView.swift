//
//  SharedStateProfileView.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/04.
//  
//

import ComposableArchitecture
import SwiftUI

struct SharedStateProfileView: View {
    let store: StoreOf<SharedState.Profile>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 64) {
                VStack(spacing: 16) {
                    Text("Current count: \(viewStore.count)")
                    Text("Max count: \(viewStore.maxCount)")
                    Text("Min count: \(viewStore.minCount)")
                    Text("Total number of count events: \(viewStore.numberOfCounts)")
                    Button("Reset") { viewStore.send(.resetCounterButtonTapped) }
                }
            }
            .padding(.top)
            .navigationTitle("Profile")
        }
    }
}
