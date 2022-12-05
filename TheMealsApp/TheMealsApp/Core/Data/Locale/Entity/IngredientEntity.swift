//
//  IngredientEntity.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 29/11/22.
//

import Foundation
import RealmSwift

class IngredientEntity: Object {

  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var idMeal: String = ""

}
