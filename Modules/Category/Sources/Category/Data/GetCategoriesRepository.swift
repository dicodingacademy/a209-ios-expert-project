//
//  GetCategoriesRepository.swift
//  
//
//  Created by Gilang Ramadhan on 01/12/22.
//

import Core
import Combine

// 1
public struct GetCategoriesRepository<
  CategoryLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository where
// 2
  CategoryLocaleDataSource.Response == CategoryEntity,
  RemoteDataSource.Response == [CategoryResponse],
  Transformer.Response == [CategoryResponse],
  Transformer.Entity == [CategoryEntity],
  Transformer.Domain == [CategoryModel]
{

  // 3
  public typealias Request = Any
  public typealias Response = [CategoryModel]

  private let localeDataSource: CategoryLocaleDataSource
  private let remoteDataSource: RemoteDataSource
  private let mapper: Transformer

  public init(
    localeDataSource: CategoryLocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {

      self.localeDataSource = localeDataSource
      self.remoteDataSource = remoteDataSource
      self.mapper = mapper
    }

  // 4
  public func execute(request: Any?) -> AnyPublisher<[CategoryModel], Error> {
    return self.localeDataSource.list(request: nil)
      .flatMap { result -> AnyPublisher<[CategoryModel], Error> in
        if result.isEmpty {
          return self.remoteDataSource.execute(request: nil)
            .map { self.mapper.transformResponseToEntity(request: nil, response: $0) }
            .catch { _ in self.localeDataSource.list(request: nil) }
            .flatMap { self.localeDataSource.add(entities: $0) }
            .filter { $0 }
            .flatMap { _ in self.localeDataSource.list(request: nil)
                .map { self.mapper.transformEntityToDomain(entity: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.localeDataSource.list(request: nil)
            .map { self.mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
}
