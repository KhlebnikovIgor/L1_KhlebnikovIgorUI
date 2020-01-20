//
//  LoginFormController.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/12/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit
import WebKit

class LoginFormController: UIViewController {


    var webView : WKWebView!
    let VKSecret = "7281162"
    var vkApi = VKApi()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webViewConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.navigationDelegate = self
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [URLQueryItem(name: "client_id", value: VKSecret),
                                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                                    URLQueryItem(name: "display", value: "mobile"),
                                    URLQueryItem(name: "scope", value: "262150"),//битовая маска или список строковых параметров доступа к ресурсам ВК
                                    URLQueryItem(name: "response_type", value: "token"),
                                    URLQueryItem(name: "v", value: "5.103")
                                    ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
        view = webView
    }

}

extension LoginFormController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let  fragment = url.fragment else {
                decisionHandler(.allow)
                return
        }
        let params = fragment.components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String : String]()){
                value, params in
                var dict = value
                let key = params[0]
                let value = params[1]
                dict[key] = value
                return dict
        }
        
        print(params)
        
        Session.shared.token = params["access_token"]!
        Session.shared.userId = params["user_id"]!
    
        performSegue(withIdentifier: "fromLoginController", sender: self)
/*    vkApi.getFriends(token: Session.shared.token)
    vkApi.getPhotos(token: Session.shared.token)
    vkApi.getGroups(token: Session.shared.token)
    vkApi.searchGroups(token: Session.shared.token, searchText: "ф")
  */
        decisionHandler(.cancel)
    }
}

