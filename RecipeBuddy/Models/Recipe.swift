//
//  Recipe.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import Foundation

struct Recipe: Identifiable, Codable {
  let id: String
  let title: String
  let tags: [String]
  let minutes: Int
  let image: URL
  let ingredients: [Ingredient]
  let steps: [String]
}
