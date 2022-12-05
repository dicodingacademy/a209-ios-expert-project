//
//  Injection.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import UIKit
import Category
import Core
import Meal
import RealmSwift

final class Injection: NSObject {

  private let realm = try? Realm()

  func provideCategory<U: UseCase>() -> U where U.Request == Any, U.Response == [CategoryModel] {

    let locale = GetCategoriesLocaleDataSource(realm: realm!)

    let remote = GetCategoriesRemoteDataSource(endpoint: Endpoints.Gets.categories.url)

    let mapper = CategoryTransformer()

    let repository = GetCategoriesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideMeals<U: UseCase>() -> U where U.Request == String, U.Response == [MealModel] {
    let locale = GetMealsLocaleDataSource(realm: realm!)

    let remote = GetMealsRemoteDataSource(endpoint: Endpoints.Gets.meals.url)

    let ingredientMapper = IngredientTransformer()
    let mealMapper = MealTransformer(ingredientMapper: ingredientMapper)
    let mapper = MealsTransformer(mealMapper: mealMapper)

    let repository = GetMealsRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideSearch<U: UseCase>() -> U where U.Request == String, U.Response == [MealModel] {
    let remote = GetMealsRemoteDataSource(endpoint: Endpoints.Gets.search.url)

    let ingredientMapper = IngredientTransformer()
    let mealMapper = MealTransformer(ingredientMapper: ingredientMapper)
    let mapper = MealsTransformer(mealMapper: mealMapper)

    let repository = SearchMealsRepository(
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideMeal<U: UseCase>() -> U where U.Request == String, U.Response == MealModel {
    let locale = GetMealsLocaleDataSource(realm: realm!)

    let remote = GetMealRemoteDataSource(endpoint: Endpoints.Gets.meal.url)

    let ingredientMapper = IngredientTransformer()
    let mapper = MealTransformer(ingredientMapper: ingredientMapper)

    let repository = GetMealRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideUpdateFavorite<U: UseCase>() -> U where U.Request == String, U.Response == MealModel {
    let locale = GetFavoriteMealsLocaleDataSource(realm: realm!)

    let ingredientMapper = IngredientTransformer()
    let mapper = MealTransformer(ingredientMapper: ingredientMapper)

    let repository = UpdateFavoriteMealRepository(
      localeDataSource: locale,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideFavorite<U: UseCase>() -> U where U.Request == String, U.Response == [MealModel] {
    let locale = GetFavoriteMealsLocaleDataSource(realm: realm!)

    let ingredientMapper = IngredientTransformer()
    let mealMapper = MealTransformer(ingredientMapper: ingredientMapper)
    let mapper = MealsTransformer(mealMapper: mealMapper)

    let repository = GetFavoriteMealsRepository(
      localeDataSource: locale,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }
}
