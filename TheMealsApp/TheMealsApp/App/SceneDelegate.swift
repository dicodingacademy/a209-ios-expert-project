//
//  SceneDelegate.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 24/09/20.
//

import UIKit
import SwiftUI
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    let homeUseCase = Injection.init().provideHome()
    let favoriteUseCase = Injection.init().provideFavorite()
    let searchUseCase = Injection.init().provideSearch()

    let homePresenter = HomePresenter(homeUseCase: homeUseCase)
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
