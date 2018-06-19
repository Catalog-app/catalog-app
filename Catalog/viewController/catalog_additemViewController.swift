//
//  catalog_additemViewController.swift
//  Catalog
//
//  Created by STAR on 18.06.18.
//  Copyright © 2018 senZpay. All rights reserved.
//

import UIKit
import Firebase

class catalog_additemViewController: UIViewController {
    
    var roomModel : RoomModel?
    var itemModel : ItemModel?

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var txt_brand: UITextField!
    @IBOutlet weak var txt_color: UITextField!
    @IBOutlet weak var txt_number: UITextField!
    
    @IBOutlet weak var btn_category: UIButton!
    @IBOutlet weak var btn_add: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_title.text = roomModel?.type
        
        g_itemCategory = ""
        
        if g_flag_item {
            txt_name.text = itemModel?.name
            g_itemCategory = (itemModel?.category)!
            txt_brand.text = itemModel?.brand
            if itemModel?.color != "" {
                txt_color.text = itemModel?.color
            }
            if itemModel?.number != "" {
                txt_number.text = itemModel?.number
            }
        }
        
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if g_itemCategory != "" {
            btn_category.setTitle(g_itemCategory, for: UIControlState.normal)
            if g_flag_item {
                btn_add.setTitle("Delete", for: UIControlState.normal)
                btn_add.setTitleColor(UIColor.red, for: UIControlState.normal)
            }
        }
        
    }
    

    @IBAction func Category(_ sender: Any) {
        
    }
    
    @IBAction func add(_ sender: Any) {
        
        if g_flag_item {

            let alert = UIAlertController(title: "Alert!", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
            let save = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in

                let dataRef = Database.database().reference().child("building").child(g_user_id).child((self.itemModel?.buildKey)!).child("floors").child((self.itemModel?.floorKey)!).child("rooms").child((self.itemModel?.roomKey)!).child("items").child((self.itemModel?.key)!)
                
                dataRef.removeValue()
                
                self.navigationController?.popViewController(animated: true)
                
            })
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
                self.navigationController?.popViewController(animated: true)
            })
            
            alert.addAction(save)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)

        } else {
            
            if txt_name.text == "" {
                showAlertWithOK(title: "Error", message: "Please insert Name!")
                txt_name.becomeFirstResponder()
                return
            }
            
            if g_itemCategory == "" {
                showAlertWithOK(title: "Error", message: "Please insert Category!")
                return
            }
            
            if txt_brand.text == "" {
                showAlertWithOK(title: "Error", message: "Please insert Brand!")
                txt_brand.becomeFirstResponder()
                return
            }
            
            var dataToDB = Dictionary<String, String>()
            dataToDB["category"] = g_itemCategory
            dataToDB["name"] = self.txt_name.text
            dataToDB["brand"] = self.txt_brand.text
            dataToDB["color"] = self.txt_color.text
            dataToDB["number"] = self.txt_number.text
            
            let dataRef = Database.database().reference().child("building").child(g_user_id).child((roomModel?.buildKey)!).child("floors").child((roomModel?.floorKey)!).child("rooms").child((roomModel?.key)!).child("items").childByAutoId()
            
            dataRef.updateChildValues(dataToDB)
            
        }

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        
//        let alert = UIAlertController(title: "Alert!", message: "Item changing?", preferredStyle: UIAlertControllerStyle.alert)
//        let save = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
//
//            if self.txt_name.text == "" {
//                self.showAlertWithOK(title: "Error", message: "Please insert Name!")
//                self.txt_name.becomeFirstResponder()
//                return
//            }
//
//            if g_itemCategory == "" {
//                self.showAlertWithOK(title: "Error", message: "Please insert Category!")
//                return
//            }
//
//            if self.txt_brand.text == "" {
//                self.showAlertWithOK(title: "Error", message: "Please insert Brand!")
//                self.txt_brand.becomeFirstResponder()
//                return
//            }
//
//            var dataToDB = Dictionary<String, String>()
//            dataToDB["category"] = g_itemCategory
//            dataToDB["name"] = self.txt_name.text
//            dataToDB["brand"] = self.txt_brand.text
//            dataToDB["color"] = self.txt_color.text
//            dataToDB["number"] = self.txt_number.text
//
//            let dataRef = Database.database().reference().child("building").child(g_user_id).child((self.itemModel?.buildKey)!).child("floors").child((self.itemModel?.floorKey)!).child("rooms").child((self.itemModel?.roomKey)!).child("items").child((self.itemModel?.key)!)
//
//            dataRef.updateChildValues(dataToDB)
//
//            self.navigationController?.popViewController(animated: true)
//
//        })
//        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
//            self.navigationController?.popViewController(animated: true)
//        })
//
//        alert.addAction(save)
//        alert.addAction(cancel)
//        self.present(alert, animated: true, completion: nil)
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

