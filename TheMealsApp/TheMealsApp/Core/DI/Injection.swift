//
//  MealBuilder.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 12/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit
import Category
import Core
import Meal

final class Injection: NSObject {
    
    func provideCategory<U: UseCase>() -> U where U.Request == Any, U.Response == [CategoryDomainModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetCategoriesLocaleDataSource(realm: appDelegate.realm)
        
        let remote = GetCategoriesRemoteDataSource(endpoint: Endpoints.Gets.categories.url)
        
        let mapper = CategoryTransformer()
        
        let repository = GetCategoriesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideMeals<U: UseCase>() -> U where U.Request == String, U.Response == [MealDomainModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetMealsLocaleDataSource(realm: appDelegate.realm)
        
        let remote = GetMealsRemoteDataSource(endpoint: Endpoints.Gets.meals.url)
        
        let ingredientMapper = IngredientTransformer()
        let mealMapper = MealTransformer(ingredientMapper: ingredientMapper)
        
        let mapper = MealsTransformer(mealMapper: mealMapper)
        
        let repository = GetMealsRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    private func provideRepository() -> MealRepositoryProtocol {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(appDelegate.realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return MealRepository.sharedInstance(locale, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(category: CategoryModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, category: category)
    }
    
    func provideMeal(meal: MealModel) -> MealUseCase {
        let repository = provideRepository()
        return MealInteractor(repository: repository, meal: meal)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
    func provideSearch() -> SearchUseCase {
        let repository = provideRepository()
        return SearchInteractor(repository: repository)
    }
    
}
