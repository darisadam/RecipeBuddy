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
  @Published var favoriteRecipes: Set<String> = []
  @Published var searchbarText: String = ""
  
  let recipeService: RecipeService
  let recipeStorage = UserDefaults.standard
  
  init(recipeService: RecipeService) {
    self.recipeService = recipeService
    self.favoriteRecipes = Set(recipeStorage.array(forKey: "favorites") as? [String] ?? [])
  }
  
  var filteredRecipes: [Recipe] {
    let query = searchbarText.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if query.isNotEmpty {
      let normalizedQuery = normalizeSearchText(query)
      return recipes.filter { normalizeSearchText($0.title).contains(normalizedQuery) }
    } else {
      return recipes
    }
  }
  
  func populateRecipeData() async throws {
    recipes = try await recipeService.loadRecipe(from: Constant.recipeFile)
  }
  
  func populateRecipeById(_ id: String) -> Recipe? {
    guard let index = recipes.firstIndex(where: { $0.id == id }) else {
      return nil
    }
    
    return recipes[index]
  }
  
  private func normalizeSearchText(_ text: String) -> String {
    text.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
  }
}

// MARK: - Add To Favorite Handler

extension RecipeViewModel {
  func contains(_ recipeId: String) -> Bool {
    favoriteRecipes.contains(recipeId)
  }
  
  func addFavorite(_ recipeId: String) {
    favoriteRecipes.insert(recipeId)
    save()
  }
  
  func removeFavorite(_ recipeId: String) {
    favoriteRecipes.remove(recipeId)
    save()
  }
  
  private func save() {
    recipeStorage.set(Array(self.favoriteRecipes), forKey: "favorites")
  }
}
