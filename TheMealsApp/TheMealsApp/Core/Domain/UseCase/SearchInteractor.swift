//
//  SearchInteractor.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 29/11/22.
//

import Foundation
import Combine

protocol SearchUseCase {

  func searchMeal(by title: String) -> AnyPublisher<[MealModel], Error>

}

class SearchInteractor: SearchUseCase {

  private let repository: MealRepositoryProtocol

  required init(repository: MealRepositoryProtocol) {
    self.repository = repository
  }

  func searchMeal(by title: String) -> AnyPublisher<[MealModel], Error> {
    return repository.searchMeal(by: title)
  }

}
