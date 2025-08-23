//
//  FavoriteRecipeView.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import SwiftUI

struct FavoriteRecipeView: View {
  @EnvironmentObject private var viewModel: RecipeViewModel
  
  var body: some View {
    NavigationStack {
      List {
        if viewModel.favoriteRecipesList.isEmpty {
          ContentUnavailableView(
            "No Favorite Recipes",
            systemImage: AppImage.starIcon,
            description: Text("Recipes you mark as favorites will appear here.")
          )
        } else {
          ForEach(viewModel.favoriteRecipesList) { recipe in
            NavigationLink(value: recipe.id) {
              HStack {
                RecipeItem(
                  thumbnailURL: recipe.image,
                  title: recipe.title,
                  tags: recipe.tags,
                  estimatedTime: recipe.minutes
                )
                .onTapGesture { AnalyticsManager.shared.logEvent(name: AnalyticsKey.favoriteRecipeDetail) }
              }
            }
            .swipeActions(edge: .trailing) {
              Button("Remove") {
                viewModel.removeFavorite(recipe.id)
                AnalyticsManager.shared.logEvent(name: AnalyticsKey.removeFromFavorite)
              }
              .tint(.red)
            }
          }
        }
      }
      .navigationTitle("Favorites")
      .navigationBarTitleDisplayMode(.large)
      .navigationDestination(
        for: String.self,
        destination: { recipeId in
          RecipeDetailView(recipeId: recipeId)
        }
      )
    }
    .onAppear { AnalyticsManager.shared.logEvent(name: AnalyticsKey.favorite) }
  }
}

#Preview {
    FavoriteRecipeView()
}
