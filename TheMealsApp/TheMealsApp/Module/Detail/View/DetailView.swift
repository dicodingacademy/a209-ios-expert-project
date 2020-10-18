//
//  DetailView.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 13/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Meal
import Category

struct DetailView: View {
    @ObservedObject var presenter: GetListPresenter<String, MealModel, Interactor<String, [MealModel], GetMealsRepository<GetMealsLocaleDataSource, GetMealsRemoteDataSource, MealsTransformer<MealTransformer<IngredientTransformer>>>>>
    
    var category: CategoryModel
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isLoading {
                errorIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageCategory
                        spacer
                        content
                        spacer
                    }.padding()
                }
            }
        }.onAppear {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: category.title)
            }
        }.navigationBarTitle(Text(category.title), displayMode: .large)
    }
}

extension DetailView {
    var spacer: some View {
        Spacer()
    }
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var imageCategory: some View {
        WebImage(url: URL(string: category.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 250.0, height: 250.0, alignment: .center)
    }
    
    var mealsHorizontal: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(self.presenter.list, id: \.id) { meal in
                    ZStack {
                        self.linkBuilder(for: meal) {
                            MealRow(meal: meal)
                                .frame(width: 150, height: 150)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
    
    var description: some View {
        Text(category.description)
            .font(.system(size: 15))
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !presenter.list.isEmpty {
                headerTitle("Meals from \(category.title)")
                    .padding(.bottom)
                mealsHorizontal
            }
            spacer
            headerTitle("Description")
                .padding([.top, .bottom])
            description
        }
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
