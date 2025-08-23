//
//  SelectMealView.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import SwiftUI

struct SelectMealView: View {
  @EnvironmentObject private var viewModel: RecipeViewModel
  @Environment(\.dismiss) private var dismiss
  let selectedDay: DayOfWeek
  let onRecipeSelected: (String) -> Void
  
  @State private var searchText = ""
  
  var filteredRecipes: [Recipe] {
    if searchText.isEmpty {
      return viewModel.recipes
    } else {
      return viewModel.recipes.filter { recipe in
        recipe.title.localizedCaseInsensitiveContains(searchText)
      }
    }
  }
  
  var body: some View {
    NavigationStack {
      VStack {
        Text("Add recipe to \(selectedDay.displayName)")
          .font(.headline)
          .padding()
        
        List(filteredRecipes) { recipe in
          Button(action: {
            AnalyticsManager.shared.logEvent(name: AnalyticsKey.addToPlan)
            onRecipeSelected(recipe.id)
          }) {
            HStack {
              VStack(alignment: .leading, spacing: 4) {
                Text(recipe.title)
                  .foregroundColor(.primary)
                  .fontWeight(.medium)
                
                HStack {
                  ForEach(recipe.tags, id: \.self) { tag in
                    Text(tag)
                      .font(.caption)
                      .padding(.horizontal, 6)
                      .padding(.vertical, 2)
                      .background(Color.blue.opacity(0.2))
                      .cornerRadius(4)
                  }
                  
                  Spacer()
                  
                  Text("\(recipe.minutes) min")
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
              }
              
              Spacer()
              
              Image(systemName: "plus.circle")
                .foregroundColor(.blue)
            }
          }
          .buttonStyle(.plain)
        }
        .searchable(text: $searchText, prompt: "Search recipes")
      }
      .navigationTitle("Select Recipe")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Cancel") {
            AnalyticsManager.shared.logEvent(name: AnalyticsKey.cancelAddToPlan)
            dismiss()
          }
        }
      }
    }
  }
}
