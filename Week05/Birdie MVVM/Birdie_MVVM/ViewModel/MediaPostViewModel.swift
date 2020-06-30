//
//  MediaPostViewModel.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

/*
if let post = post as? TextPost {
      let cell = tableview.dequeueReusableCell(withIdentifier: "textCell") as! TextPostTableViewCell
      cell.nameLabel.text = post.userName
      cell.timestampLabel.text = post.timestamp.toString()
      cell.textBodyLabel.text = post.textBody
      return cell
  } else if let post = post as? ImagePost {
      let cell = tableview.dequeueReusableCell(withIdentifier: "imageCell") as! ImagePostTableViewCell
      cell.nameLabel.text = post.userName
      cell.timestampLabel.text = post.timestamp.toString()
      cell.textBodyLabel.text = post.textBody
      cell.postImageView.image = post.image
      return cell
  } else {
      let cell = UITableViewCell()
      cell.textLabel?.text = post.textBody
      return cell
  }
*/

class MediaPostsViewModel {
    static let shared = MediaPostsViewModel()

    func setUpTableViewCell(for post: MediaPost, in tableview: UITableView) -> UITableViewCell {
      let cell = tableview.dequeueReusableCell(withIdentifier: "MyCell") as! CustomCell
      
      if post.userName == "Homer Simpson" {
         cell.badgeImage.image = UIImage(named: "Homer")
         cell.badgeImage.layer.cornerRadius = cell.badgeImage.frame.size.width / 2
      } else {
            cell.badgeImage.image = UIImage(named: "mascot_swift-badge")
      }
     
      //common part to both MediaPost types
      cell.userNameLabel.text = post.userName
      cell.timeStampLabel.text = post.timestamp.toString()
      cell.textBodyLabel.text = post.textBody
      
      if let post = post as? ImagePost {
         cell.multimedia.image = post.image
         cell.multimedia.isHidden = false
      } else {
         cell.multimedia.isHidden = true
      }
      
      return cell

    }
}

extension Date {
    func toString(withFormat format: String = "d MMM, HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}

