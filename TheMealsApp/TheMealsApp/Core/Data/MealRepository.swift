//
//  MealRepository.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import Foundation
import Combine

protocol MealRepositoryProtocol {

  func getCategories() -> AnyPublisher<[CategoryModel], Error>
  func getMeal(by idMeal: String) -> AnyPublisher<MealModel, Error>
  func getMeals(by category: String) -> AnyPublisher<[MealModel], Error>
  func searchMeal(by title: String) -> AnyPublisher<[MealModel], Error>
  func getFavoriteMeals() -> AnyPublisher<[MealModel], Error>
  func updateFavoriteMeal(by idMeal: String) -> AnyPublisher<MealModel, Error>
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

  func getCategories() -> AnyPublisher<[CategoryModel], Error> {
    return self.locale.getCategories()
      .flatMap { result -> AnyPublisher<[CategoryModel], Error> in
        if result.isEmpty {
          return self.remote.getCategories()
            .map { CategoryMapper.mapCategoryResponsesToEntities(input: $0) }
            .catch { _ in self.locale.getCategories() }
            .flatMap { self.locale.addCategories(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getCategories()
              .map { CategoryMapper.mapCategoryEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getCategories()
            .map { CategoryMapper.mapCategoryEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func getMeal(
    by idMeal: String
  ) -> AnyPublisher<MealModel, Error> {
    return self.locale.getMeal(by: idMeal)
      .flatMap { result -> AnyPublisher<MealModel, Error> in
        if result.ingredients.isEmpty {
          return self.remote.getMeal(by: idMeal)
            .map { MealMapper.mapDetailMealResponseToEntity(by: idMeal, input: $0) }
            .catch { _ in self.locale.getMeal(by: idMeal) }
            .flatMap { self.locale.updateMeal(by: idMeal, meal: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getMeal(by: idMeal)
              .map { MealMapper.mapDetailMealEntityToDomain(input: $0) }
            }.eraseToAnyPublisher()
        } else {
          return self.locale.getMeal(by: idMeal)
            .map { MealMapper.mapDetailMealEntityToDomain(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func getMeals(
    by category: String
  ) -> AnyPublisher<[MealModel], Error> {
    return self.locale.getMeals(by: category)
      .flatMap { result -> AnyPublisher<[MealModel], Error> in
        if result.isEmpty {
          return self.remote.getMeals(by: category)
            .map { MealMapper.mapMealResponsesToEntities(by: category, input: $0) }
            .catch { _ in self.locale.getMeals(by: category) }
            .flatMap { self.locale.addMeals(by: category, from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getMeals(by: category)
              .map {  MealMapper.mapMealEntitiesToDomains(input: $0) }
            }.eraseToAnyPublisher()
        } else {
          return self.locale.getMeals(by: category)
            .map { MealMapper.mapMealEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func searchMeal(
    by title: String
  ) -> AnyPublisher<[MealModel], Error> {
    return self.remote.searchMeal(by: title)
      .map { MealMapper.mapDetailMealResponseToEntity(input: $0) }
      .catch { _ in self.locale.getMealsBy(title) }
      .flatMap { responses  in
        self.locale.getMealsBy(title)
          .flatMap { locale -> AnyPublisher<[MealModel], Error> in
            if responses.count > locale.count {
              return self.locale.addMealsBy(title, from: responses)
                .filter { $0 }
                .flatMap { _ in self.locale.getMealsBy(title)
                  .map { MealMapper.mapDetailMealEntityToDomains(input: $0) }
                }.eraseToAnyPublisher()
            } else {
              return self.locale.getMealsBy(title)
                .map { MealMapper.mapDetailMealEntityToDomains(input: $0) }
                .eraseToAnyPublisher()
            }
          }
      }.eraseToAnyPublisher()
  }

  func getFavoriteMeals() -> AnyPublisher<[MealModel], Error> {
    return self.locale.getFavoriteMeals()
      .map { MealMapper.mapMealEntitiesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }

  func updateFavoriteMeal(
    by idMeal: String
  ) -> AnyPublisher<MealModel, Error> {
    return self.locale.updateFavoriteMeal(by: idMeal)
      .map { MealMapper.mapDetailMealEntityToDomain(input: $0) }
      .eraseToAnyPublisher()
  }

}
