//
//  CarouselView.swift
//  ViewContainersShowcase
//
//  Created by Tomas Trujillo on 2022-02-08.
//

import SwiftUI

struct CarouselView<Content: View>: View {
  var views: [Content]
  
  var body: some View {
    VStack {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8.0) {
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
  
  private let percentOfView: CGFloat = 0.3
  private let maxOpacity: CGFloat = 0.3
  private let maxScale: CGFloat = 0.25
  
  private func calculateOpacityWith(_ proxy: GeometryProxy) -> Double {
    let width = UIScreen.main.bounds.width
    let position = proxy.frame(in: .global).midX
    if position < width * percentOfView {
      let maxTrailingX = width * percentOfView
      let minTrailingX: CGFloat = 0.0
      let distance = max(minTrailingX, position)
      let percent = (maxTrailingX - distance) / (maxTrailingX - minTrailingX)
      return 1.0 - maxOpacity * percent
    } else if position > width * (1 - percentOfView) {
      let minLeadingX = width * (1 - percentOfView)
      let maxLeadingX = width
      let distance = min(maxLeadingX, position)
      let percent = (distance - minLeadingX) / (maxLeadingX - minLeadingX)
      return 1.0 - maxOpacity * percent
    } else {
      return 1.0
    }
  }
  
  private func calculateScale(_ proxy: GeometryProxy) -> CGFloat {
    let width = UIScreen.main.bounds.width
    let position = proxy.frame(in: .global).midX
    if position < width * percentOfView {
      let maxTrailingX = width * percentOfView
      let minTrailingX: CGFloat = 0.0
      let distance = max(minTrailingX, position)
      let percent = (maxTrailingX - distance) / (maxTrailingX - minTrailingX)
      return 1.0 - maxScale * percent
    } else if position > width * (1 - percentOfView) {
      let minLeadingX = width * (1 - percentOfView)
      let maxLeadingX = width
      let distance = min(maxLeadingX, position)
      let percent = (distance - minLeadingX) / (maxLeadingX - minLeadingX)
      return 1.0 - maxScale * percent
    } else {
      return 1.0
    }
  }
}
