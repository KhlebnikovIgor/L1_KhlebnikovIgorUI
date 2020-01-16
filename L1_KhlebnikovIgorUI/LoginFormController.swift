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
        
        vkApi.getFriends(token: Session.shared.token)
        vkApi.getPhotos(token: Session.shared.token)
        vkApi.getGroups(token: Session.shared.token)
        vkApi.searchGroups(token: Session.shared.token, q: "ф")
        
        decisionHandler(.cancel)
    }
}

/*
     @IBOutlet weak var scrollView: UIScrollView!
     @IBOutlet weak var loginInput: UITextField!
     @IBOutlet weak var passwordInput: UITextField!
     
     @IBAction func clickLoginButton(_ sender: Any) {
     //    performSegue(withIdentifier: "fromLoginController", sender: self)
     }
     
     
     @objc func keyboardWasShown(notification: Notification){
//получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey:UIResponder.keyboardFrameEndUserInfoKey)as!NSValue).cgRectValue
        let contentInsets = UIEdgeInsets(top:0.0, left:0.0 ,bottom: kbSize.height,right:0.0)
//добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
   //когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification){
        //устанавливаем отступ внизу UIScrrollView равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        //вотрое - когда она пропадает
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillShowNotification, object: nil)
        
    NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillHideNotification, object: nil)
    }
 
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier=="fromLoginController"{
            if loginIsTrue(){
                return true
            }
            else{
                showLoginError()
            }
        }
        return false
    }
    
    func loginIsTrue()->Bool{
        guard let login = loginInput.text  else
        {
            return false
        }
        guard let password = passwordInput.text  else
        {
            return false
        }
        
       
        
        return login=="admin" && password=="123456"
    }
    
    func showLoginError(){
        let alert =  UIAlertController(title: "Ошибка!", message: "Логин/пароль неверны!", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК" , style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
 */

