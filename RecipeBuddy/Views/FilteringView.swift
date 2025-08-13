//
//  FilteringView.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import SwiftUI

struct FilteringView: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    HStack(alignment: .top) {
      Spacer()
      
      VStack(alignment: .leading) {
        Text("Filter by tags")
          .bold()
          .padding(.vertical, 8)
        
        ScrollView(.horizontal, showsIndicators: false) {
          List {
            
          }
        }
      }
      
      Spacer()
      Divider()
      Spacer()
      
      VStack(alignment: .leading) {
        Text("Sort by cooking time")
          .bold()
          .padding(.vertical, 8)
        
        List {
          Button("Shortest") {
            dismiss()
          }
          
          Button("Longest") {
            dismiss()
          }
          
          Button("Clear") {
            dismiss()
          }
        }
      }
      
      Spacer()
    }
    .presentationDetents([.medium])
  }
}

#Preview {
    FilteringView()
}
