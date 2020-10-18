//
//  DataSource.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
