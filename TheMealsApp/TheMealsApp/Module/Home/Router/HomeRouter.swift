//
//  HomeRouter.swift
//  TheMealsApp
//
//  Created by Gilang Ramadhan on 22/11/22.
//

import SwiftUI

class HomeRouter {

  func makeDetailView(for category: CategoryModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(category: category)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }

}
