//
//  CategoriesResponse.swift
//  
//
//  Created by Gilang Ramadhan on 1/12/22.
//

import Foundation

public struct CategoriesResponse: Decodable {
  let categories: [CategoryResponse]
}

public struct CategoryResponse: Decodable {

  private enum CodingKeys: String, CodingKey {
    case id = "idCategory"
    case title = "strCategory"
    case image = "strCategoryThumb"
    case description = "strCategoryDescription"
  }

  let id: String?
  let title: String?
  let image: String?
  let description: String?
}

