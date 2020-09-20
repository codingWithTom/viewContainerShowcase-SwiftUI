//
//  SidebarContainer.swift
//  ViewContainersShowcase
//
//  Created by Tomas Trujillo on 2020-09-19.
//

import SwiftUI

struct SidebarContainer<Content: View>: View {
  @State private var selectedIndex = 0
  @State private var animate = false
  let views: [(Content, Image)]
  var body: some View {
    GeometryReader { geometry in
      HStack {
        SideView(selectedIndex: $selectedIndex,
                 animate: $animate,
                 size: CGSize(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3),
                 images: views.map { $0.1 }
        )
        ZStack {
          Rectangle().fill(Color.clear)
          views[selectedIndex].0
            .modifier(DrawerEffect(isOn: animate))
        }
      }
    }
  }
}

struct DrawerEffect: GeometryEffect {
  let isOn: Bool
  private var percent: CGFloat
  var animatableData: CGFloat {
    get { return percent }
    set { percent = newValue }
  }
  
  init(isOn: Bool) {
    self.isOn = isOn
    percent = isOn ? 1.0 : 0.0
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    guard percent != 0 && percent != 1 else { return ProjectionTransform(.identity) }
    var transform: CGAffineTransform
    if percent < 0.5 {
      transform = CGAffineTransform(translationX: size.width * percent, y: 0.0)
    } else {
      transform = CGAffineTransform(translationX: size.width * (1 - percent), y: 0.0)
    }
    return ProjectionTransform(transform)
  }
}

extension VerticalAlignment {
  private enum ArrowAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
      return context[VerticalAlignment.center]
    }
  }
  
  static var arrowAlignment: VerticalAlignment {
    return VerticalAlignment(ArrowAlignment.self)
  }
}

struct SideView: View {
  @Binding var selectedIndex: Int
  @Binding var animate: Bool
  let size: CGSize
  let images: [Image]
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      HStack(alignment: .arrowAlignment) {
        Image(systemName: "arrowshape.bounce.forward.fill")
          .font(.title)
          .foregroundColor(.red)
          .alignmentGuide(.arrowAlignment) { d in d[VerticalAlignment.center] }
        VStack {
          ForEach(0 ..< images.count, id: \.self) { index in
            if selectedIndex == index {
              SideImage(image: images[index], width: size.width, height: size.height)
                .alignmentGuide(.arrowAlignment) { d in d[VerticalAlignment.center] }
            } else {
              SideImage(image: images[index], width: size.width, height: size.height)
                .onTapGesture {
                  withAnimation {
                    selectedIndex = index
                    animate.toggle()
                  }
                }
            }
          }
        }
      }
    }
  }
}

struct SideImage: View {
  let image: Image
  let width: CGFloat
  let height: CGFloat
  
  var body: some View {
    image
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: width, height: height)
  }
  
}

struct SidebarContainer_Previews: PreviewProvider {
  static var previews: some View {
    SidebarContainer(views: [
      (AnyView(SampleView(color: .green)), Image(systemName: "rosette")),
      (AnyView(SampleView(color: .red)), Image(systemName: "newspaper.fill")),
      (AnyView(Text("3rd View")), Image(systemName: "greetingcard.fill")),
      (AnyView(Text("4th View")), Image(systemName: "cross.fill"))
    ])
  }
}
