//
//  ShoppingListView.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import SwiftUI

struct ShoppingListView: View {
  @EnvironmentObject private var viewModel: RecipeViewModel
  @State private var shoppingList: [ShoppingList] = []
  
  var body: some View {
    NavigationStack {
      VStack {
        if shoppingList.isEmpty {
          VStack(spacing: 16) {
            Image(systemName: "cart")
              .font(.system(size: 60))
              .foregroundColor(.gray)
            
            Text("No shopping list yet")
              .font(.headline)
              .foregroundColor(.secondary)
            
            Text("Add recipes to your meal plan to generate a shopping list")
              .font(.subheadline)
              .foregroundColor(.secondary)
              .multilineTextAlignment(.center)
          }
          .padding()
          
          Spacer()
        } else {
          List {
            Section {
              ForEach(shoppingList, id: \.name) { ingredient in
                VStack(alignment: .leading, spacing: 4) {
                  HStack {
                    Text(ingredient.name)
                      .fontWeight(.medium)
                    
                    Spacer()
                    
                    Text(ingredient.totalQuantity)
                      .foregroundColor(.secondary)
                  }
                  
                  if ingredient.sources.count > 1 {
                    Text("Used in: \(ingredient.sources.joined(separator: ", "))")
                      .font(.caption)
                      .foregroundColor(.secondary)
                  }
                }
                .padding(.vertical, 2)
              }
            } header: {
              HStack {
                Text("Shopping List")
                Spacer()
                Button("Refresh") {
                  generateShoppingList()
                }
                .font(.caption)
                .buttonStyle(.bordered)
              }
            }
          }
        }
      }
      .navigationTitle("Shopping List")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          if shoppingList.isNotEmpty {
            ShareLink(item: shareText) { Image(systemName: "square.and.arrow.up") }
          }
        }
      }
      .onAppear {
        generateShoppingList()
      }
    }
  }
  
  private var shareText: String {
    guard shoppingList.isNotEmpty else { return "Shopping list is empty." }
    var lines: [String] = ["Shopping List", "================", ""]
    for item in shoppingList {
      var line = "• \(item.name) — \(item.totalQuantity)"
      if item.sources.count > 1 {
        line += " (used in: \(item.sources.joined(separator: ", ")))"
      }
      lines.append(line)
    }
    return lines.joined(separator: "\n")
  }
  
  private func generateShoppingList() {
    shoppingList = viewModel.generateShoppingList()
  }
}

#Preview {
    ShoppingListView()
}
