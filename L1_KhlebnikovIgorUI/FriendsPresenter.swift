//
//  FrendsPresenter.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 30.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation
import RealmSwift

struct Section<T>{
    var title: String
    var items: [T]
}

protocol FriendsPresenter {
    func viewDidLoad()
    func searchFriends(name: String)
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func getSectionIndexTitles() -> [String]?
    func getTitleForSection(section: Int) -> String?
    func getModelAtIndex(indexPath: IndexPath) -> UserRealm?
}


class FriendsPresenterImplementation: FriendsPresenter {
    private var vkAPI: VKApi
    private var database: UsersRepositoryRealm
    private var sortedFrendsResults = [Section<UserRealm>]()
    private var friendsResult: Results<UserRealm>!
    private weak var view: FriendsControllerCollBack?
    
    
    init(database: UsersRepositoryRealm, view: FriendsControllerCollBack){
        self.vkAPI = VKApi()
        self.database = database
        self.view = view
    }
    
    func viewDidLoad() { 
        getFrendsFromApi()
        getFrendsFromDataBase()
    }
    
    private func getFrendsFromDataBase(){
        do{
            self.friendsResult = try database.getAllUsers()//.map{$0.toModel()}
            makeSortedSections()
            self.view?.updateTable()
        }catch {
            print(error)
        }
    }
    
    private func getFrendsFromApi() {
        vkAPI.getFriends(token: Session.shared.token) { result in
            switch result {
            case  .success(let users):
                    self.database.addUsers(users: users)//Добавили в базу друзей
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    

    
    private func makeSortedSections(){
        let groupedFriends = Dictionary.init(grouping: friendsResult) {$0.firstName.prefix(1)}
        sortedFrendsResults = groupedFriends.map { Section(title: String($0.key), items: $0.value)}
        sortedFrendsResults.sort{$0.title < $1.title}
    }
}



extension FriendsPresenterImplementation{
    func getModelAtIndex(indexPath: IndexPath) -> UserRealm? {
        return sortedFrendsResults[indexPath.section].items[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        sortedFrendsResults.count
    }
    
    func getSectionIndexTitles() -> [String]? {
        return  sortedFrendsResults.map( {$0.title})
    }
    
    func getTitleForSection(section: Int) -> String? {
        return sortedFrendsResults[section].title
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return sortedFrendsResults[section].items.count
    }
    
    func searchFriends(name: String) {
        do{
            self.friendsResult =  name.isEmpty ? try self.database.getAllUsers() : try  self.database.searchUsers(name: name)
            self.makeSortedSections()
            self.view?.updateTable()
        }catch {
            print(error)
        }
    }
    
}
