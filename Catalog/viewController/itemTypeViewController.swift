//
//  itemTypeViewController.swift
//  Catalog
//
//  Created by STAR on 19.06.18.
//  Copyright © 2018 senZpay. All rights reserved.
//

import UIKit

class itemTypeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var itemType = [String]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemType.append("Fixture")
        itemType.append("Furniture")
        itemType.append("Electronics")
        
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
        return itemType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemtype_cell", for: indexPath);
        cell.textLabel?.text = itemType[indexPath.row]
        if indexPath.row == index {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            g_itemCategory = itemType[index]
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        tableView.reloadData()
        
    }
    
    @IBAction func bacl(_ sender: Any) {
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
