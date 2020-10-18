//
//  CategoryModel.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Foundation

public struct CategoryDomainModel: Equatable, Identifiable {

    public let id: String
    public let title: String
    public let image: String
    public let description: String
  
    public init(id: String, title: String, image: String, description: String) {
        self.id = id
        self.title = title
        self.image = image
        self.description = description
    }
}
