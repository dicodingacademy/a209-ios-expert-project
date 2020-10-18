//
//  IngredientEntity.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Foundation
import RealmSwift

public class IngredientModuleEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var idMeal: String = ""
    
}
