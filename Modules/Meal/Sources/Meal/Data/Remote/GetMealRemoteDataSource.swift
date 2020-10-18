//
//  File.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetMealRemoteDataSource : DataSource {
    
    public typealias Request = String
    
    public typealias Response = MealResponse
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        
        return Future<MealResponse, Error> { completion in
            
            guard let request = request else { return completion(.failure(URLError.invalidRequest) )}
            
            if let url = URL(string: _endpoint + request) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MealsResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.meals[0]))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}

