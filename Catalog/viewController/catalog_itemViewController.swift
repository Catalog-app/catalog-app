//
//  catalog_itemViewController.swift
//  Catalog
//
//  Created by STAR on 18.06.18.
//  Copyright © 2018 senZpay. All rights reserved.
//

import UIKit
import Firebase

class catalog_itemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var v_table: UITableView!
    @IBOutlet weak var lbl_title: UILabel!
    
    var roomModel : RoomModel?
    var itemModel = [ItemModel]()
    
    @IBOutlet weak var cons_addBtn: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_title.text = roomModel?.type

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        g_flag_item = false
        
        let count = self.itemModel.count
        let height = self.view.frame.size.height - 2 * self.v_table.frame.origin.y - 49
        self.v_table.frame = CGRect(x: self.v_table.frame.origin.x, y: self.v_table.frame.origin.y, width: self.v_table.frame.size.width, height: CGFloat(66 * count + 10))
        self.cons_addBtn.constant =  height - self.v_table.frame.size.height
        if self.cons_addBtn.constant < 27 {
            self.cons_addBtn.constant = 27
        }
        
        getItems()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catalog_item_cell", for: indexPath);
        cell.textLabel?.text = itemModel[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "show_edititem", sender: self.itemModel[indexPath.row])
    }
    
    func getItems() {
 Database.database().reference().child("building").child(g_user_id).child((roomModel?.buildKey)!).child("floors").child((roomModel?.floorKey)!).child("rooms").child((roomModel?.key)!).child("items").observe(.value, with: {(snapshot) in
            
            if snapshot.childrenCount > 0 {

                self.itemModel.removeAll()
                
                for items in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let itemObject = items.value as? [String: AnyObject]
                    
                    let key = (items as AnyObject).key as String
                    let buildKey = self.roomModel?.buildKey
                    let floorKey = self.roomModel?.floorKey
                    let roomKey = self.roomModel?.key
                    
                    let name = itemObject?["name"]
                    let category = itemObject?["category"]
                    let brand = itemObject?["brand"]
                    let color = itemObject?["color"]
                    let number = itemObject?["number"]
                    
                    let item = ItemModel(key: key, buildKey: buildKey, floorKey: floorKey, roomKey: roomKey, name: name as? String, category: category as? String, brand: brand as? String, color: color as? String, number: number as? String)
                    
                    self.itemModel.append(item)
                }
                
                let count = self.itemModel.count
                let height = self.view.frame.size.height - 2 * self.v_table.frame.origin.y - 49
                self.v_table.frame = CGRect(x: self.v_table.frame.origin.x, y: self.v_table.frame.origin.y, width: self.v_table.frame.size.width, height: CGFloat(66 * count + 10))
                self.cons_addBtn.constant =  height - self.v_table.frame.size.height
                if self.cons_addBtn.constant < 27 {
                    self.cons_addBtn.constant = 27
                }
                
                self.v_table.reloadData()
                
            }
        })
    }
    

    @IBAction func newItem(_ sender: Any) {
//        self.performSegue(withIdentifier: "show_newitem", sender: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_edititem" {
            let destinationVC = segue.destination as! catalog_additemViewController
            destinationVC.itemModel = sender as? ItemModel
            g_flag_item = true
        } else {
            let destinationVC = segue.destination as! catalog_additemViewController
            destinationVC.roomModel = roomModel
            g_flag_item = false
        }
        
    }

}
