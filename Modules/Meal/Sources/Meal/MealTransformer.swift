//
//  File.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Core
import RealmSwift

public struct MealTransformer<IngredientMapper: Mapper>: Mapper
where
    IngredientMapper.Request == String,
    IngredientMapper.Response == MealResponse,
    IngredientMapper.Entity == List<IngredientEntity>,
    IngredientMapper.Domain == [IngredientModel] {
    
    public typealias Request = String
    public typealias Response = MealResponse
    public typealias Entity = MealEntity
    public typealias Domain = MealModel
    
    private let _ingredientMapper: IngredientMapper
    
    public init(ingredientMapper: IngredientMapper) {
        _ingredientMapper = ingredientMapper
    }
    
    public func transformResponseToEntity(request: String?, response: MealResponse) -> MealEntity {
        let ingredients = _ingredientMapper.transformResponseToEntity(request: request, response: response)
        
        let mealEntity = MealEntity()
        
        mealEntity.id = response.id ?? ""
        mealEntity.title = response.title ?? "Unknown"
        mealEntity.image = response.image ?? "Unknown"
        mealEntity.category = response.category ?? request ?? "Unknown"
        mealEntity.area = response.area ?? "Unknown"
        mealEntity.instructions = response.instructions ?? "Unknown"
        mealEntity.tag = response.tag ?? "Unknown"
        mealEntity.youtube = response.youtube ?? "Unknown"
        mealEntity.source = response.source ?? "Unknown"
        mealEntity.ingredients = ingredients
        
        return mealEntity
    }
    
    public func transformEntityToDomain(entity: MealEntity) -> MealModel {
        let ingredients = _ingredientMapper.transformEntityToDomain(entity: entity.ingredients)
        
        return MealModel(
            id: entity.id ,
            title: entity.title,
            image: entity.image,
            category: entity.category,
            area: entity.area,
            instructions: entity.instructions,
            tag: entity.tag,
            youtube: entity.youtube,
            source: entity.source,
            ingredients: ingredients,
            favorite: entity.favorite
        )
    }
}


