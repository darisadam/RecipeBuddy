//
//  ContentView.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var viewModel: RecipeViewModel
  
  var body: some View {
    NavigationStack {
      VStack {
        List {
          ForEach(viewModel.recipes) { recipe in
            NavigationLink(value: recipe.id) {
              RecipeItem(
                thumbnailURL: recipe.image,
                title: recipe.title,
                tags: recipe.tags,
                estimatedTime: recipe.minutes
              )
            }
          }
        }
      }
      .navigationDestination(
        for: String.self,
        destination: { recipeId in
          RecipeDetailView(recipeId: recipeId)
        }
      )
      .task {
        do {
          try await viewModel.populateRecipeData()
        } catch {
          print(DataError.failedReadingData(error))
        }
      }
    }
  }
}

#Preview {
  HomeView()
    .environmentObject(RecipeViewModel(recipeService: RecipeService(fileName: Constant.recipeFile)))
}
