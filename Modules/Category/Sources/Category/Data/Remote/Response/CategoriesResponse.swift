//
//  CategoriesResponse.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
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
