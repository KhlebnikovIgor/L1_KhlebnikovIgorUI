//
//  PhotoRealm.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 22.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoRealm : Object{
    @objc dynamic var id = 0
    @objc dynamic var albumID = 0
    @objc dynamic var ownerID = 0
    @objc dynamic var text = ""
    @objc dynamic var date = 0
    var sizes = List<SizePhotoRealm>()
}

class SizePhotoRealm : Object{
    @objc dynamic var type = ""
    @objc dynamic var url = ""
    @objc dynamic var width = 0
    @objc dynamic var height = 0
}

class PhotosRepositoryRealm{
    
    func addPhoto(albumID: Int, ownerID: Int, text: String, date: Int, sizes: List<SizePhotoRealm>){
        let realm = try? Realm()
        let newPhoto = PhotoRealm()
        newPhoto.albumID = 1
        newPhoto.ownerID = ownerID
        newPhoto.text = text
        newPhoto.date = date
        newPhoto.sizes = sizes

        try? realm?.write {
            realm?.add(newPhoto)
        }
    }
     
    func getPhoto(id: Int)->PhotoRealm?{
        let realm = try! Realm()
        return realm.objects(PhotoRealm.self).filter("id == %@", id).first
    }
    
}
