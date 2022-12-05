//
//  CategoryTransformer.swift
//  
//
//  Created by Gilang Ramadhan on 01/12/22.
//

import Foundation
import Core

public struct CategoryTransformer: Mapper {
  public typealias Request = Any
  public typealias Response = [CategoryResponse]
  public typealias Entity = [CategoryEntity]
  public typealias Domain = [CategoryModel]

  public init() {}

  public func transformResponseToEntity(request: Any?, response: [CategoryResponse]) -> [CategoryEntity] {
    return response.map { result in
      let newCategory = CategoryEntity()
      newCategory.id = result.id ?? ""
      newCategory.title = result.title ?? "Unknown"
      newCategory.image = result.image ?? "Unknown"
      newCategory.desc = result.description ?? "Unknown"
      return newCategory
    }
  }

  public func transformEntityToDomain(entity: [CategoryEntity]) -> [CategoryModel] {
    return entity.map { result in
      return CategoryModel(
        id: result.id,
        title: result.title,
        image: result.image,
        description: result.desc
      )
    }
  }
}
