//
//  GetMealRepository.swift
//  
//
//  Created by Gilang Ramadhan on 05/12/22.
//

import Core
import Combine

public struct GetMealRepository<
  MealLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository where
  MealLocaleDataSource.Request == String,
  MealLocaleDataSource.Response == MealEntity,
  RemoteDataSource.Request == String,
  RemoteDataSource.Response == MealResponse,
  Transformer.Request == String,
  Transformer.Response == MealResponse,
  Transformer.Entity == MealEntity,
  Transformer.Domain == MealModel
{

  public typealias Request = String
  public typealias Response = MealModel

  private let localeDataSource: MealLocaleDataSource
  private let remoteDataSource: RemoteDataSource
  private let mapper: Transformer

  public init(
    localeDataSource: MealLocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer
  ) {
    self.localeDataSource = localeDataSource
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }

  public func execute(request: String?) -> AnyPublisher<MealModel, Error> {
    guard let request = request else { fatalError("Request cannot be empty") }

    return self.localeDataSource.get(id: request)
      .flatMap { result -> AnyPublisher<MealModel, Error> in
        if result.ingredients.isEmpty {
          return self.remoteDataSource.execute(request: request)
            .map { self.mapper.transformResponseToEntity(request: request, response: $0) }
            .catch { _ in self.localeDataSource.get(id: request) }
            .flatMap { self.localeDataSource.update(id: request, entity: $0) }
            .filter { $0 }
            .flatMap { _ in self.localeDataSource.get(id: request)
                .map { self.mapper.transformEntityToDomain(entity: $0) }
            }.eraseToAnyPublisher()
        } else {
          return self.localeDataSource.get(id: request)
            .map { self.mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
}
