//
//  HomeInteractor.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import Foundation
import RxSwift

protocol HomeUseCase {

  func getCategories() -> Observable<[CategoryModel]>

}

class HomeInteractor: HomeUseCase {

  private let repository: MealRepositoryProtocol

  required init(repository: MealRepositoryProtocol) {
    self.repository = repository
  }

  func getCategories() -> Observable<[CategoryModel]> {
    return repository.getCategories()
  }

}
