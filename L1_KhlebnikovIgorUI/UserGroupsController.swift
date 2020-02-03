//
//  UserGroupsController.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/13/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit

protocol GroupsControllerCollBack: class{
    func updateTable()
}


class UserGroupsController:  UITableViewController {
    var presenter: GroupsPresenter?
    
    
    @IBAction func returnToUserGroups(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "addGroup" {
            guard let allGroupsController = unwindSegue.source as? AllGroupsController else { return }
            guard let indexPath = allGroupsController.tableView.indexPathForSelectedRow else { return }
            
            let group = allGroupsController.groupsAll[indexPath.row]
            //            if !groups.contains(where: { $0.name == group.name }) {
            //                groups.append(group)//allGroupsController.groupsAll[indexPath.row])
            //                tableView.insertRows(at: [IndexPath(row: groups.count - 1, section: 0)], with: .fade)
            //            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = GroupsPresenterImplementation(database: GroupsRepositoryRealmImplementations(), view: self)
        presenter?.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myGroupCell", for: indexPath) as? GroupTableCell,
            let model = presenter?.getModelAtIndex(indexPath: indexPath) else {
                return UITableViewCell()
        }
        cell.renderCell(model: model)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            groups.remove(at: indexPath.row)
            //            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension UserGroupsController: GroupsControllerCollBack{
    func updateTable() {
        tableView.reloadData()
    }
    
}
