//
//  ContentView.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 24/09/20.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter

  var body: some View {
    NavigationView {
      HomeView(presenter: homePresenter)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
