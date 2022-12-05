//
//  MealRow.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 29/11/22.
//

import Foundation
import SwiftUI
import CachedAsyncImage

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
        EmptyView().frame(
          width: geometry.size.width,
          height: 32
        ).blur(radius: 20)

        self.titleMeal
      }
    }.cornerRadius(12)
  }
}

extension MealRow {

  var imageMeal: some View {
    CachedAsyncImage(url: URL(string: self.meal.image)) { image in
      image.resizable()
    } placeholder: {
      ProgressView()
    }.scaledToFit()
  }

  var titleMeal: some View {
    Text(self.meal.title)
      .font(.system(size: 14))
      .lineLimit(1)
      .foregroundColor(.white)
      .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
  }

}
