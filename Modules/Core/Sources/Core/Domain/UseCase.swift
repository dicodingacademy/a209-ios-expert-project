//
//  Usecase.swift
//  
//
//  Created by Gilang Ramadhan on 01/12/22.
//

import Foundation
import Combine

public protocol UseCase {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
