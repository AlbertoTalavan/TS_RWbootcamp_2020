/// Birdui in SwiftUI
///
///  Created by Maitri Mehta and Alberto Talaván on 4/7/20.
///  Copyright © 2020. All rights reserved.

import SwiftUI

struct NewPostView: View {
  @ObservedObject var postHandler: PostViewModel
  @Environment(\.presentationMode) var presentationMode
  
  @State var username: String = ""
  @State var postText: String = ""
  @State var showImagePicker = false
  @State var uiImage: UIImage?
  let imageSize: CGFloat = 200
  
  var body: some View {
    VStack {
      Text("New Post")
        .font(.headline)
      Form {
        TextField("Username", text: $username)
        Button("Pick image") {
          self.showImagePicker = true
        }
        if uiImage != nil {
          Image(uiImage: uiImage!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: imageSize, height: imageSize)
        }
        TextField("Post text", text: $postText)//tried to allow user to display multiline
        
        //If iOS 14
        //TextEditor("Post text", text: $postText)
      }
      HStack {
        Button( action: {
          self.presentationMode.wrappedValue.dismiss()
        }){
          HStack {
            Image(systemName: "xmark")
            .foregroundColor(.red)
            .font(.system(size: 25))
            
            Text("Cancel")
            .font(.system(size: 20))
          }
        }
        .modifier(ButtonCancelStyle())
        
        Spacer()
        
        Button( action: {
          if self.username.isEmpty &&  self.postText.isEmpty {
            self.username = "Homer"
            self.postText = "Mmmm, donuts..."
            self.uiImage = UIImage(named: "HomerDonut")
          } else if self.username.isEmpty {
            self.username = "Me"
          }
          
         self.postHandler.addPost(post: MediaPost(textBody: self.postText, userName: self.username, timestamp: Date(), uiImage: self.uiImage))
          self.presentationMode.wrappedValue.dismiss()
        }){
          HStack {
            Text("post")
            .padding(.leading, 5)
            .font(.system(size: 20))
            
            Image(systemName: "paperplane")
              .font(.system(size: 25))
              .foregroundColor(.blue)
              .padding(.leading, 5)
          }
          
          
        }
        .modifier(ButtonPostStyle())
        .disabled(username.isEmpty &&  postText.isEmpty && uiImage == nil)
        
      }
      .padding()
    }
    .sheet(isPresented: $showImagePicker) {
      ImagePicker(image: self.$uiImage)
    }
  }
}

struct NewPostView_Previews: PreviewProvider {
  static var previews: some View {
    NewPostView(postHandler: PostViewModel())
  }
}
