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
    VStack {
      List(viewModel.recipes) { recipe in
        Text(recipe.title)
      }
    }
    .task {
      do {
        try await viewModel.populateRecipeData()
      } catch {
        print(DataError.failedReadingData(error))
      }
    }
  }
}

#Preview {
  HomeView()
    .environmentObject(RecipeViewModel(recipeService: RecipeService(fileName: Constant.recipeFile)))
}
