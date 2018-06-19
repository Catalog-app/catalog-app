//
//  addRoomViewController.swift
//  Catalog
//
//  Created by STAR on 18.06.18.
//  Copyright © 2018 senZpay. All rights reserved.
//

import UIKit
import Firebase

class addRoomViewController: UIViewController {

    var floorModel : FloorModel?
    var roomModel : RoomModel?
    
    @IBOutlet weak var btn_type: UIButton!
    @IBOutlet weak var txt_num: UITextField!
    @IBOutlet weak var btn_add: UIButton!
    @IBOutlet weak var lbl_title: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        g_roomType = ""
        
        if g_flag_room {
            txt_num.text = roomModel?.number
            btn_type.setTitle(roomModel?.type, for: UIControlState.normal)
            btn_add.setTitle("Delete", for: UIControlState.normal)
            btn_add.setTitleColor(UIColor.red, for: UIControlState.normal)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if g_roomType != "" {
            btn_type.setTitle(g_roomType, for: UIControlState.normal)
        }
        
    }
    
    func showAlertWithOK(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let save = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
        alert.addAction(save)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func add(_ sender: Any) {
        
        if g_flag_room {

            let alert = UIAlertController(title: "Alert!", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
            let save = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                
                let dataRef = Database.database().reference().child("building").child(g_user_id).child((self.roomModel?.buildKey)!).child("floors").child((self.roomModel?.floorKey)!).child("rooms").child((self.roomModel?.key)!)
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
            if g_roomType == "" {
                showAlertWithOK(title: "Error", message: "Please insert Room Type!")
                return
            }
            
            var dataToDB = Dictionary<String, String>()
            dataToDB["type"] = g_roomType
            if txt_num.text != "" {
                dataToDB["number"] = self.txt_num.text
            } else {
                dataToDB["number"] = ""
            }
            
            
            let dataRef = Database.database().reference().child("building").child(g_user_id).child((floorModel?.buildKey)!).child("floors").child((floorModel?.key)!).child("rooms").childByAutoId()
            
            dataRef.updateChildValues(dataToDB)
        }
        
        self.navigationController?.popViewController(animated: true)
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
