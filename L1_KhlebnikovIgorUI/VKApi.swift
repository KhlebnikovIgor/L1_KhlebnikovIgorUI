//
//  VKApi.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 15.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation
import Alamofire

class VKApi{
    let vkURL = "https://api.vk.com/method/"
    
    //получение списка друзей
    func getFriends(token : String){
        let requestURL = vkURL  + "friends.get"
        let params = ["access_token": token,
                      "order": "name",
                      "fields": "city,domain",
                      "v":"5.103"]
        
         Alamofire.request(requestURL,
                           method: .post,
                           parameters: params)
            .responseString(completionHandler: { (response) in
                print("список друзей: " + String(response.value!))
                print(response.error ?? "")
            })
    }
    
   
    //получение списка фотографий
    func getPhotos(token : String){
        let requestURL = vkURL  + "photos.get"
        let params = ["access_token": token,
                      "album_id": "saved",
                      "v": "5.103"]
        
         Alamofire.request(requestURL,
                          method: .post,
                          parameters: params)
            .responseString(completionHandler: { (response) in
                print("список фотографий: " + String(response.value!))
                print(response.error ?? "")
            })
    }
    
    //получение списка групп
    func getGroups(token : String){
        let requestURL = vkURL  + "groups.get"
        let params = ["access_token": token,
                      "fields": "city,domain",
                      "v": "5.103"]
        
         Alamofire.request(requestURL,
                          method: .post,
                          parameters: params)
            .responseString(completionHandler: { (response) in
                print("список групп: " + String(response.value!))
                print(response.error ?? "")
            })
    }
    
    //поиск групп по заданной подстроке
    func searchGroups(token : String, q: String){
        let requestURL = vkURL  + "groups.search"
        let params = ["access_token": token,
                      "q": q,
                      "type": "page",//тип сообщества
                      "v": "5.103"]
        
         Alamofire.request(requestURL,
                          method: .post,
                          parameters: params)
            .responseString(completionHandler: { (response) in
                print("поиск групп по подстроке: " + String(response.value!))
                print(response.error ?? "")
            })
    }
    
}
