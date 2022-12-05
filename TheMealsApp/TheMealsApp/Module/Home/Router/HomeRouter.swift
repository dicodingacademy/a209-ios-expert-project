//
//  HomeRouter.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import SwiftUI
import Category
import Core
import Meal

class HomeRouter {

  func makeDetailView(for category: CategoryModel) -> some View {

    let useCase: Interactor<
      String,
      [MealModel],
      GetMealsRepository<
        GetMealsLocaleDataSource,
        GetMealsRemoteDataSource,
        MealsTransformer<MealTransformer<IngredientTransformer>>>
    > = Injection.init().provideMeals()

    let presenter = GetListPresenter(useCase: useCase)

    return DetailView(presenter: presenter, category: category)
  }

}
