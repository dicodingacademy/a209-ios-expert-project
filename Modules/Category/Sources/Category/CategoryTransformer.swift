//
//  CategoryTransformer.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Core

public struct CategoryTransformer: Mapper {
    public typealias Request = Any
    public typealias Response = [CategoryResponse]
    public typealias Entity = [CategoryModuleEntity]
    public typealias Domain = [CategoryDomainModel]
    
    public init() {}
    
    public func transformResponseToEntity(request: Any?, response: [CategoryResponse]) -> [CategoryModuleEntity] {
        return response.map { result in
          let newCategory = CategoryModuleEntity()
          newCategory.id = result.id ?? ""
          newCategory.title = result.title ?? "Unknown"
          newCategory.image = result.image ?? "Unknown"
          newCategory.desc = result.description ?? "Unknown"
          return newCategory
        }
    }
    
    public func transformEntityToDomain(entity: [CategoryModuleEntity]) -> [CategoryDomainModel] {
        return entity.map { result in
          return CategoryDomainModel(
            id: result.id,
            title: result.title,
            image: result.image,
            description: result.desc
          )
        }
    }
}
