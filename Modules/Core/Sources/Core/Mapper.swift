//
//  Mapper.swift
//  
//
//  Created by Fandy Gotama on 19/10/20.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToEntity(response: Response) -> Entity
    func transformEntityToDomain(entity: Entity) -> Domain
}

