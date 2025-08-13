//
//  ContentView.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var viewModel: RecipeViewModel
  @State private var showFilter: Bool = false
  @State private var showSort: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        HStack {
          Spacer()
          Button("Filter") { showFilter.toggle() }
          Spacer()
          Button("Sort") { showSort.toggle() }
          Spacer()
        }
        
        List {
          if viewModel.searchbarText.isNotEmpty && viewModel.filteredRecipes.isEmpty {
            Text("\(viewModel.searchbarText) not found")
          } else {
            ForEach(viewModel.filteredRecipes) { recipe in
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
      .popover(isPresented: $showFilter) {
        VStack {
          Text("filter by recipe tags")
            .presentationCompactAdaptation(.popover)
        }
      }
      .popover(isPresented: $showSort) {
        VStack {
          Text("sort by cooking time")
            .presentationCompactAdaptation(.popover)
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
