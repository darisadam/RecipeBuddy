//
//  WeeklyPlanView.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import SwiftUI

struct WeeklyPlanView: View {
  @EnvironmentObject private var viewModel: RecipeViewModel
  @State private var showingRecipeSelector = false
  @State private var selectedDay: DayOfWeek?
  
  var body: some View {
    NavigationStack {
      VStack {
        HStack {
          Text("This Week's Plan")
            .font(.title2)
            .fontWeight(.semibold)
          
          Spacer()
          
          Button("Clear All") {
            viewModel.clearMealPlan()
          }
          .buttonStyle(.bordered)
          .foregroundColor(.red)
        }
        .padding()
        
        ScrollView {
          LazyVStack(spacing: 16) {
            ForEach(DayOfWeek.allCases, id: \.self) { day in
              MealPlanItem(
                day: day,
                recipes: viewModel.getRecipesForDay(day),
                onAddRecipe: {
                  selectedDay = day
                  showingRecipeSelector = true
                },
                onRemoveRecipe: { recipeId in
                  viewModel.removeRecipeFromDay(day, recipeId: recipeId)
                }
              )
            }
          }
          .padding(.horizontal)
        }
        
        Spacer()
        
        NavigationLink(destination: ShoppingListView().environmentObject(viewModel)) {
          HStack {
            Image(systemName: "cart.badge.plus")
            Text("Generate Shopping List")
          }
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(12)
        }
        .padding()
      }
      .navigationTitle("Meal Planning")
      .navigationBarTitleDisplayMode(.inline)
      .sheet(isPresented: $showingRecipeSelector) {
        SelectMealView(
          selectedDay: selectedDay ?? .sunday,
          onRecipeSelected: { recipeId in
            if let day = selectedDay {
              viewModel.addRecipeToDay(day, recipeId: recipeId)
            }
            showingRecipeSelector = false
          }
        )
        .environmentObject(viewModel)
      }
    }
  }
}

#Preview {
    WeeklyPlanView()
}
