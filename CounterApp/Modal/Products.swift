//
//  Products.swift
//  CounterApp
//
//  Created by Chanh Dat Ng on 10/18/19.
//  Copyright © 2019 Chanh Dat Ng. All rights reserved.
//

import Foundation

struct Products {
    var id : String
    var name : String
    var count : Int
    var company : String
    var store : String
    
    init(_ id : String, _ name : String, _ count : Int, _ company : String, _ store : String) {
        self.id = id
        self.name = name
        self.count = count
        self.company = company
        self.store = store
    }
}
