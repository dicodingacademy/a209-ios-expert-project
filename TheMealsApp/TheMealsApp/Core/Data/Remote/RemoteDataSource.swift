//
//  RemoteDataSource.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol: AnyObject {

  func getCategories(result: @escaping (Result<[CategoryResponse], URLError>) -> Void)

}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {

  func getCategories(
    result: @escaping (Result<[CategoryResponse], URLError>) -> Void
  ) {
    guard let url = URL(string: Endpoints.Gets.categories.url) else { return }

    AF.request(url)
      .validate()
      .responseDecodable(of: CategoriesResponse.self) { response in
        switch response.result {
        case .success(let value): result(.success(value.categories))
        case .failure: result(.failure(.invalidResponse))
        }
      }
  }

}
