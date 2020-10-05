/// Birdui in SwiftUI
///
///  Created by Maitri Mehta and Alberto Talavan on 4/7/20.
///  Copyright © 2020. All rights reserved.


import SwiftUI

struct PostView: View {
  var post: MediaPost
  let userIconSize: CGFloat = 50
  let imageMaxHeight: CGFloat = 150
  let testUserImage: String = "mascot_swift-badge"
  @State var imageName: String = "heart"
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Image(testUserImage)
          .resizable()
          .frame(width: userIconSize, height: userIconSize, alignment: .top)
        
        VStack(alignment: .leading, spacing: 5) {
          Text("\(self.post.userName)")
            .modifier(UserNameTextStyle())
          
          Text(self.post.timestamp.toString())
            .modifier(TimestampTextStyle())
        }
        Spacer()
        VStack {
          Button(action:{
            //              self.post.favved() //self is inmutable...
            self.imageName = (self.imageName == "heart.fill") ? "heart": "heart.fill"
          }){
            Image(systemName: imageName)
              .font(.system(size: 25))
              .foregroundColor(.red)
              .padding(.trailing, 5)
          }
          //            Button(action: {
          //                print("Delete button tapped!")
          //            }) {
          //                Image(systemName: "trash")
          //                    .font(.system(size: 25))
          //                    .foregroundColor(.red)
          //            }
        }
      }
      Text("\(self.post.textBody!)")
        .modifier(TextBodyTextStyle())
        .padding(.leading, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      if self.post.uiImage != nil {
        HStack {
          Spacer()
          Image(uiImage: self.post.uiImage!)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: imageMaxHeight)
          Spacer()
        }
        .padding(.bottom, 5)
      }
    }
    .modifier(CellStyle())
  }
}


struct PostView_Previews: PreviewProvider {
  static var previews: some View {
    PostView(post: MediaPost(textBody: "https://www.raywenderlich.com is now new Netflix",
      userName: "Maitri", timestamp: Date(timeIntervalSinceNow: -9876),
      uiImage: UIImage(named: "octopus")))
  }
}
