//
//  File.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 30.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation
import RealmSwift

class UsersRepositoryRealm{
    
    func searchUsers(name: String) throws -> Results<UserRealm>{
        do{
            let realm = try Realm()
            return realm.objects(UserRealm.self).filter("firstName CONTAINS[c] %@", name)
        }
        catch{
            throw error
        }
    }
    
    func getAllUsers() throws -> Results<UserRealm> {
        do{
            let realm = try Realm()
            return realm.objects(UserRealm.self)
        } catch{
            throw error
        }
    }
    
    
    func addUsers(users: [User]){
        do{
            let realm = try Realm()
            try realm.write {
                var usersRealm = [UserRealm]()
                
                users.forEach{ //user in
                    let userRealm = UserRealm()
                    userRealm.id = $0.id
                    userRealm.firstName = $0.firstName
                    userRealm.lastName = $0.lastName
                    userRealm.photo100 = $0.avatarPath ?? ""
                    usersRealm.append(userRealm)
                    //        newUser.city = city
                }
                realm.add(usersRealm)
            }
            print(realm.objects(UserRealm.self))
        }
        catch{
            print(error)
        }
    }
    
    
    
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
                realm.add(userRealm, update: .modified)
            }
            print(realm.objects(UserRealm.self))
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
