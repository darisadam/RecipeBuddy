//
//  RecipeBuddyApp.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//

import SwiftUI
import netfox
import Firebase

@main
struct RecipeBuddyApp: App {
  @StateObject private var viewModel: RecipeViewModel
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
  init() {
    let recipeService = RecipeService(fileName: Constant.recipeFile, remoteURL: Constant.recipesDataUrl)
    _viewModel = StateObject(wrappedValue: RecipeViewModel(recipeService: recipeService))
    
    #if DEBUG
    NFX.sharedInstance().start()
    #endif
  }
  
  var body: some Scene {
    WindowGroup {
      TabBarView()
        .environmentObject(viewModel)
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    
    return true
  }
}

