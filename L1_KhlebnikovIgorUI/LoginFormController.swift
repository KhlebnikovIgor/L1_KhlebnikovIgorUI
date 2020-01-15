//
//  LoginFormController.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 9/12/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBAction func clickLoginButton(_ sender: Any) {
    //    performSegue(withIdentifier: "fromLoginController", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
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
        
        let session = Session.instance
        session.token = "69hjkhggdh"
        session.userId = 65789
        
        return login=="admin" && password=="123456"
    }
    
    func showLoginError(){
        let alert =  UIAlertController(title: "Ошибка!", message: "Логин/пароль неверны!", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК" , style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }

}
