//
//  addFloorViewController.swift
//  Catalog
//
//  Created by STAR on 18.06.18.
//  Copyright © 2018 senZpay. All rights reserved.
//

import UIKit
import Firebase

class addFloorViewController: UIViewController {

    var buildingModel : BuildingModel?
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var txt_floornum: UITextField!
    @IBOutlet weak var btn_floor: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_title.text = buildingModel?.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        btn_floor.setTitle(g_floorType, for: UIControlState.normal)
    }
    
    @IBAction func addFloor(_ sender: Any) {
        if txt_floornum.text == "" {
            showAlertWithOK(title: "Error", message: "Please insert Floor number!")
            txt_floornum.becomeFirstResponder()
            return
        }
        
        var dataToDB = Dictionary<String, String>()
        dataToDB["type"] = g_floorType
        dataToDB["number"] = self.txt_floornum.text
        
        let dataRef = Database.database().reference().child("building").child(g_user_id).child((buildingModel?.key)!).child("floors").childByAutoId()
        
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
