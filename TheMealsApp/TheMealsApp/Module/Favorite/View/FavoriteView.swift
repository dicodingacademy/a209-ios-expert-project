//
//  FavoriteView.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 29/11/22.
//

import SwiftUI

struct FavoriteView: View {

  @ObservedObject var presenter: FavoritePresenter

  var body: some View {
    ZStack {

      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else if presenter.meals.count == 0 {
        emptyFavorites
      } else {
        content
      }
    }.onAppear {
      self.presenter.getFavoriteMeals()
    }.navigationBarTitle(
      Text("Favorite Meals"),
      displayMode: .automatic
    )
  }

}

extension FavoriteView {
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ProgressView()
    }
  }

  var errorIndicator: some View {
    CustomEmptyView(
      image: "assetSearchNotFound",
      title: presenter.errorMessage
    ).offset(y: 80)
  }

  var emptyFavorites: some View {
    CustomEmptyView(
      image: "assetNoFavorite",
      title: "Your favorite is empty"
    ).offset(y: 80)
  }

  var content: some View {
    ScrollView(
      .vertical,
      showsIndicators: false
    ) {
      ForEach(
        self.presenter.meals,
        id: \.id
      ) { meal in
        ZStack {
          self.presenter.linkBuilder(for: meal) {
            FavoriteRow(meal: meal)
          }.buttonStyle(PlainButtonStyle())
        }

      }
    }
  }
}
