//
//  GroupTableCell.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/13/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit




class GroupTableCell:UITableViewCell{
    
   @IBOutlet weak var groupAvatar: RoundedAvatar!
   @IBOutlet weak var groupName: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        groupName.text = nil
        groupAvatar.nameImage = nil
    }
    

}

