//
//  GroupsPresenter.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 03.02.2020.
//  Copyright © 2020 Igor. All rights reserved.
//


import RealmSwift


protocol GroupsPresenter {
    func viewDidLoad()
    func searchGroups(name: String)
    func numberOfRowsInSection(section: Int) -> Int
    func getModelAtIndex(indexPath: IndexPath) -> GroupRealm?
}


class GroupsPresenterImplementation: GroupsPresenter {
    private var vkAPI: VKApi
    private var database: GroupsRepositoryRealm
    private var groupsResult: Results<GroupRealm>!
    private weak var view: GroupsControllerCollBack?
    private var token: NotificationToken?
    
    
    init(database: GroupsRepositoryRealm, view: GroupsControllerCollBack){
        self.vkAPI = VKApi()
        self.database = database
        self.view = view
    }
    
    func viewDidLoad() {
        getGroupsFromApi()
        getGroupsFromDataBase()
    }
    
    deinit {
        token?.invalidate()
    }
    
    private func getGroupsFromDataBase(){
        let table = UITableView()
        do{
            self.groupsResult = try database.getAllGroups()
            
            token = self.groupsResult.observe{[weak self] results in
                switch results {
                case .error(let error): break
                case .initial(let groups):
                    self?.view?.updateTable()
                    break
                case let .update(_,  deletions, insertions, modifications):
                    self?.view?.updateTable(deletions, insertions, modifications)
                    break
                }
                
            }
        }catch {
            print(error)
        }
    }
    
    private func getGroupsFromApi() {
        vkAPI.getGroups(token: Session.shared.token) { result in
            switch result {
            case  .success(let groups):
                self.database.addGroups(groups: groups)//Добавили в базу группы
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}



extension GroupsPresenterImplementation{
    func getModelAtIndex(indexPath: IndexPath) -> GroupRealm? {
        return groupsResult[indexPath.row]//indexPath.section].items[indexPath.row]
    }
    
    
    func numberOfRowsInSection(section: Int) -> Int {
        return  groupsResult.count
    }
    
    func searchGroups(name: String) {
        do{
            self.groupsResult =  name.isEmpty ? try self.database.getAllGroups() : try  self.database.searchGroups(name: name)
            self.view?.updateTable()
        }catch {
            print(error)
        }
    }
    
}
