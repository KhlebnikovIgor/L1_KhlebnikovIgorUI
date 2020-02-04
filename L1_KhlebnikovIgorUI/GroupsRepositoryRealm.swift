//
//  GroupRepositoryRealm.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 03.02.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import RealmSwift


protocol  GroupsRepositoryRealm {
    func searchGroups(name: String) throws -> Results<GroupRealm>
    func getAllGroups() throws -> Results<GroupRealm>
    func addGroups(groups: [Group])
    func addGroup(group: Group)
    func getGroup(id: Int)->GroupRealm?
}

class GroupsRepositoryRealmImplementations: GroupsRepositoryRealm{
    
    func searchGroups(name: String) throws -> Results<GroupRealm>{
        do{
            let realm = try Realm()
            return realm.objects(GroupRealm.self).filter("firstName CONTAINS[c] %@", name)
        }
        catch{
            throw error
        }
    }
    
    func getAllGroups() throws -> Results<GroupRealm> {
        do{
            let realm = try Realm()
            return realm.objects(GroupRealm.self)
        } catch{
            throw error
        }
    }
    
    
    func addGroups(groups: [Group]){
        do{
            let realm = try Realm()
            try realm.write {
                var groupsRealm = [GroupRealm]()
                
                groups.forEach{
                    let groupRealm = GroupRealm()
                    groupRealm.id = $0.id
                    groupRealm.name = $0.name
                    groupRealm.screenName = $0.screenName
                    groupRealm.photo100 = $0.photo100
                    groupsRealm.append(groupRealm)
                }
                realm.add(groupsRealm, update: .modified)
            }
            print(realm.objects(GroupRealm.self))
        }
        catch{
            print(error)
        }
    }
    
    
    
    func addGroup(group: Group){
        do{
            let realm = try Realm()
            try realm.write {
                let groupRealm = GroupRealm()
                groupRealm.id = group.id
                groupRealm.name = group.name
                groupRealm.screenName = group.screenName
                groupRealm.photo100 = group.photo100
                realm.add(groupRealm, update: .modified)
            }
            print(realm.objects(GroupRealm.self))
        }
        catch{
            print(error)
        }
    }
    
    func getGroup(id: Int)->GroupRealm?{
        let realm = try! Realm()
        return realm.objects(GroupRealm.self).filter("id == %@", id).first
    }
    
}
