//
//  MealMapper.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 30/09/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

final class MealMapper {
  static func mapMealResponsesToEntities(
    by category: String,
    input mealResponses: [MealResponse]
  ) -> [MealEntity] {
    return mealResponses.map { result in
      let newMeal = MealEntity()
      newMeal.id = result.id ?? ""
      newMeal.title = result.title ?? "Unknow"
      newMeal.image = result.image ?? "Unknow"
      newMeal.category = category
      return newMeal
    }
  }

  static func mapMealResponsesToDomains(
    by category: String,
    input mealResponses: [MealResponse]
  ) -> [MealModel] {
    return mealResponses.map { result in
      var newMeal = MealModel(
        id: result.id ?? "",
        title: result.title ?? "Unknow",
        image: result.image ?? "Unknow"
      )
      newMeal.category = category
      return newMeal
    }
  }

  static func mapMealResponsesToDomains(
    input mealResponses: [MealResponse]
  ) -> [MealModel] {
    return mealResponses.map { result in
      let ingredients = IngredientMapper.mapIngredientResponseToDomains(
        by: result.id ?? "",
        input: result
      )
      return MealModel(
        id: result.id ?? "",
        title: result.title ?? "Unknow",
        image: result.image ?? "Unknow",
        category: result.category ?? "Unknow",
        area: result.area ?? "Unknow",
        instructions: result.instructions ?? "Unknow",
        tag: result.tag ?? "Unknow",
        youtube: result.youtube ?? "Unknow",
        source: result.source ?? "Unknow",
        ingredients: ingredients
      )
    }
  }

  static func mapMealEntitiesToDomains(
    input mealEntities: [MealEntity]
  ) -> [MealModel] {
    return mealEntities.map { result in
      let ingredients = IngredientMapper.mapIngredientEntitiesToDomains(
        input: Array(result.ingredients)
      )
      return MealModel(
        id: result.id ,
        title: result.title,
        image: result.image,
        category: result.category,
        area: result.area,
        instructions: result.instructions,
        tag: result.tag,
        youtube: result.youtube,
        source: result.source,
        ingredients: ingredients,
        favorite: result.favorite
      )
    }
  }

  static func mapDetailMealEntityToDomain(
    input mealEntity: MealEntity
  ) -> MealModel {
    let ingredients = IngredientMapper.mapIngredientEntitiesToDomains(
      input: Array(mealEntity.ingredients)
    )
    return MealModel(
      id: mealEntity.id ,
      title: mealEntity.title,
      image: mealEntity.image,
      category: mealEntity.category,
      area: mealEntity.area,
      instructions: mealEntity.instructions,
      tag: mealEntity.tag,
      youtube: mealEntity.youtube,
      source: mealEntity.source,
      ingredients: ingredients,
      favorite: mealEntity.favorite
    )
  }

  static func mapDetailMealEntityToDomains(
    input mealEntities: [MealEntity]
  ) -> [MealModel] {
    return mealEntities.map { result in
      let ingredients = IngredientMapper.mapIngredientEntitiesToDomains(
        input: Array(result.ingredients)
      )
      return MealModel(
        id: result.id ,
        title: result.title,
        image: result.image,
        category: result.category,
        area: result.area,
        instructions: result.instructions,
        tag: result.tag,
        youtube: result.youtube,
        source: result.source,
        ingredients: ingredients,
        favorite: result.favorite
      )
    }
  }

  static func mapDetailMealResponseToEntity(
    by idMeal: String,
    input mealResponse: MealResponse
  ) -> MealEntity {
    let ingredients = IngredientMapper.mapIngredientResponseToEntities(
      by: idMeal,
      input: mealResponse
    )
    let mealEntity = MealEntity()
    mealEntity.id = mealResponse.id ?? ""
    mealEntity.title = mealResponse.title ?? "Unknow"
    mealEntity.image = mealResponse.image ?? "Unknow"
    mealEntity.category = mealResponse.category ?? "Unknow"
    mealEntity.area = mealResponse.area ?? "Unknow"
    mealEntity.instructions = mealResponse.instructions ?? "Unknow"
    mealEntity.tag = mealResponse.tag ?? "Unknow"
    mealEntity.youtube = mealResponse.youtube ?? "Unknow"
    mealEntity.source = mealResponse.source ?? "Unknow"
    mealEntity.ingredients = ingredients
    return mealEntity
  }

  static func mapDetailMealResponseToEntity(
    input mealResponse: [MealResponse]
  ) -> [MealEntity] {
    return mealResponse.map { result in
      let ingredients = IngredientMapper.mapIngredientResponseToEntities(
        by: result.id ?? "",
        input: result
      )
      let mealEntity = MealEntity()
      mealEntity.id = result.id ?? ""
      mealEntity.title = result.title ?? "Unknow"
      mealEntity.image = result.image ?? "Unknow"
      mealEntity.category = result.category ?? "Unknow"
      mealEntity.area = result.area ?? "Unknow"
      mealEntity.instructions = result.instructions ?? "Unknow"
      mealEntity.tag = result.tag ?? "Unknow"
      mealEntity.youtube = result.youtube ?? "Unknow"
      mealEntity.source = result.source ?? "Unknow"
      mealEntity.ingredients = ingredients
      return mealEntity
    }
  }

}
