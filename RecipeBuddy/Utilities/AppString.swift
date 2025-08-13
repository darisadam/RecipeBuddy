//
//  AppString.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import Foundation

enum AppString: String {
  
  case test = "test"
  
  public var localized: String { NSLocalizedString(self.rawValue, comment: "") }
}
