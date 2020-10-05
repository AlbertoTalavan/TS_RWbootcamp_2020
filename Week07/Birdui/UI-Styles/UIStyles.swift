/// Birdui in SwiftUI
///
///  Created by Maitri Mehta and Alberto Talaván on 4/7/20.
///  Copyright © 2020. All rights reserved.

import SwiftUI

//MARK: - PostListView
struct ButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    return content
      .padding([.top, .bottom, .leading, .trailing], 5)
      //      .background(RadialGradient(gradient: Gradient(colors: [Color.white, Color.gray]), center: .center, startRadius: 1, endRadius: 100))
      .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(Color.secondary, lineWidth: 2))
  }
}

//MARK: - PostView
struct TextStyle: ViewModifier {
  func body(content: Content) -> some View {
    return content
      .foregroundColor(Color.primary)
  }
}


struct UserNameTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    return content
      .font(.headline)
      .modifier(TextStyle())
  }
}

struct TextBodyTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    return content
      .font(.body)
      .truncationMode(.middle)
      .lineLimit(nil)
      .multilineTextAlignment(.leading)
      .modifier(TextStyle())
  }
}

struct TimestampTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    return content
      .font(.subheadline)
      .modifier(TextStyle())
  }
}

//MARK: - List cells
struct CellStyle: ViewModifier {
  func body(content: Content) -> some View {
    return content
    //just for future changes...
  }
}

//MARK: - NewPostView
struct ButtonPostStyle: ViewModifier {
  func body(content: Content) -> some View {
    return content
      .foregroundColor(.blue)
      .modifier(ButtonStyle())
  }
}

struct ButtonCancelStyle: ViewModifier {
  func body(content: Content) -> some View {
    return content
      .foregroundColor(.pink)
      .modifier(ButtonStyle())
  }
}

