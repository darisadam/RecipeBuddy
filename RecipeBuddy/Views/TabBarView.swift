//
//  TabBarView.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
  @EnvironmentObject private var viewModel: RecipeViewModel
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Label("Home", systemImage: "house.fill")
        }
      
      WeeklyPlanView()
        .tabItem {
          Label("Plan", systemImage: "calendar")
        }
      
      FavoriteRecipeView()
        .tabItem {
          Label("Favorite", systemImage: "star.fill")
        }
    }
  }
}

#Preview {
  TabBarView()
    .environmentObject(RecipeViewModel(recipeService: RecipeService(fileName: Constant.recipeFile, remoteURL: Constant.recipesDataUrl)))
}
