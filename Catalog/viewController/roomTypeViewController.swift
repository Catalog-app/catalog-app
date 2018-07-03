//
//  roomTypeViewController.swift
//  Catalog
//
//  Created by STAR on 18.06.18.
//  Copyright © 2018 Junjie Shi. All rights reserved.
//

import UIKit

class roomTypeViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    var roomType = [String]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomType.append("Office")
        roomType.append("Conference room")
        roomType.append("Common area")
        roomType.append("Restroom")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomtype_cell", for: indexPath);
        cell.textLabel?.text = roomType[indexPath.row]
        if indexPath.row == index {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        g_roomType = roomType[index]
        tableView.reloadData()
        
    }
    
    @IBAction func back(_ sender: Any) {
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
