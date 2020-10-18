//
//  Repository.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Combine

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
