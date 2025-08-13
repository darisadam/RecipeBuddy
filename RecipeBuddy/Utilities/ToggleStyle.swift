//
//  ToggleStyle.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    HStack {
      Image(systemName: configuration.isOn ? AppImage.checkmarkSquareIcon : AppImage.squareIcon)
        .resizable()
        .frame(width: 24, height: 24)
        .onTapGesture { configuration.isOn.toggle() }
      
      configuration.label
    }
  }
}
