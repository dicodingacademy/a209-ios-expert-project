//
//  UseCase.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
