//
//  Injection.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import Foundation
import RealmSwift

final class Injection: NSObject {

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
