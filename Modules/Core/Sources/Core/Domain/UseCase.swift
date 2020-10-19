//
//  File.swift
//  
//
//  Created by Fandy Gotama on 19/10/20.
//

import Foundation
import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
