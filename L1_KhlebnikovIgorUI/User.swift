//
//  User.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 17.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation



struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
   // let isClosed, canAccessClosed: Bool?
//    let domain: String
    let isOnline: Int
//    let trackCode: String
    let deactivated: String?
//    let city: City?
    let avatarPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
//        case isClosed = "is_closed"
//        case canAccessClosed = "can_access_closed"
        case  isOnline = "online"
//        domain,
//        case trackCode = "track_code"
        case deactivated
//        , city
        case avatarPath = "photo_100"
    }
}

//struct City: Codable {
//    let id: Int
//    let title: String
//}
