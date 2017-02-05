//
//  String+Ext.swift
//  Pods
//
//  Created by Timothy Barnard on 05/02/2017.
//
//

import Foundation

extension String {
    
    func readPlistString( value: String, _ defaultStr: String = "") -> String {
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
