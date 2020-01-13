//
//  AboutAFrend.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/13/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit
class AboutAFrendController: UICollectionViewController{
    private let reuseIdentifier = "frendCell"
    
  var nameFrend: String?
  var photoFrend: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FrendCollectionCell

        cell.nameFrend.text = nameFrend
        cell.photoFrend.nameImage = photoFrend

        return cell
    }


    
}
