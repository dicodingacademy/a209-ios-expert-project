//
//  CustomEmptyView.swift
//  MealsApps
//
//  Created by Ari Supriatna on 08/09/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct CustomEmptyView: View {
  var image: String
  var title: String
  
  var body: some View {
    VStack {
      Image(image)
        .resizable()
        .renderingMode(.original)
        .scaledToFit()
        .frame(width: 250)
      
      Text(title)
        .font(.system(.body, design: .rounded))
    }
  }
}
