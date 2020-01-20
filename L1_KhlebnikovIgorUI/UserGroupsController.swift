//
//  UserGroupsController.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/13/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit

class UserGroupsController:  UITableViewController {
    var groups: [(name: String, image: String)] = []
    var vkApi = VKApi()
 
    
    @IBAction func returnToUserGroups(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "addGroup" {
            guard let allGroupsController = unwindSegue.source as? AllGroupsController else { return }
            guard let indexPath = allGroupsController.tableView.indexPathForSelectedRow else { return }
            
            let group = allGroupsController.groupsAll[indexPath.row]
            if !groups.contains(where: { $0.name == group.name }) {
                groups.append(group)//allGroupsController.groupsAll[indexPath.row])
                tableView.insertRows(at: [IndexPath(row: groups.count - 1, section: 0)], with: .fade)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vkApi.getGroups(token: Session.shared.token, completionHandler: { (items: [Group]) in
            for group in items{
                self.groups.append((name: group.name, image: group.photo50))
            }
            self.tableView.reloadData()
        } )
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myGroupCell", for: indexPath) as! GroupTableCell
        
        cell.groupName.text = groups[indexPath.row].name
        cell.groupAvatar.nameImage = groups[indexPath.row].image
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}



