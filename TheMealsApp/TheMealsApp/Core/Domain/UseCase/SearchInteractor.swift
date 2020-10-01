//
//  SearchInteractor.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 01/10/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
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
