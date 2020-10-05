/// Birdui in SwiftUI
///
///  Created by Maitri Mehta and Alberto Talaván on 4/7/20.
///  Copyright © 2020. All rights reserved.


import SwiftUI

struct PostListView: View {
   private var postViewModel = PostViewModel()
//  @ObservedObject var postViewModel: PostViewModel
  
  let testUserImage: String = "mascot_swift-badge"
  @State private var isNewPostViewVisible = false
  @State private var searchText = ""
  
//  init() {
//    UITableView.appearance().separatorColor = .clear
//  }
  private var posts: [MediaPost] {
    if !searchText.isEmpty {
      return postViewModel.searchPost(searchText)
    }else{
       return postViewModel.posts
    }
  }
    
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        ZStack {
          VStack {
            Image(testUserImage)
              .resizable()
              .frame(width: 50, height: 50, alignment: .leading)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          
          Text("Home")
            .font(.title)
//        Spacer()
        }
        Button(
          
          action:{
            self.isNewPostViewVisible = true
            
        }){
          Image(systemName: "plus")
            .font(.system(size: 25))
            .foregroundColor(.blue)
            .padding(.trailing, 5)
          Text("Create New Post")
            .foregroundColor(.blue)
            
            
          
        }
        .modifier(ButtonStyle())
        .sheet(isPresented: self.$isNewPostViewVisible) {
          NewPostView(postHandler: self.postViewModel)
        }
        .font(.headline)

      }
      .padding(.horizontal, 16)
      
      SearchBar(text: $searchText)
        .padding(.bottom)
      List {
              ForEach(posts) { post in
                PostView(post: post)
              }
        }

    }
  }
}

struct PostListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      PostListView()
//      PostListView(postViewModel: PostViewModel())
        .environment(\.colorScheme, .light)
      
//    PostListView()
//      .environment(\.colorScheme, .dark)
    }
  }
}
