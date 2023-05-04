//
//  AlertAndConfirmationDialogView.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/04.
//  
//

import ComposableArchitecture
import SwiftUI

struct AlertAndConfirmationDialogView: View {
    let store: StoreOf<AlertAndConfirmationDialog>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text("Count: \(viewStore.count)")
            Button("Alert") { viewStore.send(.alertButtonTapped) }
            Button("Confirmation Dialog") { viewStore.send(.confirmationDialogButtonTapped) }
        }
        .navigationTitle("Alerts & Dialogs")
        .alert(
            self.store.scope(state: \.alert),
            dismiss: .alertDismissed
        )
        .confirmationDialog(
            self.store.scope(state: \.confirmationDialog),
            dismiss: .confirmationDialogDismissed
        )
    }
}
