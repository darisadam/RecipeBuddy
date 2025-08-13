//
//  MealPlan.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import Foundation

struct MealPlan: Codable {
  var weekStartDate: Date
  var dailyMeals: [DayOfWeek: [String]]
  
  init(weekStartDate: Date = Date()) {
    self.weekStartDate = weekStartDate.startOfWeek()
    self.dailyMeals = [:]
    
    for day in DayOfWeek.allCases {
      dailyMeals[day] = []
    }
  }
}
