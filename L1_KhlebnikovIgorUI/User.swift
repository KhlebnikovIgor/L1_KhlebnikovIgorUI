//
//  User.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 17.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation

struct UserJson: Codable {
    let response: ResponseUsers
}

struct ResponseUsers: Codable {
    let count: Int
    let items: [User]
}

struct User: Codable {
    let id: Int
    let firstName, lastName: String
    let isClosed, canAccessClosed: Bool?
    let domain: String
    let online: Int
    let trackCode: String
    let deactivated: String?
    let city: City?
    let photo100: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case domain, online
        case trackCode = "track_code"
        case deactivated, city
        case photo100 = "photo_100"
    }
}

struct City: Codable {
    let id: Int
    let title: String
}
