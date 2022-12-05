//
//  GetMealsLocaleDataSource.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetMealsLocaleDataSource : LocaleDataSource {

  public typealias Request = String

  public typealias Response = MealEntity

  private let realm: Realm

  public init(realm: Realm) {
    self.realm = realm
  }

  public func list(request: String?) -> AnyPublisher<[MealEntity], Error> {
    return Future<[MealEntity], Error> { completion in
      guard let request  = request else { return completion(.failure(DatabaseError.requestFailed)) }

      let meals: Results<MealEntity> = {
        self.realm.objects(MealEntity.self)
          .filter("category = '\(request)'")
          .sorted(byKeyPath: "title", ascending: true)
      }()

      completion(.success(meals.toArray(ofType: MealEntity.self)))

    }.eraseToAnyPublisher()
  }

  public func add(entities: [MealEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in

      do {
        try self.realm.write {
          for meal in entities {
            self.realm.add(meal, update: .all)
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }

    }.eraseToAnyPublisher()
  }

  public func get(id: String) -> AnyPublisher<MealEntity, Error> {
    return Future<MealEntity, Error> { completion in

      let meals: Results<MealEntity> = {
        self.realm.objects(MealEntity.self)
          .filter("id = '\(id)'")
      }()

      guard let meal = meals.first else {
        completion(.failure(DatabaseError.requestFailed))
        return
      }

      completion(.success(meal))

    }.eraseToAnyPublisher()
  }

  public func update(id: String, entity: MealEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let mealEntity = {
        self.realm.objects(MealEntity.self).filter("id = '\(id)'")
      }().first {
        do {
          try self.realm.write {
            mealEntity.setValue(entity.area, forKey: "area")
            mealEntity.setValue(entity.instructions, forKey: "instructions")
            mealEntity.setValue(entity.tag, forKey: "tag")
            mealEntity.setValue(entity.youtube, forKey: "youtube")
            mealEntity.setValue(entity.source, forKey: "source")
            mealEntity.setValue(entity.favorite, forKey: "favorite")
            mealEntity.setValue(entity.ingredients, forKey: "ingredients")
          }
          completion(.success(true))

        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
}
