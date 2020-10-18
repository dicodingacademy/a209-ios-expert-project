//
//  File.swift
//  
//
//  Created by Fandy Gotama on 19/10/20.
//

import Foundation
import Combine
import Core

public class MealPresenter<MealUseCase: UseCase, FavoriteUseCase: UseCase>: ObservableObject
where
    MealUseCase.Request == String, MealUseCase.Response == MealModel,
    FavoriteUseCase.Request == String, FavoriteUseCase.Response == MealModel
{
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _mealUseCase: MealUseCase
    private let _favoriteUseCase: FavoriteUseCase
    
    @Published public var item: MealModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(mealUseCase: MealUseCase, favoriteUseCase: FavoriteUseCase) {
        _mealUseCase = mealUseCase
        _favoriteUseCase = favoriteUseCase
    }
    
    public func getMeal(request: MealUseCase.Request) {
        isLoading = true
        _mealUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
    public func updateFavoriteMeal(request: FavoriteUseCase.Request) {
        _favoriteUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
}
