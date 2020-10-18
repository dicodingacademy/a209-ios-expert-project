//
//  ContentView.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 24/09/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI
import Category
import Meal
import Core

struct ContentView: View {
    @EnvironmentObject var homePresenter: GetListPresenter<Any, CategoryModel, Interactor<Any, [CategoryModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, GetCategoriesRemoteDataSource, CategoryTransformer>>>
    @EnvironmentObject var favoritePresenter: GetListPresenter<String, MealModel, Interactor<String, [MealModel], GetFavoriteMealsRepository<GetFavoriteMealsLocaleDataSource, MealsTransformer<MealTransformer<IngredientTransformer>>>>>
    @EnvironmentObject var searchPresenter: Core.SearchPresenter<MealModel, Interactor<String, [MealModel], SearchMealsRepository<GetMealsRemoteDataSource, MealsTransformer<MealTransformer<IngredientTransformer>>>>>
    
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
