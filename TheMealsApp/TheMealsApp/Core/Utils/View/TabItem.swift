//
//  TabItem.swift
//  MealsApps
//
//  Created by Ari Supriatna on 24/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct TabItem: View {

  var imageName: String
  var title: String
  var body: some View {
    VStack {
      Image(systemName: imageName)
      Text(title)
    }
  }

}
