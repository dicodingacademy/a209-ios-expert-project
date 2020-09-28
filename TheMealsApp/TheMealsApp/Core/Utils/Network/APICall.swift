//
//  Endpoints.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

struct API {

  static let baseUrl = "https://www.themealdb.com/api/json/v1/1/"

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
  
  enum Gets: Endpoint {
    case categories
    case meals
    case meal
    case search
    
    public var url: String {
      switch self {
      case .categories: return "\(API.baseUrl)categories.php"
      case .meals: return "\(API.baseUrl)filter.php?c="
      case .meal: return "\(API.baseUrl)lookup.php?i="
      case .search: return "\(API.baseUrl)search.php?s="
      }
    }
  }
  
}
