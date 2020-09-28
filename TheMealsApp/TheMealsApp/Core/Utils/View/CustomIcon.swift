//
//  CustomIcon.swift
//  MealsApps
//
//  Created by Ari Supriatna on 19/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct CustomIcon: View {

  var imageName: String
  var title: String

  var body: some View {
    VStack {
      Image(systemName: imageName)
        .font(.system(size: 28))
        .foregroundColor(.orange)

      Text(title)
        .font(.caption)
        .padding(.top, 8)
    }
  }
  
}
