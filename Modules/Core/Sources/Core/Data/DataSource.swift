//
//  DataSource.swift
//  
//
//  Created by Gilang Ramadhan on 01/12/22.
//

import Combine

public protocol DataSource {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
