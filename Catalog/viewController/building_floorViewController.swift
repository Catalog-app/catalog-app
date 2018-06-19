//
//  building_floorViewController.swift
//  Catalog
//
//  Created by STAR on 18.06.18.
//  Copyright © 2018 senZpay. All rights reserved.
//

import UIKit
import Firebase

class building_floorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var buildingModel : BuildingModel?
    var floorModel = [FloorModel]()

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var v_table: UITableView!
    
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
        g_floorType = "Floor"
        getFloors()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return floorModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "building_floor_cell", for: indexPath);
        cell.textLabel?.text = self.floorModel[indexPath.row].type
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "show_building_room", sender: self.floorModel[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let alert = UIAlertController(title: "Alert!", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
            let save = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                
                let dataRef = Database.database().reference().child("building").child(g_user_id).child((self.floorModel[indexPath.row].buildKey)!).child("floors").child(self.floorModel[indexPath.row].key!)
                dataRef.removeValue()
                self.floorModel.removeAll()
                self.getFloors()
                self.v_table.reloadData()
                
            })
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
                
            })
            
            alert.addAction(save)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func getFloors() {

        Database.database().reference().child("building").child(g_user_id).child((buildingModel?.key)!).child("floors").observe(.value, with: {(snapshot) in
            
            if snapshot.childrenCount > 0 {

                self.floorModel.removeAll()
                
                for floors in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let floorObject = floors.value as? [String: AnyObject]
                    
                    let key = (floors as AnyObject).key as String
                    let buildKey = self.buildingModel?.key
                    let type = floorObject?["type"]
                    let number = floorObject?["number"]
                    
                    let floor = FloorModel(key : key as String?, type : type as! String?, number : number as! String?, buildKey : buildKey )
                    
                    self.floorModel.append(floor)
                }
                //                print(snapshot)
                
//                let count = self.buildingModel.count
//                let height = self.view.frame.size.height - 2 * self.v_table.frame.origin.y
//
//                if CGFloat(66 * count) < height {
//                    self.v_table.frame = CGRect(x: self.v_table.frame.origin.x, y: self.v_table.frame.origin.y, width: self.v_table.frame.size.width, height: CGFloat(66 * count + 10))
//                    self.cons_addBtn.constant = 20 + height - self.v_table.frame.size.height
//                }
                
                self.v_table.reloadData()
                
            }
        })
        
    }
        
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addFloor(_ sender: Any) {
        self.performSegue(withIdentifier: "show_addfloor", sender: buildingModel)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_building_room" {
            let destinationVC = segue.destination as! building_roomsViewController
            destinationVC.floorModel = sender as? FloorModel
        } else {
            let destinationVC = segue.destination as! addFloorViewController
            destinationVC.buildingModel = sender as? BuildingModel
        }
        
    }
 
}
