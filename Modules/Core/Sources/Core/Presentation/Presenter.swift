//
//  File.swift
//  
//
//  Created by Fandy Gotama on 18/10/20.
//

import SwiftUI
import Combine

public class Presenter<
  Request,
  Response,
  Interactor: UseCase
>: ObservableObject where
  Interactor.Request == Request,
  Interactor.Response == Response
{
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let useCase: Interactor
  
  @Published public var item: Response?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  
  public init(useCase: Interactor) {
    self.useCase = useCase
  }
  
  public func execute(request: Request?) {
    isLoading = true
    self.useCase.execute(request: request)
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
  
  
}

