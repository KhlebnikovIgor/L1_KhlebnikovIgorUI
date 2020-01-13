//
//  FrendCollectionCell.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/13/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit

class FrendCollectionCell:UICollectionViewCell{
    
    @IBOutlet weak var nameFrend: UILabel!
    
    @IBOutlet weak var photoFrend: RoundedAvatar!

    
    
    override func prepareForReuse() {
        super.prepareForReuse()

        nameFrend.text = nil
        photoFrend.nameImage = nil

    }
}
