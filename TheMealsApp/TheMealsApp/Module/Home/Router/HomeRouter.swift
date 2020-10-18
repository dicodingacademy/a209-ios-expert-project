//
//  HomeRouter.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 12/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI
import Category
import Core
import Meal

class HomeRouter {
    
    func makeDetailView(for category: CategoryDomainModel) -> some View {
        
        let useCase: Interactor<
            String,
            [MealDomainModel],
            GetMealsRepository<
                GetMealsLocaleDataSource,
                GetMealsRemoteDataSource,
                MealsTransformer<MealTransformer<IngredientTransformer>>>
        > = Injection.init().provideMeals()
        
        let presenter = GetListPresenter(useCase: useCase)
        
        return DetailView(presenter: presenter, category: category)
    }
    
}
