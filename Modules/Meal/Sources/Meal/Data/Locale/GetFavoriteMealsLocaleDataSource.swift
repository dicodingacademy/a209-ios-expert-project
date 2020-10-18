//
//  File.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetFavoriteMealsLocaleDataSource : LocaleDataSource {
    
    public typealias Request = String
    
    public typealias Response = MealEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[MealEntity], Error> {
        return Future<[MealEntity], Error> { completion in
            
            let mealEntities = {
                _realm.objects(MealEntity.self)
                    .filter("favorite = \(true)")
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            completion(.success(mealEntities.toArray(ofType: MealEntity.self)))
            
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [MealEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: String) -> AnyPublisher<MealEntity, Error> {
        
        return Future<MealEntity, Error> { completion in
            if let mealEntity = {
                _realm.objects(MealEntity.self).filter("id = '\(id)'")
            }().first {
                do {
                    try _realm.write {
                        mealEntity.setValue(!mealEntity.favorite, forKey: "favorite")
                    }
                    completion(.success(mealEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func update(id: String, entity: MealEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
