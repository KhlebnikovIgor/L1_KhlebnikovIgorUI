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
    
    let frendIndexTitles = ["А","Б","В","Г","Д","Е","Ж","З","И","К","Л","М"]
    
    var vkApi = VKApi()
    private var allFrends = [User]()
    private var frendsSection = [Section<User>]()
    // var frends = Dictionary<String,[(name: String, image: String)]>()
    //    var frends = [Section]()
    
    var frends : [(title: String, frends: [(name: String, image: String)])] = []
    //        [
    //            ("В",[("Ваня", "1"),("Вадим", "3")]),
    //            ("П",[("Петя", "2")]),
    //            ("К",[("Коля", "3"),("Клим","4")]),
    //            ("С",[("Саша", "4"),("Соня","2"),("Семен","1")])
    //        ]
    
    var filteredFrends:[(title: String, frends: [(name: String, image: String)])]!
    // var filteredFrends: Dictionary<String,[(name: String, image: String)]>!
    //    var filteredFrends: [Section]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkApi.getFriends(token: Session.shared.token) { result in
            switch result {
            case  .success(let users):
                //self.allFrends = users.filter($0.deactivated == nil)
                
                for user in users {
                    
                    self.frends.append((title: String(user.firstName[user.firstName.startIndex]),
                                        frends: [(name: user.firstName, image: user.photo100 ?? "")]))
                    //                        self.frends.append((title: String(user.firstName[user.firstName.startIndex]),
                    //                                        [(name: user.firstName, image: user.photo100 ?? "")]))
                }
                self.filteredFrends = self.frends
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return frendIndexTitles
    }
    
    //******
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(self.filteredFrends[section].title)//frendSectionTitles[section]
    }
    //******
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = self.filteredFrends else {return 0}
        return self.filteredFrends.count //frendSectionTitles.count
    }
    //******
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  filteredFrends[section].frends.count//frends ->1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "frendCell", for: indexPath) as! FrendTableCell
        cell.nameFrend.text = filteredFrends[indexPath.section].frends[indexPath.row].name//frends ->1
        cell.photoFrend.nameImage = filteredFrends[indexPath.section].frends[indexPath.row].image //frends ->1
        return cell
    }
    //
    // MARK: - Table view delegate
    
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
                destinationController.navigationItem.title = filteredFrends[section].frends[index].name//frends -> 1
                destinationController.nameFrend = filteredFrends[section].frends[index].name
                destinationController.photoFrend = filteredFrends[section].frends[index].image
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFrends = searchText.isEmpty ? frends : frends.filter { (arg: (title: String, frends: [(name: String, image: String)])) -> Bool in
            //        let (title, _ ) = arg
            //            print(title + "********************************")
            let (name, _) = arg
            return name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        //
        //        let aa: String
        //        aa.
        
        tableView.reloadData()
    }
    
}

