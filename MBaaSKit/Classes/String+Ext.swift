//
//  String+Ext.swift
//  Pods
//
//  Created by Timothy Barnard on 05/02/2017.
//
//

import Foundation

public extension String {
    
    public func readPlistString( value: String, _ defaultStr: String = "") -> String {
        var defaultURL = defaultStr
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            
            guard let valueStr = dict[value] as? String else {
                return defaultURL
            }
            
            defaultURL = valueStr
        }
        return defaultURL
    }
}

public extension String {
    
    public func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    public func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find.lowercased()) != nil
    }
}

