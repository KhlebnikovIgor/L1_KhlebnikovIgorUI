//
//  FrendsController.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/13/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit

//protocol FrendsTableTableViewController {
//    var frends : NSDictionary! {get set}
//    var frendSectionTitles : NSArray! {get set}
//    //var frendIndexTitles : NSArray! {get set}
//}

class FrendsController:  UITableViewController, UISearchBarDelegate {
    
    let frendIndexTitles = ["А","Б","В","Г","Д","Е","Ж","З","И","К","Л","М"]
    
    //let frendSectionTitles = ["В","П","К","С"]

    var frends :[(title: String,[(name: String, image: String)])] =
        [
            ("В",[("Ваня", "1"),("Вадим", "3")]),
            ("П",[("Петя", "2")]),
            ("К",[("Коля", "3"),("Клим","4")]),
            ("С",[("Саша", "4"),("Соня","2"),("Семен","1")])
        ]
    
    var filteredFrends :[(title: String,[(name: String, image: String)])]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredFrends = frends
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return frendIndexTitles
    }
    
    //******
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.filteredFrends[section].title//frendSectionTitles[section]
    }
    //******
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.filteredFrends.count//frendSectionTitles.count
    }
    //******
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  filteredFrends[section].1.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "frendCell", for: indexPath) as! FrendTableCell
        cell.nameFrend.text = filteredFrends[indexPath.section].1[indexPath.row].name
        cell.photoFrend.nameImage = filteredFrends[indexPath.section].1[indexPath.row].image
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
                destinationController.navigationItem.title = filteredFrends[section].1[index].name
                destinationController.nameFrend = filteredFrends[section].1[index].name
                destinationController.photoFrend = filteredFrends[section].1[index].image
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFrends = searchText.isEmpty ? frends : frends.filter { (arg: (title: String, [(name: String, image: String)])) -> Bool in
            
            let (name, _) = arg
            return name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }

        tableView.reloadData()
    }

}
