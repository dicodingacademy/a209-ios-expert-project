//
//  SearchMealsRepository.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import Core
import Combine

public struct SearchMealsRepository<
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == [MealResponse],
    Transformer.Request == String,
    Transformer.Response == [MealResponse],
    Transformer.Entity == [MealEntity],
    Transformer.Domain == [MealModel] {
    
    public typealias Request = String
    public typealias Response = [MealModel]
    
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[MealModel], Error> {
        
        return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToEntity(request: request, response: $0) }
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        
    }
}
