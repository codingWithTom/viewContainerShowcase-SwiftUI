//
//  FlipContainerView.swift
//  ViewContainersShowcase
//
//  Created by Tomas Trujillo on 2020-09-19.
//

import SwiftUI

struct FlipContainerView<Content: View>: View {
  @State private var isFrontSelected: Bool = true
  let frontView: Content
  let backView: Content
  
  init(@ViewBuilder frontView: @escaping () -> Content, @ViewBuilder backView: @escaping () -> Content) {
    self.frontView = frontView()
    self.backView = backView()
  }
  
  var body: some View {
    ZStack {
      Group {
        frontView
          .opacity(isFrontSelected ? 1.0 : 0.0)
          .modifier(FlipModifier(angle: Angle(degrees: isFrontSelected ? 0.0 : 180)))
          .onTapGesture {
            withAnimation {
              self.isFrontSelected.toggle()
            }
          }
        backView
          .opacity(isFrontSelected ? 0.0 : 1.0)
          .modifier(FlipModifier(angle: Angle(degrees: isFrontSelected ? -180 : 0.0)))
          .onTapGesture {
            withAnimation {
              self.isFrontSelected.toggle()
            }
          }
      }
    }
  }
}

struct FlipModifier: ViewModifier {
  let angle: Angle
  func body(content: Content) -> some View {
    content.rotation3DEffect(angle, axis: (x: 0.0, y: 1.0, z: 0.0))
  }
}

struct FlipContainerView_Previews: PreviewProvider {
  static var previews: some View {
    FlipContainerView (
    frontView: {
      SampleView(color: .blue)
    },
      backView: {
        SampleView(color: .red)
      }
    )
  }
}
