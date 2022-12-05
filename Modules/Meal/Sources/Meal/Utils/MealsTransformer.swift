//
//  MealsTransformer.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Core

public struct MealsTransformer<
  MealMapper: Mapper
>: Mapper where
  MealMapper.Request == String,
  MealMapper.Response == MealResponse,
  MealMapper.Entity == MealEntity,
  MealMapper.Domain == MealModel
{

  public typealias Request = String
  public typealias Response = [MealResponse]
  public typealias Entity = [MealEntity]
  public typealias Domain = [MealModel]

  private let mealMapper: MealMapper

  public init(mealMapper: MealMapper) {
    self.mealMapper = mealMapper
  }

  public func transformResponseToEntity(
    request: String?,
    response: [MealResponse]
  ) -> [MealEntity] {
    return response.map { result in
      self.mealMapper.transformResponseToEntity(request: request, response: result)
    }
  }

  public func transformEntityToDomain(
    entity: [MealEntity]
  ) -> [MealModel] {
    return entity.map { result in
      return self.mealMapper.transformEntityToDomain(entity: result)
    }
  }
}

