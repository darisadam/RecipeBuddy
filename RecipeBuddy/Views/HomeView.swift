//
//  ContentView.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var viewModel: RecipeViewModel
  @State private var showFilterAndShort: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        List {
          if viewModel.searchbarText.isNotEmpty && viewModel.filteredAndSortedRecipes.isEmpty {
            Text("\(viewModel.searchbarText) not found")
          } else {
            ForEach(viewModel.filteredAndSortedRecipes) { recipe in
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
      }
      .sheet(isPresented: $showFilterAndShort) {
        FilteringView()
      }
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            showFilterAndShort.toggle()
          } label: {
            Image(systemName: AppImage.line3HorizontalDecreaseIcon)
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
    .searchable(text: $viewModel.searchbarText, prompt: "Search recipe")
  }
}

#Preview {
  HomeView()
    .environmentObject(RecipeViewModel(recipeService: RecipeService(fileName: Constant.recipeFile, remoteURL: Constant.recipesDataUrl)))
}
