//
//  GetCategoriesLocaleDataSource.swift
//  
//
//  Created by Gilang Ramadhan on 01/12/22.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetCategoriesLocaleDataSource: LocaleDataSource {

  public typealias Request = Any

  public typealias Response = CategoryEntity

  private let realm: Realm

  public init(realm: Realm) {
    self.realm = realm
  }

  public func list(request: Any?) -> AnyPublisher<[CategoryEntity], Error> {
    return Future<[CategoryEntity], Error> { completion in
      let categories: Results<CategoryEntity> = {
        self.realm.objects(CategoryEntity.self)
          .sorted(byKeyPath: "title", ascending: true)
      }()
      completion(.success(categories.toArray(ofType: CategoryEntity.self)))

    }.eraseToAnyPublisher()
  }

  public func add(entities: [CategoryEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try self.realm.write {
          for category in entities {
            self.realm.add(category, update: .all)
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }

    }.eraseToAnyPublisher()
  }

  public func get(id: String) -> AnyPublisher<CategoryEntity, Error> {
    fatalError()
  }

  public func update(id: String, entity: CategoryEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
