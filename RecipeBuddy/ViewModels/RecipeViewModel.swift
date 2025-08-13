//
//  RecipeViewModel.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
  @Published private(set) var recipes: [Recipe] = []
  
  let recipeService: RecipeService
  
  init(recipeService: RecipeService) {
    self.recipeService = recipeService
  }
  
  func populateRecipeData() async throws {
    recipes = try await recipeService.loadRecipe(from: Constant.recipeFile)
  }
}
