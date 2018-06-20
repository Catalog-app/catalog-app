//
//  catalog_floorViewController.swift
//  Catalog
//
//  Created by STAR on 18.06.18.
//  Copyright © 2018 senZpay. All rights reserved.
//

import UIKit
import Firebase

class catalog_floorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var v_table: UITableView!
    
    var buildingModel : BuildingModel?
    var floorModel = [FloorModel]()
    
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
        
        getFloors()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return floorModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catalog_floor_cell", for: indexPath);
        cell.textLabel?.text = self.floorModel[indexPath.row].type! + " (" + self.floorModel[indexPath.row].number! + ")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "show_catalog_room", sender: self.floorModel[indexPath.row])
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

                self.v_table.reloadData()
                
            }
        })
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! catalog_roomViewController
        destinationVC.floorModel = sender as? FloorModel
    }


}
