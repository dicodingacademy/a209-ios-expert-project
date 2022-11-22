//
//  LocaleDataStore.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import Foundation
import RealmSwift

protocol LocaleDataSourceProtocol: AnyObject {

  func getCategories(result: @escaping (Result<[CategoryEntity], DatabaseError>) -> Void)
  func addCategories(
    from categories: [CategoryEntity],
    result: @escaping (Result<Bool, DatabaseError>) -> Void
  )

}

final class LocaleDataSource: NSObject {

  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }

}

extension LocaleDataSource: LocaleDataSourceProtocol {

  func getCategories(
    result: @escaping (Result<[CategoryEntity], DatabaseError>) -> Void
  ) {
    if let realm = realm {
      let categories: Results<CategoryEntity> = {
        realm.objects(CategoryEntity.self)
          .sorted(byKeyPath: "title", ascending: true)
      }()
      result(.success(categories.toArray(ofType: CategoryEntity.self)))
    } else {
      result(.failure(.invalidInstance))
    }
  }

  func addCategories(
    from categories: [CategoryEntity],
    result: @escaping (Result<Bool, DatabaseError>) -> Void
  ) {
    if let realm = realm {
      do {
        try realm.write {
          for category in categories {
            realm.add(category, update: .all)
          }
          result(.success(true))
        }
      } catch {
        result(.failure(.requestFailed))
      }
    } else {
      result(.failure(.invalidInstance))
    }
  }

}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
