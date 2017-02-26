//
//  KeyValuePair.swift
//  Pods
//
//  Created by Timothy Barnard on 29/01/2017.
//
//

import Foundation

public class KeyValuePair {
    
    let key: String
    let value: String
    
    public init(key: String, value:String) {
        self.key = key
        self.value = value
    }
}

public struct Document: TBJSONSerializable {
    
    var hasChildren: Int = 0
    var key: String?
    var value : AnyObject?
    var children: [Document]?
    
    public init() {}
    public init(jsonObject : TBJSON) {}
    
    public init( key: String, value: AnyObject, children: [Document] = [], hasChildren: Int = 0 ) {
        self.key = key
        self.value = value
        self.children = children
        self.hasChildren = hasChildren
    }
}

public struct GenericTable: TBJSONSerializable {
    
    var row: [Document]!
    
    public init() {}
    public init(jsonObject : TBJSON) {}
    
    public init(dict: [Document]) {
        self.row = dict
    }
    
}
