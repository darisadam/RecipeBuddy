//
//  FilteringView.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import SwiftUI

struct FilteringView: View {
  @EnvironmentObject private var viewModel: RecipeViewModel
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    HStack(alignment: .top) {
      Spacer()
      
      // MARK: - Filter by Tags
      
      VStack(alignment: .leading) {
        Text("Filter by Tags")
          .bold()
          .padding(.vertical, 8)
        
        List {
          ForEach(viewModel.availableTags, id: \.self) { tag in
            Button(action: {
              AnalyticsManager.shared.logEvent(name: AnalyticsKey.filterRecipe)
              viewModel.toggleTagFilter(tag)
            }) {
              Text(viewModel.selectedTags.contains(tag) ? "\(tag) ✓" : tag)
            }
          }
        }
        
        Spacer()
        
        HStack {
          Spacer()
          Button("Clear Tags") {
            AnalyticsManager.shared.logEvent(name: AnalyticsKey.clearTagFilter)
            viewModel.clearAllFilters()
          }
          .buttonStyle(.bordered)
          Spacer()
        }
      }
      
      Spacer()
      Divider()
      Spacer()
      
      // MARK: - Sort by Cooking Time
      
      VStack(alignment: .leading) {
        Text("Sort by cooking time")
          .bold()
          .padding(.vertical, 8)
        
        List {
          Button("Shortest") {
            AnalyticsManager.shared.logEvent(name: AnalyticsKey.sortByShortestTimeToPrepare)
            viewModel.setSortOrder(.ascending)
          }
          
          Button("Longest") {
            AnalyticsManager.shared.logEvent(name: AnalyticsKey.sortByLongestTimeToPrepare)
            viewModel.setSortOrder(.descending)
          }
        }
        
        Spacer()
        
        HStack {
          Spacer()
          Button("Reset Sort") {
            AnalyticsManager.shared.logEvent(name: AnalyticsKey.resetSortingFilter)
            viewModel.setSortOrder(nil)
          }
          .buttonStyle(.bordered)
          Spacer()
        }
      }
    }
    .presentationDetents([.medium])
  }
}

#Preview {
    FilteringView()
}
