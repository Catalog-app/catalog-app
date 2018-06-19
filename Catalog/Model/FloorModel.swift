//
//  FloorModel.swift
//  Catalog
//
//  Created by STAR on 18.06.18.
//  Copyright © 2018 senZpay. All rights reserved.
//

import UIKit

class FloorModel {
    
    var type : String?
    var number :String?
    var key :String?
    var buildKey :String?
    
    
    init(key : String?, type : String?, number :String?, buildKey : String?) {
        self.key = key
        self.buildKey = buildKey
        self.type = type
        self.number = number
    }
}

