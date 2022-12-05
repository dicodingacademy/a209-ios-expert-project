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
  Transformer: Mapper
>: Repository where
  RemoteDataSource.Request == String,
  RemoteDataSource.Response == [MealResponse],
  Transformer.Request == String,
  Transformer.Response == [MealResponse],
  Transformer.Entity == [MealEntity],
  Transformer.Domain == [MealModel]
{

  public typealias Request = String
  public typealias Response = [MealModel]

  private let remoteDataSource: RemoteDataSource
  private let mapper: Transformer

  public init(
    remoteDataSource: RemoteDataSource,
    mapper: Transformer
  ) {
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }

  public func execute(request: String?) -> AnyPublisher<[MealModel], Error> {

    return self.remoteDataSource.execute(request: request)
      .map { self.mapper.transformResponseToEntity(request: request, response: $0) }
      .map { self.mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()

  }
}
