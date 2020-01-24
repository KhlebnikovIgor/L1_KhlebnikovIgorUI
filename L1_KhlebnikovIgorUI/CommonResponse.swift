//
//  CommonResponse.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 24.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation

struct CommonResponse<T: Decodable> : Decodable{
    var response: CommonResponseArray<T>
}

struct CommonResponseArray<T: Decodable> : Decodable{
    var count: Int
    var items: [T]
}
