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


class FrendsController:  UITableViewController, UISearchBarDelegate {
   // var presenterR: FriendsPreseneter?
    
    
    var presenter = FriendListPresenterImplementation(database: UsersRepositoryRealm()/*FriendRepository(stack: CoreDataStack.shared)*/, api: VKApi())
    private var allFrends = [User]()
    //    private var frendsSection = [Section<User>]()
    private var filteredFrends: [Section<User>]!
    // private let database = UsersRepositoryRealm()
    
    private func friendsRequest(){
        presenter.getFriendList{result in
            switch result {
            case  .success(let users):
                self.allFrends = users
                let friendDictionary = Dictionary(grouping: users) {
                    $0.firstName.prefix(1)
                }
                self.filteredFrends = friendDictionary.map{Section(title: String($0.key), items: $0.value)}
                self.filteredFrends.sort{$0.title < $1.title}
                //                self.filteredFrends = self.frendsSection
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //presenterR = FriendsPreseneterImplementation()
       // presenterR?.viewDidLoad()
        
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
        do {
            allFrends =  searchText.isEmpty ? try presenter.database.getAllUsers().map{$0.toModel()} : try presenter.database.searchUsers(name: searchText).map{$0.toModel()}
            
            let friendDictionary = Dictionary(grouping: allFrends) { $0.firstName.prefix(1) }
            filteredFrends = friendDictionary.map{Section(title: String($0.key), items: $0.value)}
            filteredFrends.sort{$0.title < $1.title}
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
        //        filteredFrends = searchText.isEmpty ? frendsSection : frendsSection.filter {
        //            !$0.items.filter{ ($0.firstName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil ) }.isEmpty
        //        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
}

