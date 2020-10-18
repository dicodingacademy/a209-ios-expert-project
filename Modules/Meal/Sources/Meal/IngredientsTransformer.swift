//
//  File.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Core
import RealmSwift

public struct IngredientTransformer: Mapper {
    
    public typealias Request = String
    public typealias Response = MealResponse
    public typealias Entity = List<IngredientEntity>
    public typealias Domain = [IngredientModel]
    
    public init() { }
    
    public func transformResponseToEntity(request: String?, response: MealResponse) -> List<IngredientEntity> {
        let ingredientEntities = List<IngredientEntity>()
        
        var ingredients = [
            response.ingredient1, response.ingredient2,
            response.ingredient3, response.ingredient4,
            response.ingredient5, response.ingredient6,
            response.ingredient7, response.ingredient8,
            response.ingredient9, response.ingredient10,
            response.ingredient11, response.ingredient12,
            response.ingredient13, response.ingredient14,
            response.ingredient15, response.ingredient16,
            response.ingredient17, response.ingredient18,
            response.ingredient19, response.ingredient20
        ].compactMap { $0 }
        
        ingredients = ingredients.filter({ $0 != ""})
        
        var measures = [
            response.measure1, response.measure2,
            response.measure3, response.measure4,
            response.measure5, response.measure6,
            response.measure7, response.measure8,
            response.measure9, response.measure10,
            response.measure11, response.measure12,
            response.measure13, response.measure14,
            response.measure15, response.measure16,
            response.measure17, response.measure18,
            response.measure19, response.measure20
        ].compactMap { $0 }
        
        measures = measures.filter({ $0 != ""})
        
        let ingredientStrings = zip(ingredients, measures)
            .map { "\($0) \($1)" }
        
        for (index, ingredient) in ingredientStrings.enumerated() {
            let ingredientEntity = IngredientEntity()
            
            ingredientEntity.id = "\(index+1)"
            ingredientEntity.title = "\(index+1). \(ingredient)"
            ingredientEntity.idMeal = request ?? ""
            ingredientEntities.append(ingredientEntity)
        }
        
        return ingredientEntities
    }
    
    public func transformEntityToDomain(entity: List<IngredientEntity>) -> [IngredientModel] {
        return entity.map { result in
          return IngredientModel(
            id: result.id,
            title: result.title,
            idMeal: result.idMeal
          )
        }
    }
    
}
