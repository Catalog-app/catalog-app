//
//  newBuildingViewController.swift
//  Catalog
//
//  Created by STAR on 17.06.18.
//  Copyright © 2018 Junjie Shi. All rights reserved.
//

import UIKit
import Firebase

class newBuildingViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var txt_address: UITextField!
    @IBOutlet weak var txt_city: UITextField!
    @IBOutlet weak var txt_state: UITextField!
    @IBOutlet weak var txt_zip: UITextField!
    @IBOutlet weak var txt_nums: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txt_name.delegate = self
        self.txt_address.delegate = self
        self.txt_city.delegate = self
        self.txt_zip.delegate = self
        self.txt_nums.delegate = self
        
        self.txt_name.becomeFirstResponder()
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func save(_ sender: Any) {
        
        if self.txt_name.text == "" {
            showAlertWithOK(title: "Error", message: "Please insert Building name!")
            self.txt_name.becomeFirstResponder()
            return
        }
        if self.txt_city.text == "" {
            showAlertWithOK(title: "Error", message: "Please insert City!")
            self.txt_city.becomeFirstResponder()
            return
        }
        if self.txt_address.text == "" {
            showAlertWithOK(title: "Error", message: "Please insert Address!")
            self.txt_address.becomeFirstResponder()
            return
        }
        if self.txt_zip.text == "" {
            showAlertWithOK(title: "Error", message: "Please insert Zip!")
            self.txt_zip.becomeFirstResponder()
            return
        }
        if self.txt_nums.text == "" {
            showAlertWithOK(title: "Error", message: "Please insert Num of Floors!")
            self.txt_nums.becomeFirstResponder()
            return
        }
        
        var dataToDB = Dictionary<String, String>()
        dataToDB["name"] = self.txt_name.text
        dataToDB["address"] = self.txt_address.text
        dataToDB["city"] = self.txt_city.text
        dataToDB["zip"] = self.txt_zip.text
        dataToDB["nums"] = self.txt_nums.text

        let dataRef = Database.database().reference().child("building").child(g_user_id).childByAutoId()
        
        dataRef.updateChildValues(dataToDB)
        
        self.navigationController?.popViewController(animated: true)
        
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlertWithOK(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let save = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
          alert.addAction(save)
          self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
