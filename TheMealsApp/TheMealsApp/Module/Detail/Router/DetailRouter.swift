//
//  DetailRouter.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 29/11/22.
//

import SwiftUI

class DetailRouter {

  func makeMealView(for meal: MealModel) -> some View {
    let mealUseCase = Injection.init().provideMeal(meal: meal)
    let presenter = MealPresenter(mealUseCase: mealUseCase)
    return MealView(presenter: presenter)
  }

}
