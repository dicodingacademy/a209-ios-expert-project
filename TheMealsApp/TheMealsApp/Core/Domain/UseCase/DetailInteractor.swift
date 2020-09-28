//
//  DetailUseCase.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 28/09/20.
//

import Foundation

protocol DetailUseCase {

  func getCategory() -> CategoryModel

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

}
