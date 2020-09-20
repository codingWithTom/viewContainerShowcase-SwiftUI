//
//  CardStackContainerView.swift
//  ViewContainersShowcase
//
//  Created by Tomas Trujillo on 2020-09-19.
//

import SwiftUI

struct CardStackContainerView<Content: View>: View {
  @State var content: [Content]
  
  var rotation: Angle {
    return Angle(degrees: Double.random(in: -20 ... 20))
  }
  
  var offset: CGFloat {
    return CGFloat.random(in: -10 ... 10)
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Rectangle().fill(Color.clear)
        ForEach(0 ..< content.count, id: \.self) { index in
          SwipeableView(
            content: {
              content[index]
              .cornerRadius(20.0)
              .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.3)
              .contentShape(Rectangle())
              .rotationEffect(rotation)
              .offset(x: offset, y: offset)
            },
            slack: geometry.size.width * 0.3,
            onSwipeAction: {
              withAnimation {
                content.remove(at: index)
              }
            }
          )
        }
      }
    }
  }
}

struct SwipeableView<SwipeContent: View>: View {
  let slack: CGFloat
  let content: SwipeContent
  let onSwipeAction: () -> Void
  @State private var offset: CGPoint = .zero
  @State private var totalOffset: CGPoint = .zero
  
  init(@ViewBuilder content: @escaping () -> SwipeContent, slack: CGFloat, onSwipeAction: @escaping () -> Void) {
    self.content = content()
    self.slack = slack
    self.onSwipeAction = onSwipeAction
  }
  
  var body: some View {
    content
      .offset(x: offset.x, y: offset.y)
      .gesture(DragGesture()
                .onChanged { gesture in
                  self.totalOffset.x += self.offset.x - gesture.translation.width
                  self.totalOffset.y += self.offset.y - gesture.translation.height
                  self.offset = CGPoint(x: gesture.translation.width, y: gesture.translation.height)
                }
                .onEnded { value in
                  if abs(self.totalOffset.x) > slack || abs(self.totalOffset.y) > slack {
                    self.onSwipeAction()
                  } else {
                    withAnimation {
                      self.totalOffset = .zero
                      self.offset = .zero
                    }
                  }
                }
      )
  }
}

struct CardStackContainerView_Previews: PreviewProvider {
  static var previews: some View {
    CardStackContainerView(content: [
      SampleView(color: .green),
      SampleView(color: .blue),
      SampleView(color: .red),
      SampleView(color: .yellow),
      SampleView(color: .orange),
      SampleView(color: .green),
      SampleView(color: .blue),
      SampleView(color: .red),
      SampleView(color: .yellow),
      SampleView(color: .orange)
    ])
  }
}
