//
//  Dictionary+Ext.swift
//  Pods
//
//  Created by Timothy Barnard on 29/01/2017.
//
//

import Foundation


extension Dictionary {
    
    func getValueAtIndex( index: Int ) -> ( String, String ) {
        for( indexVal, value) in enumerated() {
            
            if indexVal == index {
                return ( "\(value.0)" , "\(value.1)" )
            }
        }
        
        return ("", "")
    }
    
    func getKeyValueAtIndex( index: Int ) -> KeyValuePair {
        for( indexVal, value) in enumerated() {
            
            if indexVal == index {
                return KeyValuePair(key: "\(value.0)", value:  "\(value.1)")
            }
        }
        
        return KeyValuePair(key: "", value: "")
    }
    
    
    func getObjectAtIndex( index: Int ) -> ( String, AnyObject ) {
        
        for( indexVal, value) in enumerated() {
            
            if indexVal == index {
                return ( "\(value.0)" , value.1 as AnyObject )
            }
        }
        
        return ("", "" as AnyObject)
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: AnyObject {
    
    func tryConvertStr(forKey key:Key, defaultVal :String = "" ) -> String {
        
        guard let test = self[key] as? String else {
            return defaultVal
        }
        return test
    }
    
    func tryConvertInt(forKey key:Key, defaultVal :Int = 0 ) -> Int {
        
        guard let test = self[key] as? Int else {
            return defaultVal
        }
        return test
    }
    
    func tryConvertFloat(forKey key:Key, defaultVal :Float = 0 ) -> Float {
        
        guard let test = self[key] as? Float else {
            return defaultVal
        }
        return test
    }
    
    func tryConvertCGFloat(forKey key:Key, defaultVal :CGFloat = 0 ) -> CGFloat {
        
        guard let test = self[key] as? CGFloat else {
            return defaultVal
        }
        return test
    }
    
    
    func tryConvertBool(forKey key:Key, defaultVal :Bool = false ) -> Bool {
        
        guard let test = self[key] as? Int else {
            return defaultVal
        }
        return (test  == 1) ? true : false
    }
    
    func tryConvertDouble(forKey key:Key, defaultVal :Double = 0 ) -> Double {
        
        guard let test = self[key] as? Double else {
            return defaultVal
        }
        return test
    }
}
