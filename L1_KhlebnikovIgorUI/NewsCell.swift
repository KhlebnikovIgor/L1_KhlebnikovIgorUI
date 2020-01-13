//
//  NewsCellController.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 10/12/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit

class NewsCell : UITableViewCell{
    
   
    @IBOutlet weak var imagesNews: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAvatar: RoundedAvatar!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var textNews: UITextView!
        @IBOutlet weak var likedControl: LikedControl!
    override func prepareForReuse() {
        super.prepareForReuse()
        userName.text = nil
        userAvatar.nameImage = nil
        date.text = nil
        textNews.text = nil
        likedControl.isLiked = true
        imagesNews.image = nil
    }
}
