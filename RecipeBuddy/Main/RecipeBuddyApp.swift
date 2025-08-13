//
//  RecipeBuddyApp.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//

import SwiftUI

@main
struct RecipeBuddyApp: App {
  @StateObject private var viewModel: RecipeViewModel
  
  init() {
    let recipeService = RecipeService(fileName: Constant.recipeFile, remoteURL: Constant.recipesDataUrl)
    _viewModel = StateObject(wrappedValue: RecipeViewModel(recipeService: recipeService))
  }
  
  var body: some Scene {
    WindowGroup {
      TabBarView()
        .environmentObject(viewModel)
    }
  }
}
