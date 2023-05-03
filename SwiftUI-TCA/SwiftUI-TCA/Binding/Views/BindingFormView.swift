//
//  BindingFormView.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/03.
//  
//

import ComposableArchitecture
import SwiftUI

struct BindingFormView: View {
    let store: StoreOf<BindingForm>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    TextField("Type here", text: viewStore.binding(\.$text))
                        .disableAutocorrection(true)
                        .foregroundStyle(viewStore.toggleIsOn ? Color.secondary : .primary)
                    Text(alternate(viewStore.text))
                }
                .disabled(viewStore.toggleIsOn)

                Toggle(
                    "Disable other controls",
                    isOn: viewStore.binding(\.$toggleIsOn)
                )

                Stepper(
                    "Max slider value: \(viewStore.stepCount)",
                    value: viewStore.binding(\.$stepCount),
                    in: 0...100
                )
                .disabled(viewStore.toggleIsOn)

                HStack {
                    Text("Slider value: \(Int(viewStore.sliderValue))")

                    Slider(value: viewStore.binding(\.$sliderValue), in: 0...Double(viewStore.stepCount))
                        .tint(.accentColor)
                }
                .disabled(viewStore.toggleIsOn)

                Button("Reset") {
                    viewStore.send(.resetButtonTapped)
                }
                .tint(.red)
            }
        }
    }
}

private func alternate(_ string: String) -> String {
    string
        .enumerated()
        .map { idx, char in
            idx.isMultiple(of: 2)
            ? char.uppercased()
            : char.lowercased()
        }
        .joined()
}
