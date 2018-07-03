//
//  RoomModel.swift
//  Catalog
//
//  Created by STAR on 18.06.18.
//  Copyright © 2018 Junjie Shi. All rights reserved.
//

import UIKit

class RoomModel {
    
    var type : String?
    var number :String?
    var key :String?
    var buildKey :String?
    var floorKey :String?
    
    
    init(key : String?, type : String?, number :String?, buildKey : String?, floorKey : String?) {
        self.key = key
        self.buildKey = buildKey
        self.type = type
        self.number = number
        self.floorKey = floorKey
    }
}
