//
//  LikedCounterControl.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 10/13/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit


class LikedCounterControl : UIControl{
    private var stackView : UIStackView!
    let countLabel =  UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .clear
        
        countLabel.text = "sdfdsf"
        let views: [UIView] = [self, countLabel]
        stackView = UIStackView(arrangedSubviews: views)
        self.addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
        override func layoutSubviews() {
            super.layoutSubviews()
            //guard let aa = bounds else {return}
            stackView.frame = bounds
        }
}
