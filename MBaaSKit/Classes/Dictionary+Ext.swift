//
//  Dictionary+Ext.swift
//  Dashboard
//
//  Created by Timothy Barnard on 20/01/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    public func getValueAtIndex( index: Int ) -> ( String, String ) {
        for( indexVal, value) in enumerated() {
            
            if indexVal == index {
                return ( "\(value.0)" , "\(value.1)" )
            }
        }
        
        return ("", "")
    }
    
    public func getKeyAtIndex( index: Int ) -> String {
        for( indexVal, value) in enumerated() {
            
            if indexVal == index {
                return "\(value.0)"
            }
        }
        
        return ""
    }
    
    
    public func getKeyValueAtIndex( index: Int ) -> KeyValuePair {
        for( indexVal, value) in enumerated() {
            
            if indexVal == index {
                return KeyValuePair(key: "\(value.0)", value:  "\(value.1)")
            }
        }
        
        return KeyValuePair(key: "", value: "")
    }
    
    
    public func getObjectAtIndex( index: Int ) -> ( String, AnyObject ) {
        
        for( indexVal, value) in enumerated() {
            
            if indexVal == index {
                return ( "\(value.0)" , value.1 as AnyObject )
            }
        }
        return ("", "" as AnyObject)
    }
}

public extension Dictionary {
    
    /// Try Convert string from dictionary
    ///
    /// - parameter key:        The key for which to return the value
    /// - parameter defaultVal: If the key is not found then return default
    ///
    /// - returns:              The coverted string
    func tryConvert(forKey key:Key, _ defaultVal :String = "" ) -> String {
        
        guard let test = self[key] as? String else {
            return defaultVal
        }
        return test
    }
    
    func tryConvert(forKey key:Key, _ defaultVal :Int = 0 ) -> Int {
        
        var value = defaultVal
        
        if let int = self[key] as? Int {
            value =  int
            
        } else {
            
            guard let test = self[key] as? String else {
                return defaultVal
            }
            guard let integerVal =  Int(test) else {
                return defaultVal
            }
            
            value = integerVal
        }
        
        return value
    }
    
    func tryConvert(forKey key:Key, _ defaultVal :Float = 0 ) -> Float {
        
        guard let test = self[key] as? String else {
            return defaultVal
        }
        
        guard let floatVal =  Float(test) else {
            return defaultVal
        }
        
        return floatVal
    }
    
    func tryConvert(forKey key:Key, _ defaultVal :CGFloat = 0 ) -> CGFloat {
        
        guard let test = self[key] as? String else {
            return defaultVal
        }
        if let n = NumberFormatter().number(from: test) {
            return CGFloat(n)
        }
        
        return defaultVal
    }
    
    
    func tryConvert(forKey key:Key, _ defaultVal :Bool = false ) -> Bool {
        
        guard let test = self[key] as? Int else {
            return defaultVal
        }
        return (test  == 1) ? true : false
    }
    
    func tryConvert(forKey key:Key, _ defaultVal : Double = 0 ) -> Double {
        
        guard let test = self[key] as? String else {
            return defaultVal
        }
        guard let doubleVal =  Double(test) else {
            return defaultVal
        }
        
        return doubleVal
    }
    
    func tryConvert(forKey key:Key, _ defaultVal : [String] = [String]() ) -> [String] {
        
        guard let test = self[key] as? [String] else {
            return defaultVal
        }
        return test
    }
    
    func tryConvert(forKey key:Key, _ defaultVal : [Double] = [Double]() ) -> [Double] {
        
        guard let test = self[key] as? [Double] else {
            return defaultVal
        }
        return test
    }
    
    func tryConvert(forKey key:Key, _ defaultVal : [Int] = [Int]() ) -> [Int] {
        
        guard let test = self[key] as? [Int] else {
            return defaultVal
        }
        return test
    }
    
    func tryConvertObj(forKey key:Key, _ defaultVal : [String:AnyObject] = [String:AnyObject]() ) -> [String:AnyObject] {
        
        guard let test = self[key] as? [String:AnyObject] else {
            return defaultVal
        }
        return test
    }
}
