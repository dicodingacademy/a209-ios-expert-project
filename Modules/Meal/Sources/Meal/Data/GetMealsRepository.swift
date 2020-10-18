//
//  File.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Core
import Combine

public struct GetMealsRepository<
    MealLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    MealLocaleDataSource.Request == String,
    MealLocaleDataSource.Response == MealEntity,
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == [MealResponse],
    Transformer.Request == String,
    Transformer.Response == [MealResponse],
    Transformer.Entity == [MealEntity],
    Transformer.Domain == [MealModel] {
    
    public typealias Request = String
    public typealias Response = [MealModel]
    
    private let _localeDataSource: MealLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: MealLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[MealModel], Error> {
        return _localeDataSource.list(request: request)
          .flatMap { result -> AnyPublisher<[MealModel], Error> in
            if result.isEmpty {
                return _remoteDataSource.execute(request: request)
                    .map { _mapper.transformResponseToEntity(request: request, response: $0) }
                    .catch { _ in _localeDataSource.list(request: request) }
                    .flatMap {  _localeDataSource.add(entities: $0) }
                .filter { $0 }
                    .flatMap { _ in _localeDataSource.list(request: request)
                        .map {  _mapper.transformEntityToDomain(entity: $0) }
                }.eraseToAnyPublisher()
            } else {
                return _localeDataSource.list(request: request)
                    .map { _mapper.transformEntityToDomain(entity: $0) }
                .eraseToAnyPublisher()
            }
          }.eraseToAnyPublisher()
    }
}
