//
//  GetFavoriteMealsRepository.swift
//  
//
//  Created by Gilang Ramadhan on 05/12/22.
//

import Core
import Combine

public struct GetFavoriteMealsRepository<
  MealLocaleDataSource: LocaleDataSource,
  Transformer: Mapper
>: Repository
where
  MealLocaleDataSource.Request == String,
  MealLocaleDataSource.Response == MealEntity,
  Transformer.Request == String,
  Transformer.Response == [MealResponse],
  Transformer.Entity == [MealEntity],
  Transformer.Domain == [MealModel]
{

  public typealias Request = String
  public typealias Response = [MealModel]

  private let localeDataSource: MealLocaleDataSource
  private let mapper: Transformer

  public init(
    localeDataSource: MealLocaleDataSource,
    mapper: Transformer
  ) {

    self.localeDataSource = localeDataSource
    self.mapper = mapper
  }

  public func execute(request: String?) -> AnyPublisher<[MealModel], Error> {
    return self.localeDataSource.list(request: request)
      .map { self.mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
