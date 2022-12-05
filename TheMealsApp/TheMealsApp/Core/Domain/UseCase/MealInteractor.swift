//
//  MealInteractor.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 29/11/22.
//

import Foundation
import Combine

protocol MealUseCase {

  func getMeal() -> AnyPublisher<MealModel, Error>
  func getMeal() -> MealModel
  func updateFavoriteMeal() -> AnyPublisher<MealModel, Error>

}

class MealInteractor: MealUseCase {

  private let repository: MealRepositoryProtocol
  private let meal: MealModel

  required init(
    repository: MealRepositoryProtocol,
    meal: MealModel
  ) {
    self.repository = repository
    self.meal = meal
  }

  func getMeal() -> AnyPublisher<MealModel, Error> {
    return repository.getMeal(by: meal.id)
  }

  func getMeal() -> MealModel {
    return meal
  }

  func updateFavoriteMeal() -> AnyPublisher<MealModel, Error> {
    return repository.updateFavoriteMeal(by: meal.id)
  }

}
