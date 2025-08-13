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
  
  let recipeId: String
  
  var body: some View {
    if let recipe = viewModel.populateRecipeById(recipeId) {
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          AsyncImage(url: URL(string: recipe.image)) { image in
            image
              .resizable()
              .scaledToFill()
              .frame(maxWidth: .infinity)
              .frame(height: 300)
              .clipShape(Rectangle())
          } placeholder: {
            Color.gray
              .frame(maxWidth: .infinity)
              .frame(height: 300)
          }
          
          VStack(alignment: .leading) {
            HStack {
              VStack(alignment: .leading) {
                Text(recipe.title)
                
                Text("Cooking time: \(recipe.minutes) minutes")
                
                HStack(spacing: 0) {
                  ForEach(recipe.tags, id: \.self) { tag in
                    Image(systemName: "tag")
                    Text(tag)
                      .padding(.trailing, 4)
                  }
                }
              }
              
              Image(systemName: "star")
                .font(.title)
            }
            
            Text("Ingredient:")
            
            ForEach(recipe.ingredients, id: \.self) { ingredient in
              Text("\(ingredient.quantity) \(ingredient.name)")
            }
            
            Text("How to cook:")
            ForEach(recipe.steps, id: \.self) { step in
              Text(step)
            }
          }
          .padding()
        }
      }
    }
  }
}

#Preview {
  RecipeDetailView(recipeId: "r1")
    .environmentObject(RecipeViewModel(recipeService: RecipeService(fileName: Constant.recipeFile)))
}
