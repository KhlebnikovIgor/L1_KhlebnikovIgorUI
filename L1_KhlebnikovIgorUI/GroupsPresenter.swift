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
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func getSectionIndexTitles() -> [String]?
    func getTitleForSection(section: Int) -> String?
    func getModelAtIndex(indexPath: IndexPath) -> GroupRealm?
}


class GroupsPresenterImplementation: GroupsPresenter {
    private var vkAPI: VKApi
    private var database: GroupsRepositoryRealm
    private var sortedGroupsResults = [Section<GroupRealm>]()
    private var groupsResult: Results<GroupRealm>!
    private weak var view: FriendsControllerCollBack?
    
    
    init(database: GroupsRepositoryRealm, view: FriendsControllerCollBack){
        self.vkAPI = VKApi()
        self.database = database
        self.view = view
    }
    
    func viewDidLoad() {
        getGroupsFromApi()
        getGroupsFromDataBase()
    }
    
    private func getGroupsFromDataBase(){
        do{
            self.groupsResult = try database.getAllGroups()//.map{$0.toModel()}
            makeSortedSections()
            self.view?.updateTable()
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
    

    
    private func makeSortedSections(){
        let groupedFriends = Dictionary.init(grouping: groupsResult) {$0.name.prefix(1)}
        sortedGroupsResults = groupedFriends.map { Section(title: String($0.key), items: $0.value)}
        sortedGroupsResults.sort{$0.title < $1.title}
    }
}



extension GroupsPresenterImplementation{
    func getModelAtIndex(indexPath: IndexPath) -> GroupRealm? {
        return sortedGroupsResults[indexPath.section].items[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        sortedGroupsResults.count
    }
    
    func getSectionIndexTitles() -> [String]? {
        return  sortedGroupsResults.map( {$0.title})
    }
    
    func getTitleForSection(section: Int) -> String? {
        return sortedGroupsResults[section].title
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return sortedGroupsResults[section].items.count
    }
    
    func searchGroups(name: String) {
        do{
            self.groupsResult =  name.isEmpty ? try self.database.getAllGroups() : try  self.database.searchGroups(name: name)
            self.makeSortedSections()
            self.view?.updateTable()
        }catch {
            print(error)
        }
    }
    
}
