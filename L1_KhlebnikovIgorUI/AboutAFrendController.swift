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
    
    var nameFriend: String?
    var photoFriend: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FrendCollectionCell
        
        cell.nameFrend.text = nameFriend
        cell.photoFrend.nameImage = photoFriend
        
        return cell
    }
    
    func showData(nameFriend: String?, photoFriend: String?){
        navigationItem.title = nameFriend
        self.nameFriend = nameFriend
        self.photoFriend = photoFriend
    }
    
    
}
