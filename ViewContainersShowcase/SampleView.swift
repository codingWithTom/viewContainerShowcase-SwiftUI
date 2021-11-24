//
//  SampleView.swift
//  ViewContainersShowcase
//
//  Created by Tomas Trujillo on 2020-09-19.
//

import SwiftUI

struct SampleView: View {
  let color: Color
  var body: some View {
    ZStack {
      Rectangle().fill(Color.clear)
      VStack {
        Text("Color \(color.description)")
      }
    }
    .background(color)
  }
}

struct SampleImage: View {
  let name: String
  var body: some View {
    GeometryReader { geometry in
      Image(name)
        .resizable()
        .scaledToFill()
        .frame(width: geometry.size.width, height: geometry.size.height)
    }
  }
}

struct SampleView_Previews: PreviewProvider {
  static var previews: some View {
    SampleView(color: .blue)
  }
}
