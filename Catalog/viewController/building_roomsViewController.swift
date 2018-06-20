//
//  building_roomsViewController.swift
//  Catalog
//
//  Created by STAR on 18.06.18.
//  Copyright © 2018 senZpay. All rights reserved.
//

import UIKit
import Firebase

class building_roomsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    var floorModel : FloorModel?
    var roomModel = [RoomModel]()
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var v_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        g_flag_room = false
        lbl_title.text = floorModel?.type
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.roomModel.removeAll()
        getRooms()
        self.v_table.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "building_room_cell", for: indexPath);
//        cell.textLabel?.text = roomModel[indexPath.row].type
        cell.textLabel?.text = self.roomModel[indexPath.row].type! + " (" + self.roomModel[indexPath.row].number! + ")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "show_editRoom", sender: roomModel[indexPath.row])
    }
    
    func getRooms() {
        
        Database.database().reference().child("building").child(g_user_id).child((floorModel?.buildKey)!).child("floors").child((floorModel?.key)!).child("rooms").observe(.value, with: {(snapshot) in
            
            if snapshot.childrenCount > 0 {
                
                self.roomModel.removeAll()
                
                for rooms in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let roomObject = rooms.value as? [String: AnyObject]
                    
                    let key = (rooms as AnyObject).key as String
                    let buildKey = self.floorModel?.buildKey
                    let floorKey = self.floorModel?.key
                    
                    let type = roomObject?["type"]
                    let number = roomObject?["number"]
                    
                    let room = RoomModel(key : key as String?, type : type as! String?, number : number as! String?, buildKey : buildKey, floorKey: floorKey )
                    
                    self.roomModel.append(room)
                }
                
                self.v_table.reloadData()
                
            }
        })
    }
    
    @IBAction func addroom(_ sender: Any) {
//        self.performSegue(withIdentifier: "show_addroom", sender: floorModel)
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_editRoom" {
            g_flag_room = true
            let destinationVC = segue.destination as! addRoomViewController
            destinationVC.roomModel = sender as? RoomModel
        } else {
            g_flag_room = false
            let destinationVC = segue.destination as! addRoomViewController
            destinationVC.floorModel = floorModel
        }
        
    }


}
