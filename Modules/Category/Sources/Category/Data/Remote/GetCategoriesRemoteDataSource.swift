//
//  File.swift
//  
//
//  Created by Fandy Gotama on 19/10/20.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetCategoriesRemoteDataSource : DataSource {
    public typealias Request = Any
    
    public typealias Response = [CategoryResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Any?) -> AnyPublisher<[CategoryResponse], Error> {
        return Future<[CategoryResponse], Error> { completion in
          if let url = URL(string: _endpoint) {
            AF.request(url)
              .validate()
              .responseDecodable(of: CategoriesResponse.self) { response in
                switch response.result {
                case .success(let value):
                  completion(.success(value.categories))
                case .failure:
                  completion(.failure(URLError.invalidResponse))
                }
              }
          }
        }.eraseToAnyPublisher()
    }
}

