//
//  RecipeItem.swift
//  RecipeBuddy
//
//  Created by Adam on 13/08/25.
//  Copyright © 2025 Djavaweb Coding Test - Adam. All rights reserved.
//

import SwiftUI

struct RecipeItem: View {
  var thumbnailURL: String
  var title: String
  var tags: [String]
  var estimatedTime: Int
  
  var body: some View {
    HStack(spacing: 16) {
      AsyncCachedImage(url: URL(string: thumbnailURL)) { image in
        image
          .resizable()
          .scaledToFill()
      } placeholder: {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.gray.opacity(0.3))
      }
      .frame(width: 100, height: 100)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      
      VStack(alignment: .leading, spacing: 8) {
        Text(title)
          .font(.title2)
          .bold()
        
        HStack(spacing: 0) {
          ForEach(tags, id: \.self) { tag in
            Image(systemName: "tag")
            Text(tag)
              .padding(.trailing, 4)
          }
          .font(.caption)
        }
        
        HStack {
          Image(systemName: AppImage.timerIcon)
          Text("\(estimatedTime) minutes")
        }
        .font(.subheadline)
      }
      
      Spacer()
    }
    .padding(.horizontal, 4)
    .padding(.vertical, 8)
  }
}

#Preview {
  RecipeItem(
    thumbnailURL: "https://picsum.photos/100/100",
    title: "Garlic Lemon Chicken",
    tags: ["breakfast", "quick"],
    estimatedTime: 10
  )
}
