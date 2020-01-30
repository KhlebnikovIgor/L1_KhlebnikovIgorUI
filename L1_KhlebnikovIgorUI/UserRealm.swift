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
    @objc dynamic var photo100 = ""
    var city: CityRealm?
}
class CityRealm: Object {
    @objc dynamic var  id = 0
    @objc dynamic var  title = ""
    
    
    
    
    
}

class UsersRepositoryRealm{
    
    func addUser(user: User){
        do{
            let realm = try Realm()
            try realm.write {
            let userRealm = UserRealm()
            userRealm.id = user.id
            userRealm.firstName = user.firstName
            userRealm.lastName = user.lastName
            userRealm.photo100 = user.avatarPath ?? ""
            //        newUser.city = city
            realm.add(userRealm)
            }
        }
        catch{
            print(error)
        }
    }
    
    func getUser(id: Int)->UserRealm?{
        let realm = try! Realm()
        return realm.objects(UserRealm.self).filter("id == %@", id).first
    }
    
}


