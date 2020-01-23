//
//  GroupRealm.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 22.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation
import RealmSwift

class GroupRealm: Object{
        @objc dynamic var id = 0
        @objc dynamic var name = ""
        @objc dynamic var screenName = ""
        @objc dynamic var photo100 = ""
}

class GroupRepositoryRealm{
    
    func addGroup(name: String, screenName: String, photo100: String){
        let realm = try? Realm()
        let newGroup = GroupRealm()
        newGroup.id = 1
        newGroup.name = name
        newGroup.screenName = screenName
        newGroup.photo100 = photo100

        try? realm?.write {
            realm?.add(newGroup)
        }
    }
     
    func getGroup(id: Int)->GroupRealm?{
        let realm = try! Realm()
        return realm.objects(GroupRealm.self).filter("id == %@", id).first
    }
    
}
