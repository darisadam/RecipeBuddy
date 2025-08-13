//
//  RecipeDetailView.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import SwiftUI

struct RecipeDetailView: View {
  @EnvironmentObject private var viewModel: RecipeViewModel
  @Environment(\.dismiss) private var dismiss
  @State private var ingredientStates: [String: Bool] = [:]
  
  let recipeId: String
  
  var body: some View {
    if let recipe = viewModel.populateRecipeById(recipeId) {
      ScrollView(.vertical, showsIndicators: false) {
        
        // MARK: - Header Image
        
        AsyncImage(url: URL(string: recipe.image)) { image in
          image
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .clipShape(Rectangle())
            .ignoresSafeArea()
        } placeholder: {
          Color.gray
            .frame(maxWidth: .infinity)
            .frame(height: 300)
        }
        
        VStack(alignment: .leading) {
          
          // MARK: - Recipe Description
          
          HStack {
            VStack(alignment: .leading) {
              Text(recipe.title)
                .font(.title)
                .bold()
              
              Text("Cooking time: \(recipe.minutes) minutes")
              
              HStack(spacing: 0) {
                ForEach(recipe.tags, id: \.self) { tag in
                  Image(systemName: "tag")
                  Text(tag)
                    .padding(.trailing, 4)
                }
              }
              .padding(.vertical, 16)
            }
            
            Spacer()
            
            Image(systemName: viewModel.favoriteRecipes.contains(recipeId) ? "star.fill" : "star")
              .font(.title)
              .onTapGesture {
                if viewModel.favoriteRecipes.contains(recipeId) {
                  viewModel.removeFavorite(recipeId)
                } else {
                  viewModel.addFavorite(recipeId)
                }
              }
          }
          
          // MARK: - Recipe Ingredients
          
          Text("Ingredients:")
            .font(.headline)
            .padding(.vertical, 16)
          
          ForEach(recipe.ingredients, id: \.self) { ingredient in
            Toggle(isOn: Binding(
              get: { ingredientStates[ingredient.name] ?? false },
              set: { ingredientStates[ingredient.name] = $0 }
            )) {
              Text("\(ingredient.quantity) \(ingredient.name)")
            }
            .toggleStyle(CheckboxToggleStyle())
          }
          
          // MARK: - Recipe Step by Step
          
          Text("How to cook:")
            .font(.headline)
            .padding(.vertical, 16)
          
          ForEach(recipe.steps, id: \.self) { step in
            HStack(alignment: .top, spacing: 2) {
              Text("•")
              Text(step)
            }
          }
        }
        .padding(.horizontal, 40)
      }
    }
  }
}

#Preview {
  RecipeDetailView(recipeId: "r1")
    .environmentObject(RecipeViewModel(recipeService: RecipeService(fileName: Constant.recipeFile)))
}
