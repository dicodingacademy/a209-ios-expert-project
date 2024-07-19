//
//  Injection.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import Foundation
import RealmSwift
import Swinject

final class Injection {
  
  static let shared = Injection()

  let container: Container

  private init() {
    container = Container()

    container.register(Realm.self) { _ in
      try! Realm()
    }

    container.register(LocaleDataSource.self) { resolver in
      let realm = resolver.resolve(Realm.self)
      return LocaleDataSource.sharedInstance(realm)
    }

    container.register(RemoteDataSource.self) { resolver in
      return RemoteDataSource.sharedInstance
    }

    container.register(MealRepositoryProtocol.self) { resolver in
      let locale = resolver.resolve(LocaleDataSource.self)!
      let remote = resolver.resolve(RemoteDataSource.self)!
      return MealRepository.sharedInstance(locale, remote)
    }

    container.register(HomeUseCase.self) { resolver in
      let repository = resolver.resolve(MealRepositoryProtocol.self)!
      return HomeInteractor(repository: repository)
    }

    container.register(DetailUseCase.self) { (resolver, category: CategoryModel) in
      let repository = resolver.resolve(MealRepositoryProtocol.self)!
      return DetailInteractor(repository: repository, category: category)
    }
  }

  func provideHome() -> HomeUseCase {
    return container.resolve(HomeUseCase.self)!
  }

  func provideDetail(category: CategoryModel) -> DetailUseCase {
    return container.resolve(DetailUseCase.self, argument: category)!
  }

}
