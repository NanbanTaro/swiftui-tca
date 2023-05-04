//
//  AnimationsView.swift
//  SwiftUI-TCA
//
//  Created by NanbanTaro on 2023/05/04.
//  
//

import ComposableArchitecture
import SwiftUI

struct AnimationsView: View {
  let store: StoreOf<Animations>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack(alignment: .leading) {
        Text("readMe")
          .padding()
          .gesture(
            DragGesture(minimumDistance: 0).onChanged { gesture in
              viewStore.send(
                .tapped(gesture.location),
                animation: .interactiveSpring(response: 0.25, dampingFraction: 0.1)
              )
            }
          )
          .overlay {
            GeometryReader { proxy in
              Circle()
                .fill(viewStore.circleColor)
                .colorInvert()
                .blendMode(.difference)
                .frame(width: 50, height: 50)
                .scaleEffect(viewStore.isCircleScaled ? 2 : 1)
                .position(
                  x: viewStore.circleCenter?.x ?? proxy.size.width / 2,
                  y: viewStore.circleCenter?.y ?? proxy.size.height / 2
                )
                .offset(y: viewStore.circleCenter == nil ? 0 : -44)
            }
            .allowsHitTesting(false)
          }
        Toggle(
          "Big mode",
          isOn:
            viewStore
            .binding(get: \.isCircleScaled, send: Animations.Action.circleScaleToggleChanged)
            .animation(.interactiveSpring(response: 0.25, dampingFraction: 0.1))
        )
        .padding()
        Button("Rainbow") { viewStore.send(.rainbowButtonTapped, animation: .linear) }
          .padding([.horizontal, .bottom])
        Button("Reset") { viewStore.send(.resetButtonTapped) }
          .padding([.horizontal, .bottom])
      }
      .alert(self.store.scope(state: \.alert), dismiss: .alertDismissed)
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}
