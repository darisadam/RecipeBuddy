//
//  RecipeService.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import Foundation

struct RecipeService {
  private var fileName: String
  
  init(fileName: String) {
    self.fileName = fileName
  }
  	
  func loadRecipe(from fileName: String) async throws -> [Recipe] {
    guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
      throw DataError.fileNotFound(fileName)
    }
    
    do {
      let data = try Data(contentsOf: fileURL)
      let decoder = JSONDecoder()
      let recipes = try decoder.decode([Recipe].self, from: data)
      return recipes
    } catch {
      throw DataError.failedDecodingData(error)
    }
  }
}
