//
//  ViewController.swift
//  Catalog
//
//  Created by STAR on 17.06.18.
//  Copyright © 2018 Junjie Shi. All rights reserved.
//

import UIKit
import Firebase


class SigninViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_pass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }

    @IBAction func login(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: self.txt_email.text!, password: self.txt_pass.text!) { (user, error) in

            if error == nil {
                //
                g_user_id = (Auth.auth().currentUser?.uid)!
                
                self.performSegue(withIdentifier: "show_home", sender: self);
                
            }
            else {
                self.showAlertWithOK(title: "Error", message: "Email or Password incorrect!")
            }
        };
        
    }
    
    @IBAction func signup(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.txt_email.text!, password: self.txt_pass.text!) { (authResult, error) in
            if error == nil {
                
                self.showAlertWithOK(title: "Success!", message: "")
                                
            }
            else {
                
            }
        }
    }
    
    func showAlertWithOK(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let save = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
        alert.addAction(save)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

