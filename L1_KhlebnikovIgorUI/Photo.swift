//
//  Photo.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 17.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation



struct Photo: Codable {
    let id, albumID, ownerID: Int
    let sizes: [Size]
    let text: String
    let date: Int

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case sizes, text, date
    }
}

struct Size: Codable {
    let type: String
    let url: String
    let width, height: Int
}
