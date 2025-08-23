//
//  Analytics.swift
//  RecipeBuddy
//
//  Created by Adam on 23/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import Foundation
import FirebaseAnalytics
import FirebaseCrashlytics

final class AnalyticsManager {
  
  static let shared = AnalyticsManager()
  
  private init() {}
  
  func logEvent(name: String, params: [String: Any]? = nil) {
    Analytics.logEvent(name, parameters: params)
  }
  
  func setUserId(userId: String) {
    Analytics.setUserID(userId)
  }
  
  func setUserProperty(value: String?, property: String) {
    Analytics.setUserProperty(value, forName: property)
  }
}

struct AnalyticsKey {
  
}
