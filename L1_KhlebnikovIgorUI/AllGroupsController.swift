//
//  AllGroupsController.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/13/19.
//  Copyright © 2019 Igor. All rights reserved.
//


import UIKit

class AllGroupsController:  UITableViewController {
    

    var groupsAll: [(name: String, image: String)] = [
        ("Семья",  "a2"),
        ("Друзья", "a1"),
        ("Коллеги", "a4")
    ]

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsAll.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allGroupCell", for: indexPath) as! GroupTableCell
        cell.groupName.text = groupsAll[indexPath.row].name
        cell.groupAvatar.nameImage = groupsAll[indexPath.row].image
        return cell
    }
//
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupsAll.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
