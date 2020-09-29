//
//  HomeInteractor.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 24/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
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
