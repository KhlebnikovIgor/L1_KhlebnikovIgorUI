//
//  FrendsController.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/13/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit


protocol FriendsControllerCollBack: class{
    func updateTable()
    func updateTable(_ deletions: [Int], _ insertions: [Int], _ modifications: [Int])
}


class FriendsController:  UITableViewController, UISearchBarDelegate {
    
    var presenter: FriendsPresenter?
    var configurator: FriendsConfigurator?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = FriendsConfiguratorImplementation()
        configurator?.configure(view: self)
        presenter?.viewDidLoad()
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return presenter?.getSectionIndexTitles()
    }
    
    //******
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.getTitleForSection(section: section)
    }
    //******
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    //******
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "frendCell", for: indexPath) as? FrendTableCell,
            let model = presenter?.getModelAtIndex(indexPath: indexPath) else {
                return UITableViewCell()
        }
        cell.renderCell(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            filteredFrends.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "aboutAFrend" {
            guard let destinationController = segue.destination as? AboutAFrendController else { return }

            guard let indexPath = tableView?.indexPathForSelectedRow else {return}
            

            
            let friend = presenter?.getModelAtIndex(indexPath: indexPath)
            destinationController.showData(nameFriend: friend?.firstName, photoFriend: friend?.photo100)
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchFriends(name: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
}

extension FriendsController: FriendsControllerCollBack{
    func updateTable() {
        tableView.reloadData()
    }
    
    func updateTable(_ deletions: [Int], _ insertions: [Int], _ modifications: [Int]){
        tableView.beginUpdates()
        tableView.deleteRows(at: deletions.map{ IndexPath(row: $0, section: 0) }, with: .none)
        tableView.insertRows(at: insertions.map{ IndexPath(row: $0, section: 0) }, with: .none)
        tableView.reloadRows(at: modifications.map{ IndexPath(row: $0, section: 0) }, with: .none)
        tableView.endUpdates()
    }
    
}
