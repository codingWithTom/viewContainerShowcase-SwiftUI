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

struct SampleView_Previews: PreviewProvider {
  static var previews: some View {
    SampleView(color: .blue)
  }
}
