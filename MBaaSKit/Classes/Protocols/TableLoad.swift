//
//  TableLoad.swift
//  Remote Config
//
//  Created by Timothy Barnard on 08/11/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit


public protocol TableLoad {}

public extension TableLoad where Self: UITableView {
    
    func setupTableView( className: UIViewController, name:String = "" ) {
        self.setup(className: String(describing: type(of: className)), tagValue: name)
    }
    
    
    func setupTableView( className: UIView, name:String = "" ) {
        self.setup(className: String(describing: type(of: className)), tagValue: name)
    }
    
    private func setup( className: String, tagValue : String ) {
        
        var viewName = tagValue
        if tagValue.isEmpty {
            viewName = String(self.tag)
        }
        
        let dict = RCConfigManager.getObjectProperties(className: className, objectName: viewName)
        
        for (key, value) in dict {
            switch key {
            case "isScrollEnabled" where dict.tryConvert(forKey: key) != "":
                self.isScrollEnabled = ((value as! Int)  == 1) ? true : false
                break
            case "isHidden" where dict.tryConvert(forKey: key) != "":
                self.isHidden = ((value as! Int)  == 1) ? true : false
            case "allowsSelection" where dict.tryConvert(forKey: key) != "":
                self.allowsSelection = ((value as! Int)  == 1) ? true : false
                break
            case "backgroundColor" where dict.tryConvert(forKey: key) != "":
                self.backgroundColor = RCConfigManager.getColor(name: dict.tryConvert(forKey: "backgroundColor"))
                break
            default: break
            }
        }
    }
}

