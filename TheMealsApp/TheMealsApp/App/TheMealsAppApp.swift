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

let categoryUseCase: Interactor<
  Any,
  [CategoryDomainModel],
  GetCategoriesRepository<
    GetCategoriesLocaleDataSource,
    GetCategoriesRemoteDataSource,
    CategoryTransformer>
> = Injection.init().provideCategory()


@main
struct TheMealsAppApp: SwiftUI.App {

  let homePresenter = GetListPresenter(useCase: categoryUseCase)
  let favoritePresenter = FavoritePresenter(favoriteUseCase: Injection.init().provideFavorite())
  let searchPresenter = SearchPresenter(searchUseCase: Injection.init().provideSearch())

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(favoritePresenter)
        .environmentObject(searchPresenter)
    }
  }
}
