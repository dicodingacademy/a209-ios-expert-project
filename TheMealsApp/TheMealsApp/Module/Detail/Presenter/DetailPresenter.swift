//
//  DetailPresenter.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {

  private var cancellables: Set<AnyCancellable> = []
  private let router = DetailRouter()
  private let detailUseCase: DetailUseCase

  @Published var meals: [MealModel] = []
  @Published var category: CategoryModel
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false

  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
    category = detailUseCase.getCategory()
  }

  func getMeals() {
    isLoading = true
    detailUseCase.getMeals()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { meals in
        self.meals = meals
      })
      .store(in: &cancellables)
  }

  func linkBuilder<Content: View>(
    for meal: MealModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeMealView(for: meal)) { content() }
  }

}
