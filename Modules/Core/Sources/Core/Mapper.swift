//
//  Mapper.swift
//  
//
//  Created by Gilang Ramadhan on 01/12/22.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain

    func transformResponseToEntity(response: Response) -> Entity
    func transformEntityToDomain(entity: Entity) -> Domain
}
