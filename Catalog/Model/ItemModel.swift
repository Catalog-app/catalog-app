//
//  ItemModel.swift
//  Catalog
//
//  Created by STAR on 19.06.18.
//  Copyright © 2018 senZpay. All rights reserved.
//

import UIKit

class ItemModel {
    
    var name : String?
    var category :String?
    var brand :String?
    var color :String?
    var number :String?
    var key :String?
    var buildKey :String?
    var floorKey :String?
    var roomKey :String?
    
    init(key : String?,buildKey : String?,floorKey : String?,roomKey : String?, name : String?, category :String?, brand :String?, color :String?, number :String?) {
        self.key = key
        self.buildKey = buildKey
        self.floorKey = floorKey
        self.roomKey = roomKey
        self.name = name
        self.category = category
        self.brand = brand
        self.color = color
        self.number = number
    }
}
