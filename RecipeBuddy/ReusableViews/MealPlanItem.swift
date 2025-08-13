//
//  MealPlanItem.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import SwiftUI

struct MealPlanItem: View {
  let day: DayOfWeek
  let recipes: [Recipe]
  let onAddRecipe: () -> Void
  let onRemoveRecipe: (String) -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Text(day.displayName)
          .font(.headline)
          .fontWeight(.semibold)
        
        Spacer()
        
        Button(action: onAddRecipe) {
          Image(systemName: "plus.circle.fill")
            .foregroundColor(.blue)
            .font(.title2)
        }
      }
      
      if recipes.isEmpty {
        Text("No meals planned")
          .foregroundColor(.secondary)
          .font(.subheadline)
          .padding(.vertical, 20)
          .frame(maxWidth: .infinity)
          .background(Color.gray.opacity(0.1))
          .cornerRadius(8)
      } else {
        ForEach(recipes) { recipe in
          HStack {
            VStack(alignment: .leading, spacing: 4) {
              Text(recipe.title)
                .font(.subheadline)
                .fontWeight(.medium)
              
              HStack {
                ForEach(recipe.tags, id: \.self) { tag in
                  Text(tag)
                    .font(.caption2)
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
            
            Button(action: { onRemoveRecipe(recipe.id) }) {
              Image(systemName: "minus.circle.fill")
                .foregroundColor(.red)
            }
          }
          .padding(12)
          .background(Color.white)
          .cornerRadius(8)
          .shadow(radius: 1)
        }
      }
    }
    .padding(16)
    .background(Color.gray.opacity(0.05))
    .cornerRadius(12)
  }
}
