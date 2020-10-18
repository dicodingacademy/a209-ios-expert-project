//
//  MealRow.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 01/10/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Meal

struct MealRow: View {
  var meal: MealModel

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .bottomLeading) {
        self.imageMeal
          .frame(
            width: geometry.size.width,
            height: geometry.size.height,
            alignment: .center
        )
        self.blurView
          .frame(
            width: geometry.size.width,
            height: 32
        )
        self.titleMeal
      }
    }.cornerRadius(12)
  }
}

extension MealRow {
  var blurView: some View {
    BlurView()
  }

  var imageMeal: some View {
    WebImage(url: URL(string: self.meal.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
  }

  var titleMeal: some View {
    Text(self.meal.title)
      .font(.system(size: 14))
      .lineLimit(1)
      .foregroundColor(.white)
      .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
  }

}
