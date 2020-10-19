//
//  ContentView.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 24/09/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI
import Core
import Category

struct ContentView: View {
    @EnvironmentObject var homePresenter: GetListPresenter<Any, CategoryDomainModel, Interactor<Any, [CategoryDomainModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, GetCategoriesRemoteDataSource, CategoryTransformer>>>
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    @EnvironmentObject var searchPresenter: SearchPresenter
    
    var body: some View {
        TabView {
            NavigationView {
                HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }
            
            NavigationView {
                SearchView(presenter: searchPresenter)
            }.tabItem {
                TabItem(imageName: "magnifyingglass", title: "Search")
            }
            
            NavigationView {
                FavoriteView(presenter: favoritePresenter)
            }.tabItem {
                TabItem(imageName: "heart", title: "Favorite")
            }
        }
    }
}
