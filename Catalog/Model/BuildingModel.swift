//
//  BuildingModel.swift
//  Catalog
//
//  Created by STAR on 18.06.18.
//  Copyright © 2018 senZpay. All rights reserved.
//

import UIKit

class BuildingModel {
    
    var name : String?
    var address :String?
    var city :String?
    var zip :String?
    var nums :String?
    var key :String?
    
    init(key : String?, name : String?, address :String?, city :String?, zip :String?, nums :String?) {
        self.key = key
        self.name = name
        self.address = address
        self.city = city
        self.zip = zip
        self.nums = nums
    }
}
