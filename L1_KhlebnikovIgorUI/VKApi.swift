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
    func getFriends(token : String, completionHandler: @escaping ([User])->Void){
        let requestURL = vkURL  + "friends.get"
        let params = ["access_token": token,
                      "order": "name",
                      "fields": "city,domain,photo_100",
                      "v":"5.103"]
        
         Alamofire.request(requestURL,
                           method: .post,
                           parameters: params)
            .responseData { (response) in
                guard let data = response.value else {return}
                do
                {
                    let users = try JSONDecoder().decode(UserJson.self, from: data)
                    completionHandler(users.response.items)
                } catch{
                    print(error)
                }
            }
    }
    
   
    //получение списка фотографий
    func getPhotos(token : String, completionHandler: @escaping ([Photo])->Void){
        let requestURL = vkURL  + "photos.get"
        let params = ["access_token": token,
                      "album_id": "wall",
                      "v": "5.103"]
        
         Alamofire.request(requestURL,
                          method: .post,
                          parameters: params)
            .responseData { (response) in
                guard let data = response.value else {return}
                do
                {
                    let photos = try JSONDecoder().decode(PhotoJson.self, from: data)
                    completionHandler(photos.response.items)
                } catch{
                    print(error)
                }
            }
    }
    
    //получение списка групп
    func getGroups(token : String, completionHandler: @escaping ([Group])->Void){
        let requestURL = vkURL  + "groups.get"
        let params = ["access_token": token,
                      "extended": "1",
                      "fields": "photo_100",//"city,domain",
                      "v": "5.103"]
        
         Alamofire.request(requestURL,
                          method: .post,
                          parameters: params)
             .responseData { (response) in
                guard let data = response.value else {return}
                do
                {
                    let groups = try JSONDecoder().decode(GroupJson.self, from: data)
                    completionHandler(groups.response.items)
                } catch{
                    print(error)
                }
            }
    }
    
    //поиск групп по заданной подстроке
    func searchGroups(token : String, searchText: String, completionHandler: @escaping ([Group])->Void){
        let requestURL = vkURL  + "groups.search"
        let params = ["access_token": token,
                      "q": searchText,
                      "type": "page",//тип сообщества
                      "v": "5.103"]
        
         Alamofire.request(requestURL,
                          method: .post,
                          parameters: params)
            .responseData { (response) in
                guard let data = response.value else {return}
                do
                {
                    let groups = try JSONDecoder().decode(GroupJson.self, from: data)
                    completionHandler(groups.response.items)
                } catch{
                    print(error)
                }
            }
    }
    
}
