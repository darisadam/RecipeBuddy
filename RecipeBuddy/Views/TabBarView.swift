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
          Label("Home", systemImage: AppImage.houseFillIcon)
            .onTapGesture { AnalyticsManager.shared.logEvent(name: AnalyticsKey.homeTabSelected) }
        }
      
      WeeklyPlanView()
        .tabItem {
          Label("Plan", systemImage: AppImage.calendarIcon)
            .onTapGesture { AnalyticsManager.shared.logEvent(name: AnalyticsKey.planTabSelected) }
        }
      
      FavoriteRecipeView()
        .tabItem {
          Label("Favorite", systemImage: AppImage.starFillIcon)
            .onTapGesture { AnalyticsManager.shared.logEvent(name: AnalyticsKey.favoriteTabSelected) }
        }
    }
  }
}

#Preview {
  TabBarView()
    .environmentObject(RecipeViewModel(recipeService: RecipeService(fileName: Constant.recipeFile, remoteURL: Constant.recipesDataUrl)))
}
