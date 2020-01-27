//
//  FrendsController.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/13/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit
import Alamofire


struct Section<T>{
    var title: String
    var items: [T]
}

protocol FriendListPreseneter {
    func getFriendList(completion: @escaping(Swift.Result<[User], Error>)->())
}

class FriendListPresenterImplementation/*<T: Repository>*/ : FriendListPreseneter{
    
    
    let vkAPI: VKApi
    let database: FriendRepository
    
    init(database: FriendRepository, api: VKApi) {
        self.vkAPI = api
        self.database = database
    }
    
    func getFriendList(completion: @escaping(Swift.Result<[User], Error>)->()) {
        vkAPI.getFriends(token: Session.shared.token) { result in
            switch result {
            case  .success(let users):
                //users.forEach{ self.database.create(entity: $0) }
                completion(.success(users))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

class FrendsController:  UITableViewController, UISearchBarDelegate {
    
    var presenter = FriendListPresenterImplementation(database: FriendRepository(stack: CoreDataStack.shared), api: VKApi())
    private var allFrends = [User]()
    private var frendsSection = [Section<User>]()
    
    //    var frends : [(title: String, frends: [(name: String, image: String)])] = []
    //        [
    //            ("В",[("Ваня", "1"),("Вадим", "3")]),
    //            ("П",[("Петя", "2")]),
    //            ("К",[("Коля", "3"),("Клим","4")]),
    //            ("С",[("Саша", "4"),("Соня","2"),("Семен","1")])
    //        ]
    
    //    var filteredFrends:[(title: String, frends: [(name: String, image: String)])]!
    
    var filteredFrends: [Section<User>]!
    
    private func friendsRequest(){
        presenter.getFriendList{result in
            switch result {
            case  .success(let users):
                self.allFrends = users
                let friendDictionary = Dictionary.init(grouping: users) {
                    $0.firstName.prefix(1)
                }
                self.frendsSection = friendDictionary.map{Section(title: String($0.key), items: $0.value)}
                self.frendsSection.sort{$0.title < $1.title}
                self.filteredFrends = self.frendsSection
                
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsRequest()
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return filteredFrends?.map( {$0.title})
    }
    
    //******
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredFrends[section].title
    }
    //******
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = self.filteredFrends else {return 0}
        return filteredFrends.count
    }
    //******
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  filteredFrends[section ].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "frendCell", for: indexPath) as! FrendTableCell
        cell.nameFrend.text = filteredFrends[indexPath.section].items[indexPath.row].firstName
        cell.photoFrend.nameImage = filteredFrends[indexPath.section].items[indexPath.row].avatarPath
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            filteredFrends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "aboutAFrend" {
            guard let destinationController = segue.destination as? AboutAFrendController else { return }
            
            let index = tableView.indexPathForSelectedRow?.row ?? 0
            let section = tableView.indexPathForSelectedRow?.section ?? 0
            if filteredFrends.count > index {
                destinationController.navigationItem.title = filteredFrends[section].items[index].firstName
                destinationController.nameFrend = filteredFrends[section].items[index].firstName
                destinationController.photoFrend = filteredFrends[section].items[index].avatarPath
            }
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFrends = searchText.isEmpty ? frendsSection : frendsSection.filter {
            !$0.items.filter{ ($0.firstName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil ) }.isEmpty
        }
        
        tableView.reloadData()
    }
    
}

