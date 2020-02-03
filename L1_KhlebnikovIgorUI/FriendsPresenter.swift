//
//  FrendsPresenter.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 30.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation
import RealmSwift

protocol FriendsPreseneter {
    func viewDidLoad()
    func searchFriends(name: String)
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func getSectionIndexTitles() -> [String]?
    func getTitleForSection(section: Int) -> String?
    func getModelAtIndex(indexPath: IndexPath) -> UserRealm?
}


class FriendsPreseneterImplementation: FriendsPreseneter {
    private var vkAPI: VKApi
    private var database: UsersRepositoryRealm
    private var sortedFrendsResults = [Section<UserRealm>]()
    private var friendsResult: Results<UserRealm>!
    private weak var view: FrendsControllerCollBack?
    
    
    init(database: UsersRepositoryRealm, view: FrendsControllerCollBack){
        self.vkAPI = VKApi()
        self.database = database
        self.view = view
    }
    
    func viewDidLoad() {
        getFrendsFromDataBase()
        getFrendsFromApi()
        
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
                do{
                    self.database.addUsers(users: users)//Добавили в базу друзей
                    self.getFrendsFromDataBase()//Отображаем друзей из базы
                }
                catch{
                    //TODO
                    //Show alert to viewController
                    print (error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func searchFriends(name: String) {
        do {
            //            allFrends =  name.isEmpty ? try database.getAllUsers().map{$0.toModel()} : try database.searchUsers(name: name).map{$0.toModel()}
            //
            //            let friendDictionary = Dictionary(grouping: allFrends) { $0.firstName.prefix(1) }
            //            sortedFrendsResults = friendDictionary.map{Section(title: String($0.key), items: $0.value)}
            //            sortedFrendsResults.sort{$0.title < $1.title}
            //            //TODO
            //tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func makeSortedSections(){
        let groupedFriends = Dictionary.init(grouping: friendsResult) {$0.firstName.prefix(1)}
        sortedFrendsResults = groupedFriends.map { Section(title: String($0.key), items: $0.value)}
        sortedFrendsResults.sort{$0.title < $1.title}
    }
}



extension FriendsPreseneterImplementation{
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
}
