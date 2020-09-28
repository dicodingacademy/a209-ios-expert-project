//
//  HomeView.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct HomeView: View {

  @ObservedObject var presenter: HomePresenter
  
  var body: some View {
    ZStack {
      if presenter.loadingState {
        VStack {
          Text("Loading...")
          ActivityIndicator()
        }
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          ForEach(
            self.presenter.categories,
            id: \.id
          ) { category in
            ZStack {
              self.presenter.linkBuilder(for: category) {
                CategoryRow(category: category)
              }.buttonStyle(PlainButtonStyle())
            }.padding(8)
          }
        }
      }
    }.onAppear {
      if self.presenter.categories.count == 0 {
        self.presenter.getCategories()
      }
    }.navigationBarTitle(
      Text("Meals Apps"),
      displayMode: .automatic
    )
  }

}
