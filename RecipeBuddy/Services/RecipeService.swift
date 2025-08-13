//
//  RecipeService.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import Foundation

protocol RecipeDataSource {
  func loadRecipe(localPath: String, remotePath: String) async throws -> [Recipe]
}

struct RecipeService: RecipeDataSource {
  private var fileName: String
  private var remoteURL: String
  
  init(fileName: String, remoteURL: String) {
    self.fileName = fileName
    self.remoteURL = remoteURL
  }
  
  func loadRecipe(localPath fileName: String, remotePath remoteURL: String) async throws -> [Recipe] {
    guard let url = URL(string: remoteURL) else {
      throw DataError.fileNotFound(remoteURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
      do {
        let decoder = JSONDecoder()
        let recipes = try decoder.decode([Recipe].self, from: data)
        return recipes
      } catch {
        throw DataError.failedDecodingData(error)
      }
    } else {
      guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        throw DataError.fileNotFound(fileName)
      }
      print(DataError.badRequest)
      
      let data = try Data(contentsOf: fileURL)
      do {
        let decoder = JSONDecoder()
        let recipes = try decoder.decode([Recipe].self, from: data)
        return recipes
      } catch {
        throw DataError.failedDecodingData(error)
      }
    }
  }
}
