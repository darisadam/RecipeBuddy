//
//  Analytics.swift
//  RecipeBuddy
//
//  Created by Adam on 23/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import Foundation
import FirebaseAnalytics
import FirebaseCrashlytics

final class AnalyticsManager {
  
  static let shared = AnalyticsManager()
  
  private init() {}
  
  func logEvent(name: String, params: [String: Any]? = nil) {
    Analytics.logEvent(name, parameters: params)
  }
  
  func setUserId(userId: String) {
    Analytics.setUserID(userId)
  }
  
  func setUserProperty(value: String?, property: String) {
    Analytics.setUserProperty(value, forName: property)
  }
}

struct AnalyticsKey {
  // Home
  static let home = "home"
  static let homeTabSelected = "home_tab_selected"
  static let filter = "filter"
  static let search = "search"
  static let recipeDetail = "recipe_detail"
  
  // Filter
  static let filterRecipe = "filter_recipe"
  static let sortByShortestTimeToPrepare = "sort_by_shortest_time_to_prepare"
  static let sortByLongestTimeToPrepare = "sort_by_longest_time_to_prepare"
  static let clearTagFilter = "clear_tag_filter"
  static let resetSortingFilter = "reset_sorting_filter"
  
  // Recipe Detail
  static let favoriteButtonTapped = "favorite_button_tapped"
  static let unfavoriteButtonTapped = "unfavorite_button_tapped"
  static let ingredientChecklist = "ingredient_checklist"
  static let backTapped = "back_tapped"
  
  // Plan
  static let plan = "plan"
  static let planTabSelected = "plan_tab_selected"
  static let addRecipeToPlan = "add_recipe_to_plan"
  static let clearPlan = "clear_plan"
  static let generateShoppingList = "generate_shopping_list"
  
  // Select Meal
  static let cancelAddToPlan = "cancel_add_to_plan"
  static let addToPlan = "add_to_plan"
  
  // Shopping List
  static let shoppingList = "shopping_list"
  static let refreshShoppingList = "refresh_shopping_list"
  static let shareShoppingList = "share_shopping_list"
  static let backToMealPlanner = "back_to_meal_planner"
  
  // Favorite
  static let favorite = "favorite"
  static let favoriteTabSelected = "favorite_tab_selected"
  static let favoriteRecipeDetail = "favorite_recipe_detail"
  static let removeFromFavorite = "remove_from_favorite"
}
