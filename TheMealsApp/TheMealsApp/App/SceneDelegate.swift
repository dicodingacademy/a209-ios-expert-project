//
//  SceneDelegate.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 24/09/20.
//

import UIKit
import SwiftUI
import RealmSwift
import Core
import Category

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    let favoriteUseCase = Injection.init().provideFavorite()
    let searchUseCase = Injection.init().provideSearch()

    let categoryUseCase: Interactor<
        Any,
        [CategoryDomainModel],
        GetCategoriesRepository<
            GetCategoriesLocaleDataSource,
            GetCategoriesRemoteDataSource,
            CategoryTransformer>
    > = Injection.init().provideCategory()
    
    let homePresenter = GetListPresenter(useCase: categoryUseCase)
    let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
    let searchPresenter = SearchPresenter(searchUseCase: searchUseCase)

    let contentView = ContentView()
      .environmentObject(homePresenter)
      .environmentObject(favoritePresenter)
      .environmentObject(searchPresenter)
    
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: contentView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
  
}
