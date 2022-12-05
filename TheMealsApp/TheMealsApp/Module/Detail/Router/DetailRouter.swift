//
//  DetailRouter.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 29/11/22.
//

import SwiftUI
import Category
import Core
import Meal

class DetailRouter {

  func makeMealView(for meal: MealModel) -> some View {
    let useCase: Interactor<
      String,
      MealModel,
      GetMealRepository<
        GetMealsLocaleDataSource,
        GetMealRemoteDataSource,
        MealTransformer<IngredientTransformer>>
    > = Injection.init().provideMeal()

    let favoriteUseCase: Interactor<
      String,
      MealModel,
      UpdateFavoriteMealRepository<
        GetFavoriteMealsLocaleDataSource,
        MealTransformer<IngredientTransformer>>
    > = Injection.init().provideUpdateFavorite()

    let presenter = MealPresenter(mealUseCase: useCase, favoriteUseCase: favoriteUseCase)

    return MealView(presenter: presenter, meal: meal)
  }
}
