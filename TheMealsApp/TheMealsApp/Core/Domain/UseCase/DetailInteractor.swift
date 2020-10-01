//
//  DetailUseCase.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 28/09/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation
import Combine

protocol DetailUseCase {

  func getCategory() -> CategoryModel
  func getMeals() -> AnyPublisher<[MealModel], Error>

}

class DetailInteractor: DetailUseCase {

  private let repository: MealRepositoryProtocol
  private let category: CategoryModel

  required init(
    repository: MealRepositoryProtocol,
    category: CategoryModel
  ) {
    self.repository = repository
    self.category = category
  }

  func getCategory() -> CategoryModel {
    return category
  }

  func getMeals() -> AnyPublisher<[MealModel], Error> {
    return repository.getMeals(by: category.title)
  }
  
}
