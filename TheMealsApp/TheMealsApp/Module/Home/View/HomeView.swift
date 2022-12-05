//
//  HomeView.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import SwiftUI
import Core
import Category

struct HomeView: View {

  @ObservedObject var presenter: GetListPresenter<Any, CategoryDomainModel, Interactor<Any, [CategoryDomainModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, GetCategoriesRemoteDataSource, CategoryTransformer>>>

  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else if presenter.list.isEmpty {
        emptyCategories
      } else {
        content
      }
    }.onAppear {
      if self.presenter.list.count == 0 {
        self.presenter.getList(request: nil)
      }
    }.navigationBarTitle(
      Text("Meals Apps"),
      displayMode: .automatic
    )
  }

}

extension HomeView {

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

  var emptyCategories: some View {
    CustomEmptyView(
      image: "assetNoFavorite",
      title: "The meal category is empty"
    ).offset(y: 80)
  }

  var content: some View {
    ScrollView(.vertical, showsIndicators: false) {
      ForEach(
        self.presenter.list,
        id: \.id
      ) { category in
//        ZStack {
//          self.presenter.linkBuilder(for: category) {
//            CategoryRow(category: category)
//          }.buttonStyle(PlainButtonStyle())
//        }.padding(8)

        ZStack {
          CategoryRow(category: category)
        }.buttonStyle(PlainButtonStyle())
      }
    }
  }

}
