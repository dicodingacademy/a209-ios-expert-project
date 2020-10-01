//
//  DetailRouter.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 01/10/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

class DetailRouter {

  func makeMealView(for meal: MealModel) -> some View {
    let mealUseCase = Injection.init().provideMeal(meal: meal)
    let presenter = MealPresenter(mealUseCase: mealUseCase)
    return MealView(presenter: presenter)
  }

}
