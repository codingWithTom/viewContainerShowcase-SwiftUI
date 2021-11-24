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
    }
  }
}

struct TabScene_Previews: PreviewProvider {
  static var previews: some View {
    TabScene()
  }
}
