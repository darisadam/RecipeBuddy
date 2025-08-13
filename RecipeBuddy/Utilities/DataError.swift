//
//  Error.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import Foundation

enum DataError: Error, LocalizedError {
  case fileNotFound(String)
  case failedReadingData(Error)
  case failedDecodingData(Error)
  
  var errorDescription: String? {
    switch self {
    case .fileNotFound(let fileName):
      return "File \(fileName) not found"
    case .failedReadingData(let error):
      return "Failed to read data: \(error.localizedDescription)"
    case .failedDecodingData(let error):
      return "Failed to decode data: \(error.localizedDescription)"
    }
  }
}
