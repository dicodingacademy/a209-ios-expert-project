//
//  TheMealsAppApp.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import SwiftUI
import RealmSwift
import Core
import Category
import Meal

let injection = Injection()

let categoryUseCase: Interactor<
  Any,
  [CategoryModel],
  GetCategoriesRepository<
    GetCategoriesLocaleDataSource,
    GetCategoriesRemoteDataSource,
    CategoryTransformer>
> = injection.provideCategory()

let favoriteUseCase: Interactor<
    String,
    [MealModel],
    GetFavoriteMealsRepository<
        GetFavoriteMealsLocaleDataSource,
        MealsTransformer<MealTransformer<IngredientTransformer>>>
> = injection.provideFavorite()

let searchUseCase: Interactor<
    String,
    [MealModel],
    SearchMealsRepository<
        GetMealsRemoteDataSource,
        MealsTransformer<MealTransformer<IngredientTransformer>>>
> = injection.provideSearch()

@main
struct TheMealsAppApp: SwiftUI.App {

  let homePresenter = GetListPresenter(useCase: categoryUseCase)
  let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
  let searchPresenter = SearchPresenter(useCase: searchUseCase)

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(favoritePresenter)
        .environmentObject(searchPresenter)
    }
  }
}
