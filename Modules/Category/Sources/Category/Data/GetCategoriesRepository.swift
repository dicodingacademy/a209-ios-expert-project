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
  Transformer: Mapper>: Repository
where
// 2
CategoryLocaleDataSource.Response == CategoryModuleEntity,
RemoteDataSource.Response == [CategoryResponse],
Transformer.Response == [CategoryResponse],
Transformer.Entity == [CategoryModuleEntity],
Transformer.Domain == [CategoryDomainModel] {

  // 3
  public typealias Request = Any
  public typealias Response = [CategoryDomainModel]

  private let _localeDataSource: CategoryLocaleDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: CategoryLocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {

      _localeDataSource = localeDataSource
      _remoteDataSource = remoteDataSource
      _mapper = mapper
    }

  // 4
  public func execute(request: Any?) -> AnyPublisher<[CategoryDomainModel], Error> {
    return _localeDataSource.list(request: nil)
      .flatMap { result -> AnyPublisher<[CategoryDomainModel], Error> in
        if result.isEmpty {
          return _remoteDataSource.execute(request: nil)
            .map { _mapper.transformResponseToEntity(response: $0) }
            .catch { _ in _localeDataSource.list(request: nil) }
            .flatMap { _localeDataSource.add(entities: $0) }
            .filter { $0 }
            .flatMap { _ in _localeDataSource.list(request: nil)
                .map { _mapper.transformEntityToDomain(entity: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return _localeDataSource.list(request: nil)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
}
