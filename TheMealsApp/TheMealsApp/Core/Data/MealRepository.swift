//
//  MealsRepository.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation
import RxSwift

protocol MealRepositoryProtocol {

  func getCategories() -> Observable<[CategoryModel]>

}

final class MealRepository: NSObject {

  typealias MealInstance = (LocaleDataSource, RemoteDataSource) -> MealRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource

  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }

  static let sharedInstance: MealInstance = { localeRepo, remoteRepo in
    return MealRepository(locale: localeRepo, remote: remoteRepo)
  }

}

extension MealRepository: MealRepositoryProtocol {

  func getCategories() -> Observable<[CategoryModel]> {

    return self.locale.getCategories()
      .map { CategoryMapper.mapCategoryEntitiesToDomains(input: $0) }
      .filter { !$0.isEmpty }
      .ifEmpty(switchTo: self.remote.getCategories()
                .map { CategoryMapper.mapCategoryResponsesToEntities(input: $0) }
                .flatMap { self.locale.addCategories(from: $0) }
                .filter { $0 }
                .flatMap { _ in self.locale.getCategories()
                  .map { CategoryMapper.mapCategoryEntitiesToDomains(input: $0) }
                }
      )

  }
}
