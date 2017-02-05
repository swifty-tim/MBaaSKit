//
//  KeyValuePair.swift
//  Pods
//
//  Created by Timothy Barnard on 29/01/2017.
//
//

import Foundation

class KeyValuePair {
    
    let key: String
    let value: String
    
    init(key: String, value:String) {
        self.key = key
        self.value = value
    }
}

struct Document: JSONSerializable {
    
    var hasChildren: Int = 0
    var key: String?
    var value : AnyObject?
    var children: [Document]?
    
    init() {}
    init(dict: [String : Any]) {}
    
    init(dict: [String]) {}
    init(dict: String) {}
    
    init( key: String, value: AnyObject, children: [Document] = [], hasChildren: Int = 0 ) {
        self.key = key
        self.value = value
        self.children = children
        self.hasChildren = hasChildren
    }
}

struct GenericTable: JSONSerializable {
    
    var row: [Document]!
    
    init() {}
    init(dict: [String : Any]) {}
    
    init(dict: [String]) {}
    init(dict: String) {}
    
    init(dict: [Document]) {
        self.row = dict
    }
    
}
