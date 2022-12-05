//
//  SearchView.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 29/11/22.
//

import SwiftUI
import Core
import Meal

struct SearchView: View {
  
  @ObservedObject var presenter: SearchPresenter<MealModel, Interactor<String, [MealModel], SearchMealsRepository<GetMealsRemoteDataSource, MealsTransformer<MealTransformer<IngredientTransformer>>>>>
  
  var body: some View {
    VStack {
      Spacer()
      ZStack {
        if presenter.isLoading {
          loadingIndicator
        } else if presenter.keyword.isEmpty {
          emptyTitle
        } else if presenter.list.isEmpty {
          emptyMeals
        } else if presenter.isError {
          errorIndicator
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(
              self.presenter.list,
              id: \.id
            ) { meal in
              ZStack {
                self.linkBuilder(for: meal) {
                  SearchRow(meal: meal)
                }.buttonStyle(PlainButtonStyle())
              }.padding(8)
            }
          }
        }
      }.searchable(text: $presenter.keyword)
        .onSubmit(of: .search, presenter.search)
      Spacer()
    }.navigationBarTitle(
      Text("Search Meals"),
      displayMode: .automatic
    )
  }
}

extension SearchView {
  
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
  
  var emptyTitle: some View {
    CustomEmptyView(
      image: "assetSearchMeal",
      title: "Come on, find your favorite food!"
    ).offset(y: 50)
  }
  var emptyMeals: some View {
    CustomEmptyView(
      image: "assetSearchNotFound",
      title: "Data not found"
    ).offset(y: 80)
  }

  func linkBuilder<Content: View>(
    for meal: MealModel,
    @ViewBuilder content: () -> Content
  ) -> some View {

    NavigationLink(
      destination: DetailRouter().makeMealView(for: meal)
    ) { content() }
  }
  
}
