//
//  DataMapper.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 21/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import RealmSwift

final class CategoryMapper {

  static func mapCategoryResponsesToDomains(
    input categoryResponses: [CategoryResponse]
  ) -> [CategoryModel] {

    return categoryResponses.map { result in
      return CategoryModel(
        id: result.id ?? "",
        title: result.title ?? "Unknow",
        image: result.image ?? "Unknow",
        description: result.description ?? "Unknow"
      )
    }
  }
  
}
