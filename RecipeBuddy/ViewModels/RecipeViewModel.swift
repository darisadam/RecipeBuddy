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
  @Published var selectedTags: Set<String> = []
  @Published private(set) var sortOrder: SortOrder? = nil
  @Published var currentMealPlan: MealPlan = MealPlan()
  
  let recipeService: RecipeService
  let recipeStorage = UserDefaults.standard
  
  init(recipeService: RecipeService) {
    self.recipeService = recipeService
    self.favoriteRecipes = Set(recipeStorage.array(forKey: Constant.favorites) as? [String] ?? [])
  }
  
  // MARK: - Filter Data by Search Query
  
  var filteredRecipes: [Recipe] {
    let query = searchbarText.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if query.isNotEmpty {
      let normalizedQuery = normalizeSearchText(query)
      return recipes.filter { normalizeSearchText($0.title).contains(normalizedQuery) }
    } else {
      return recipes
    }
  }
  
  // MARK: - Filter Data by Tags and Sort
  
  var availableTags: [String] {
    let allTags = recipes.flatMap { $0.tags }
    return Array(Set(allTags)).sorted()
  }
  
  var tagFilteredRecipes: [Recipe] {
    if selectedTags.isEmpty {
      return filteredRecipes
    } else {
      return filteredRecipes.filter {
        $0.tags.contains(where: selectedTags.contains)
      }
    }
  }
  
  var filteredAndSortedRecipes: [Recipe] {
    let filtered = tagFilteredRecipes
    
    guard let sortOrder = sortOrder else {
      return filtered
    }
    
    switch sortOrder {
    case .ascending:
      return filtered.sorted { $0.minutes < $1.minutes }
    case .descending:
      return filtered.sorted { $0.minutes > $1.minutes }
    }
  }
  
  func toggleTagFilter(_ tag: String) {
    if selectedTags.contains(tag) {
      selectedTags.remove(tag)
    } else {
      selectedTags.insert(tag)
    }
  }
  
  func removeTagFilter(_ tag: String) {
    selectedTags.remove(tag)
  }
  
  func clearAllFilters() {
    selectedTags.removeAll()
  }
  
  func setSortOrder(_ order: SortOrder?) {
    sortOrder = order
  }
  
  // MARK: - Default Populate Data
  
  func populateRecipeData() async throws {
    recipes = try await recipeService.loadRecipe(localPath: Constant.recipeFile, remotePath: Constant.recipesDataUrl)
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
  var favoriteRecipesList: [Recipe] {
    return recipes.filter { favoriteRecipes.contains($0.id) }
  }
  
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
    recipeStorage.set(Array(self.favoriteRecipes), forKey: Constant.favorites)
  }
}

// MARK: - Meal Planner With Shopping List Handler

extension RecipeViewModel {
  func addRecipeToDay(_ day: DayOfWeek, recipeId: String) {
    if currentMealPlan.dailyMeals[day] == nil {
      currentMealPlan.dailyMeals[day] = []
    }
    currentMealPlan.dailyMeals[day]?.append(recipeId)
    saveMealPlan()
  }
  
  func removeRecipeFromDay(_ day: DayOfWeek, recipeId: String) {
    currentMealPlan.dailyMeals[day]?.removeAll { $0 == recipeId }
    saveMealPlan()
  }
  
  func getRecipesForDay(_ day: DayOfWeek) -> [Recipe] {
    let recipeIds = currentMealPlan.dailyMeals[day] ?? []
    return recipeIds.compactMap { id in
      recipes.first { $0.id == id }
    }
  }
  
  func clearMealPlan() {
    currentMealPlan = MealPlan()
    saveMealPlan()
  }
  
  func generateShoppingList() -> [ShoppingList] {
    var ingredientMap: [String: ShoppingList] = [:]
    
    let allPlannedRecipes = DayOfWeek.allCases.flatMap { day in
      getRecipesForDay(day)
    }
    
    for recipe in allPlannedRecipes {
      for ingredient in recipe.ingredients {
        let normalizedName = ingredient.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if var existing = ingredientMap[normalizedName] {
          existing.totalQuantity = mergeQuantities(existing.totalQuantity, ingredient.quantity)
          existing.sources.append(recipe.title)
          ingredientMap[normalizedName] = existing
        } else {
          ingredientMap[normalizedName] = ShoppingList(
            name: ingredient.name,
            totalQuantity: ingredient.quantity,
            sources: [recipe.title]
          )
        }
      }
    }
    
    return Array(ingredientMap.values).sorted { $0.name < $1.name }
  }
  
  private func mergeQuantities(_ quantity1: String, _ quantity2: String) -> String {
    return "\(quantity1) + \(quantity2)"
  }
  
  private func saveMealPlan() {
    if let encoded = try? JSONEncoder().encode(currentMealPlan) {
      recipeStorage.set(encoded, forKey: "currentMealPlan")
    }
  }
  
  func loadMealPlan() {
    if let data = recipeStorage.data(forKey: "currentMealPlan"),
       let decoded = try? JSONDecoder().decode(MealPlan.self, from: data) {
      currentMealPlan = decoded
    }
  }
}
