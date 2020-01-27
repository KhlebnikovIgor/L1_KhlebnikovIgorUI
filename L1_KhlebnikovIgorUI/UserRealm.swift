//
//  UserRealm.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 22.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation
import RealmSwift

class UserRealm: Object{
        @objc dynamic var id = 0
        @objc dynamic var firstName = ""
        @objc dynamic var lastName = ""
        @objc dynamic var photo100 = ""
    var city: CityRealm?
}
class CityRealm: Object {
    @objc dynamic var  id = 0
    @objc dynamic var  title = ""
    


    

}

class UsersRepositoryRealm{
    
    func addUser(firstName: String, lastName: String, photo100: String/*, city: CityRealm*/){
        let realm = try? Realm()
        let newUser = UserRealm()
        newUser.id = 0
        newUser.firstName = firstName
        newUser.lastName = lastName
        newUser.photo100 = photo100
//        newUser.city = city

        try? realm?.write {
            realm?.add(newUser)
        }
    }
     
    func getUser(id: Int)->UserRealm?{
        let realm = try! Realm()
        return realm.objects(UserRealm.self).filter("id == %@", id).first
    }
    
}


