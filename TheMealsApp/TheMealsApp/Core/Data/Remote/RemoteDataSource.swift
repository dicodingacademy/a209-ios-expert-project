//
//  RemoteRepository.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: class {

  func getCategories() -> Observable<[CategoryResponse]>
  
}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {

  func getCategories() -> Observable<[CategoryResponse]> {
    return Observable<[CategoryResponse]>.create { observer in
      if let url = URL(string: Endpoints.Gets.categories.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: CategoriesResponse.self) { response in
            switch response.result {
            case .success(let value):
              observer.onNext(value.categories)
              observer.onCompleted()
            case .failure:
              observer.onError(URLError.invalidResponse)
            }
          }
      }
      return Disposables.create()
    }

  }

}
