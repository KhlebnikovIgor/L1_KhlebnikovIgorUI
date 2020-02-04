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
    
//    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    //func getSectionIndexTitles() -> [String]?
//    func getTitleForSection(section: Int) -> String?
    func getModelAtIndex(indexPath: IndexPath) -> GroupRealm?
}


class GroupsPresenterImplementation: GroupsPresenter {
    private var vkAPI: VKApi
    private var database: GroupsRepositoryRealm
   // private var sortedGroupsResults = [Section<GroupRealm>]()
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
    
    private func getGroupsFromDataBase(){
        do{
            self.groupsResult = try database.getAllGroups()
            
            token = self.groupsResult.observe{results in
                switch results {
                case .error(let error): break
                case .initial(let groups): break
                case let .update(_,  deletions, insertions, modifications):
                    print(deletions)
                    print(insertions)
                    print(modifications)
                    break
                }
            }
            
//            makeSortedSections()
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
    

    
//    private func makeSortedSections(){
//        let groupedGroups = Dictionary.init(grouping: groupsResult) {$0.name.prefix(1)}
//        sortedGroupsResults = groupedGroups.map { Section(title: String($0.key), items: $0.value)}
//        sortedGroupsResults.sort{$0.title < $1.title}
//    }
}



extension GroupsPresenterImplementation{
    func getModelAtIndex(indexPath: IndexPath) -> GroupRealm? {
        return groupsResult[indexPath.row]//indexPath.section].items[indexPath.row]
    }
    
//    func numberOfSections() -> Int {
//        sortedGroupsResults.count
//    }
    
//    func getSectionIndexTitles() -> [String]? {
//        return  sortedGroupsResults.map( {$0.title})
//    }
    
//    func getTitleForSection(section: Int) -> String? {
//        return sortedGroupsResults[section].title
//    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return  groupsResult.count
    }
    
    func searchGroups(name: String) {
        do{
            self.groupsResult =  name.isEmpty ? try self.database.getAllGroups() : try  self.database.searchGroups(name: name)
//            self.makeSortedSections()
            self.view?.updateTable()
        }catch {
            print(error)
        }
    }
    
}
