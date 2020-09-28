//
//  Color+Extension.swift
//  MealsApps
//
//  Created by Ari Supriatna on 19/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//
import SwiftUI

extension Color {

  static var random: Color {
    return Color(
      red: .random(in: 0...1),
      green: .random(in: 0...1),
      blue: .random(in: 0...1)
    )
  }
  
}
