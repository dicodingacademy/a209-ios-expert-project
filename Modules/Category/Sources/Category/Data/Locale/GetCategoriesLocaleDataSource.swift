//
//  GetCategoriesLocaleDataSource.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetCategoriesLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    
    public typealias Response = CategoryModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    // 1
    public func list(request: Any?) -> AnyPublisher<[CategoryModuleEntity], Error> {
        return Future<[CategoryModuleEntity], Error> { completion in
            let categories: Results<CategoryModuleEntity> = {
              _realm.objects(CategoryModuleEntity.self)
                .sorted(byKeyPath: "title", ascending: true)
            }()
            completion(.success(categories.toArray(ofType: CategoryModuleEntity.self)))
          
        }.eraseToAnyPublisher()
    }

    // 2
    public func add(entities: [CategoryModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for category in entities {
                        _realm.add(category, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
    
    // 3
    public func get(id: String) -> AnyPublisher<CategoryModuleEntity, Error> {
        fatalError()
    }
    
    // 4
    public func update(id: String, entity: CategoryModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
