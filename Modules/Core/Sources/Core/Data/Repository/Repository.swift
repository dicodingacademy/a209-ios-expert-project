//
//  Repository.swift
//  
//
//  Created by Gilang Ramadhan on 01/12/22.
//

import Combine

public protocol Repository {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
