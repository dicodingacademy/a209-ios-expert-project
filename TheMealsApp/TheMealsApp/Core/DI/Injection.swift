//
//  Injection.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import Foundation
import RealmSwift
import Core
import Category
import SwiftUI

final class Injection: NSObject {

  // 1
  private let realm = try? Realm()

  // 2
  func provideCategory<U: UseCase>() -> U where U.Request == Any, U.Response == [CategoryDomainModel] {

    // 3
    let locale = GetCategoriesLocaleDataSource(realm: realm!)

    // 4
    let remote = GetCategoriesRemoteDataSource(endpoint: Endpoints.Gets.categories.url)

    // 5
    let mapper = CategoryTransformer()

    // 6
    let repository = GetCategoriesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    // 7
    return Interactor(repository: repository) as! U
  }

  private func provideRepository() -> MealRepositoryProtocol {
    let realm = try? Realm()

    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
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
