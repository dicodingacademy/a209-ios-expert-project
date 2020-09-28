//
//  HomeInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 24/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol HomeUseCase {

  func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)

}

class HomeInteractor: HomeUseCase {

  private let repository: MealRepositoryProtocol
  
  required init(repository: MealRepositoryProtocol) {
    self.repository = repository
  }
  
  func getCategories(
    completion: @escaping (Result<[CategoryModel], Error>) -> Void
  ) {
    repository.getCategories { result in
      completion(result)
    }
  }

}
