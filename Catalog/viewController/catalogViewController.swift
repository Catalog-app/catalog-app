//
//  catalogViewController.swift
//  Catalog
//
//  Created by STAR on 17.06.18.
//  Copyright © 2018 senZpay. All rights reserved.
//

import UIKit
import Firebase

class catalogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var v_table: UITableView!
    
    var buildingModel = [BuildingModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getAllBuilding()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAllBuilding() {
        
        Database.database().reference().child("building").child(g_user_id).observe(.value, with: {(snapshot) in
            
            if snapshot.childrenCount > 0 {
                
                self.buildingModel.removeAll()
                
                for buildings in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let buildingObject = buildings.value as? [String: AnyObject]
                    
                    let key = (buildings as AnyObject).key as String
                    let name = buildingObject?["name"]
                    let address = buildingObject?["address"]
                    let city = buildingObject?["city"]
                    let zip = buildingObject?["zip"]
                    let nums = buildingObject?["nums"]
                    
                    let building = BuildingModel(key : key as String?, name : name as! String?, address : address as! String?,city : city as! String?,zip : zip as! String?,nums : nums as! String?)
                    
                    self.buildingModel.append(building)
                }
                
                self.v_table.reloadData()
                
            }
        })
        
    }
    
    //TableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildingModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catalog_cell", for: indexPath);
        cell.textLabel?.text = self.buildingModel[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "show_catalog_floor", sender: self.buildingModel[indexPath.row])
    }
    

    @IBAction func logout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
           
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SigninViewController = storyBoard.instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController
        self.present(SigninViewController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! catalog_floorViewController
        destinationVC.buildingModel = sender as? BuildingModel
    }


}
