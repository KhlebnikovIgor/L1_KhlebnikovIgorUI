//
//  GroupRealm.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 22.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//


import RealmSwift

class GroupRealm: Object{
        @objc dynamic var id = 0
        @objc dynamic var name = ""
        @objc dynamic var screenName = ""
        @objc dynamic var photo100 = ""
    
    override class func indexedProperties() -> [String] {
        return ["name"]
    }
    
    override class func primaryKey() -> String?{
        return "id"
    }
}


