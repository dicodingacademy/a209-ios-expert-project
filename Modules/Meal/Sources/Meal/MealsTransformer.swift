//
//  File.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Core

public struct MealsTransformer<MealMapper: Mapper>: Mapper
where
    MealMapper.Request == String,
    MealMapper.Response == MealResponse,
    MealMapper.Entity == MealModuleEntity,
    MealMapper.Domain == MealDomainModel {
    
    public typealias Request = String
    public typealias Response = [MealResponse]
    public typealias Entity = [MealModuleEntity]
    public typealias Domain = [MealDomainModel]
    
    private let _mealMapper: MealMapper
    
    public init(mealMapper: MealMapper) {
        _mealMapper = mealMapper
    }
    
    public func transformResponseToEntity(request: String?, response: [MealResponse]) -> [MealModuleEntity] {
        return response.map { result in
            _mealMapper.transformResponseToEntity(request: request, response: result)
        }
    }
    
    public func transformEntityToDomain(entity: [MealModuleEntity]) -> [MealDomainModel] {
        return entity.map { result in
            _mealMapper.transformEntityToDomain(entity: result)
        }
    }
}

