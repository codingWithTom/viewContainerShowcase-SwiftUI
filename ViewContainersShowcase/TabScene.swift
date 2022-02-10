//
//  TabScene.swift
//  ViewContainersShowcase
//
//  Created by Tomas Trujillo on 2020-09-19.
//

import SwiftUI

struct TabScene: View {
  var body: some View {
    TabView {
      StoryContainer(views: [
        SampleImage(name: "image1"),
        SampleImage(name: "image2"),
        SampleImage(name: "image3"),
        SampleImage(name: "image4"),
        SampleImage(name: "image5")
      ])
        .clipped()
      .tabItem {
        Image(systemName: "arrowshape.turn.up.forward.circle")
        Text("Flip")
      }
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
      .tabItem {
        Image(systemName: "square.stack.3d.down.right.fill")
        Text("Card Stack")
      }
      SidebarContainer(views: [
        (AnyView(SampleView(color: .green)), Image(systemName: "rosette")),
        (AnyView(SampleView(color: .red)), Image(systemName: "newspaper.fill")),
        (AnyView(Text("3rd View")), Image(systemName: "greetingcard.fill")),
        (AnyView(Text("4th View")), Image(systemName: "cross.fill"))
      ])
      .tabItem {
        Image(systemName: "sidebar.squares.leading")
        Text("Sidebar")
      }
      CarouselView(views: [
        randomRectangle(),
        randomRectangle(),
        randomRectangle(),
        randomRectangle(),
        randomRectangle()
      ]).tabItem {
        Image(systemName: "rectangle.on.rectangle.circle")
        Text("Carousel")
      }
      VerticalCarouselView(views: [
        randomScreenRectangle(),
        randomScreenRectangle(),
        randomScreenRectangle(),
        randomScreenRectangle(),
        randomScreenRectangle()
      ]).tabItem {
        Image(systemName: "l.joystick.tilt.down.fill")
        Text("Vertical Carousel")
      }
    }
  }
  
  @ViewBuilder
  private func randomRectangle() -> some View {
    let colors: [Color] = [.orange, .green, .blue, .cyan, .red, .yellow]
    RoundedRectangle(cornerRadius: 16)
      .fill(colors.randomElement() ?? .orange)
      .overlay(RoundedRectangle(cornerRadius: 16).stroke(.black))
      .frame(width: 200, height: 150)
  }
  
  @ViewBuilder
  private func randomScreenRectangle() -> some View {
    let colors: [Color] = [.orange, .green, .blue, .cyan, .red, .yellow]
    let width = UIScreen.main.bounds.width * 0.90
    RoundedRectangle(cornerRadius: 16)
      .fill(colors.randomElement() ?? .orange)
      .overlay(RoundedRectangle(cornerRadius: 16).stroke(.black))
      .frame(width: width, height: width * 0.65)
  }
}

struct TabScene_Previews: PreviewProvider {
  static var previews: some View {
    TabScene()
  }
}
