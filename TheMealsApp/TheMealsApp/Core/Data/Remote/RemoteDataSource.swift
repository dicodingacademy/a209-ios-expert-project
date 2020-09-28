//
//  RemoteRepository.swift
//  MealsApps
//
//  Created by Gilang Ramadhan on 11/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

protocol RemoteDataSourceProtocol: class {

  func getCategories(result: @escaping (Result<[CategoryResponse], URLError>) -> Void)
  func getMeals(by category: String, result: @escaping (Result<[MealResponse], URLError>) -> Void)
  func getMeal(by id: String, result: @escaping (Result<MealResponse, URLError>) -> Void)
  
}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {

  func getCategories(
    result: @escaping (Result<[CategoryResponse], URLError>) -> Void
  ) {
    guard let url = URL(string: Endpoints.Gets.categories.url) else { return }

    let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
      if maybeError != nil {
        result(.failure(.addressUnreachable(url)))
      } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
        let decoder = JSONDecoder()
        do {
          let categories = try decoder.decode(CategoriesResponse.self, from: data).categories
          result(.success(categories))
        } catch {
          result(.failure(.invalidResponse))
        }
      }
    }
    task.resume()

  }

  func getMeals(
    by category: String,
    result: @escaping (Result<[MealResponse], URLError>) -> Void
  ) {
    guard let url = URL(string: Endpoints.Gets.meals.url + category) else { return }

    let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
      if maybeError != nil {
        result(.failure(.addressUnreachable(url)))
      } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
        let decoder = JSONDecoder()
        do {
          let meals = try decoder.decode(MealsResponse.self, from: data).meals
          result(.success(meals))
        } catch {
          result(.failure(.invalidResponse))
        }
      }
    }
    task.resume()

  }

  func getMeal(
    by id: String,
    result: @escaping (Result<MealResponse, URLError>) -> Void
  ) {
    guard let url = URL(string: Endpoints.Gets.meal.url + id) else { return }

    let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
      if maybeError != nil {
        result(.failure(.addressUnreachable(url)))
      } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
        let decoder = JSONDecoder()
        do {
          let meal = try decoder.decode(MealsResponse.self, from: data).meals[0]
          result(.success(meal))
        } catch {
          result(.failure(.invalidResponse))
        }
      }
    }
    task.resume()
    
  }

  func searchMeal(
    by title: String,
    result: @escaping (Result<[MealResponse], URLError>) -> Void
  ) {
    guard let url = URL(string: Endpoints.Gets.search.url + title) else { return }

    let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
      if maybeError != nil {
        result(.failure(.addressUnreachable(url)))
      } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
        let decoder = JSONDecoder()
        do {
          let meals = try decoder.decode(MealsResponse.self, from: data).meals
          result(.success(meals))
        } catch {
          result(.failure(.invalidResponse))
        }
      }
    }
    task.resume()
    
  }

}
