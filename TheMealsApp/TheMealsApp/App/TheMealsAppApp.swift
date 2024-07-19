//
//  TheMealsAppApp.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import SwiftUI

@main
struct TheMealsAppApp: App {
  let homePresenter = HomePresenter(homeUseCase: Injection.shared.provideHome())

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
    }
  }
}
