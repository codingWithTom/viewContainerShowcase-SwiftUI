//
//  VerticalCarousel.swift
//  ViewContainersShowcase
//
//  Created by Tomas Trujillo on 2022-02-08.
//

import SwiftUI

struct VerticalCarouselView<Content: View>: View {
  var views: [Content]
  
  var body: some View {
    VStack {
      ScrollView(showsIndicators: false) {
        VStack(spacing: 8.0) {
          Spacer()
            .frame(width: 40)
          
          ForEach(views.indices, id: \.self) { index in
            views[index]
              .hidden()
              .overlay(
                GeometryReader { proxy in
                  let scale = calculateScale(proxy)
                  views[index]
                    .opacity(calculateOpacityWith(proxy))
                    .scaleEffect(x: scale, y: scale, anchor: .center)
                }
              )
              .padding(.vertical)
          }
          
          Spacer()
            .frame(width: 40)
        }
      }
      .padding(.top)
      
      Spacer()
    }
  }
  
  private let percentOfView: CGFloat = 0.4
  private let maxOpacity: CGFloat = 0.4
  private let maxScale: CGFloat = 0.4
  
  private func calculateOpacityWith(_ proxy: GeometryProxy) -> Double {
    let height = UIScreen.main.bounds.height
    let position = proxy.frame(in: .global).midY
    if position < height * percentOfView {
      let maxTopY = height * percentOfView
      let minTopY: CGFloat = 0.0
      let distance = max(minTopY, position)
      let percent = (maxTopY - distance) / (maxTopY - minTopY)
      return 1.0 - maxOpacity * percent
    } else if position > height * (1 - percentOfView) {
      let minBottomY = height * (1 - percentOfView)
      let maxBottomY = height
      let distance = min(maxBottomY, position)
      let percent = (distance - minBottomY) / (maxBottomY - minBottomY)
      return 1.0 - maxOpacity * percent
    } else {
      return 1.0
    }
  }
  
  private func calculateScale(_ proxy: GeometryProxy) -> CGFloat {
    let height = UIScreen.main.bounds.height
    let position = proxy.frame(in: .global).midY
    if position < height * percentOfView {
      let maxTopY = height * percentOfView
      let minTopY: CGFloat = 0.0
      let distance = max(minTopY, position)
      let percent = (maxTopY - distance) / (maxTopY - minTopY)
      return 1.0 - maxScale * percent
    } else if position > height * (1 - percentOfView) {
      let minBottomY = height * (1 - percentOfView)
      let maxBottomY = height
      let distance = min(maxBottomY, position)
      let percent = (distance - minBottomY) / (maxBottomY - minBottomY)
      return 1.0 - maxScale * percent
    } else {
      return 1.0
    }
  }
}
