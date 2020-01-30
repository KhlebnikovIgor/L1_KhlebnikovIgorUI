//
//  UserRealm.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 22.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//


import RealmSwift

class UserRealm: Object{
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var deactivated = ""
    @objc dynamic var photo100 = ""
    
    override class func indexedProperties() -> [String] {
        return ["firstName", "deactivated"]
    }
    
    override class func primaryKey() -> String?{
        return "id"
    }
    
    func toModel() -> User {
        return User(id: id,
                    firstName: firstName,
                    lastName: lastName,
                    isOnline: 0,
                    deactivated: deactivated,
                    avatarPath: photo100)
    }
    //    var city: CityRealm?
}
//class CityRealm: Object {
//    @objc dynamic var  id = 0
//    @objc dynamic var  title = ""
//}



