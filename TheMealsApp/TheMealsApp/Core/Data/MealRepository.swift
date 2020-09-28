//
//  MealsRepository.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol MealRepositoryProtocol {

  func getCategories(result: @escaping (Result<[CategoryModel], Error>) -> Void)

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

  func getCategories(
    result: @escaping (Result<[CategoryModel], Error>) -> Void
  ) {
    locale.getCategories { localeResponses in
      switch localeResponses {
      case .success(let categoryEntity):
        let categoryList = CategoryMapper.mapCategoryEntitiesToDomains(input: categoryEntity)
        if categoryList.isEmpty {
          self.remote.getCategories { remoteResponses in
            switch remoteResponses {
            case .success(let categoryResponses):
              let categoryEntities = CategoryMapper.mapCategoryResponsesToEntities(input: categoryResponses)
              self.locale.addCategories(from: categoryEntities) { addState in
                switch addState {
                case .success(let resultFromAdd):
                  let resultList = CategoryMapper.mapCategoryEntitiesToDomains(input: resultFromAdd)
                  result(.success(resultList))
                case .failure(let error): result(.failure(error))
                }
              }
            case .failure(let error): result(.failure(error))
            }
          }
        } else {
          result(.success(categoryList))
        }
      case .failure(let error): result(.failure(error))
      }
    }
  }
}
