//
//  File.swift
//  CounterApp
//
//  Created by Chanh Dat Ng on 10/19/19.
//  Copyright © 2019 Chanh Dat Ng. All rights reserved.
//

import Foundation

struct Customers {
    var id : String
    var day : String
    var count : Int
    
    init(_ id : String, _ day : String, _ count : Int) {
        self.id = id
        self.day = day
        self.count = count
    }
}
