//
//  StoryContainer.swift
//  ViewContainersShowcase
//
//  Created by Tomas Trujillo on 2021-11-22.
//

import SwiftUI

struct StoryContainer<Content>: View where Content: View {
  let views: [Content]
  @State private var currentIndex = 0
  
  var body: some View {
    ZStack {
      ForEach(views.indices, id: \.self) { index in
        views[index]
          .modifier(FlipModifier(angle: angleFor(index: index)))
          .animation(.linear(duration: 1.0), value: currentIndex)
          .opacity(index == currentIndex ? 1.0 : 0.0)
          .scaleEffect(index == currentIndex ? 1.0 : 0.6)
          .transformEffect(.init(translationX: translationFor(index: index), y: 0.0))
          .animation(.linear(duration: 0.5).delay(0.5), value: currentIndex)
      }
      
      indicator
      
      tapAreas
    }
    .background(Color.black)
  }
  
  private var tapAreas: some View {
    HStack(spacing: 75) {
      Rectangle()
        .fill(Color.clear)
        .contentShape(Rectangle())
        .onTapGesture {
          withAnimation {
            currentIndex = max(currentIndex - 1, 0)
          }
        }
      Spacer()
      Rectangle()
        .fill(Color.clear)
        .contentShape(Rectangle())
        .onTapGesture {
          withAnimation {
            currentIndex = min(currentIndex + 1, views.count - 1)
          }
        }
    }
  }

  private func angleFor(index: Int) -> Angle {
    guard currentIndex != index else { return .degrees(0.0) }
    if index < currentIndex {
      return .degrees(-180)
    } else {
      return .degrees(180)
    }
  }
  
  private func translationFor(index: Int) -> CGFloat {
    guard currentIndex != index else { return 0.0 }
    return UIScreen.main.bounds.width * 0.25 * (index < currentIndex ? -1.0 : 1.0)
  }
  
  private var indicator: some View {
    VStack {
      HStack {
        ForEach(views.indices) { index in
          Rectangle()
            .fill(Color.white.opacity(index == currentIndex ? 1.0 : 0.2))
            .cornerRadius(10)
            .frame(height: 8)
        }
        Spacer()
      }
      .padding()
      .background(
        LinearGradient(
          colors: [.black.opacity(0.6), .black.opacity(0.2)],
          startPoint: .zero,
          endPoint: UnitPoint(x: 0.0, y: 1.0))
      )
      
      Spacer()
    }
  }
}
