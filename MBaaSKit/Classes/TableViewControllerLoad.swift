//
//  TableViewControllerLoad.swift
//  Pods
//
//  Created by Timothy Barnard on 08/03/2017.
//
//

import Foundation

public protocol TableViewControllerLoad { }

public extension TableViewControllerLoad where Self: UITableViewController {
    
    /**
     setupTableViewController
     - parameters:
     - className: put self
     - name: the name of the object instance
     
     */
    public func setupTableViewController( className: UITableViewController, _ name: String = "" ) {
        
        self.setup(className: String(describing: type(of: className)), tagValue: name)
    }
    
    private func setup( className: String, tagValue : String ) {
        
        let dict = RCConfigManager.getClassProperties(className: className)
        
        for (key, _) in dict {
            
            switch key {
            case "title":
                self.title =  dict.tryConvert(forKey: key)
                break
            case "backgroundColor":
                self.view.backgroundColor = RCFileManager.readJSONColor(keyVal:  dict.tryConvert(forKey: key) )
                break
            case "isUserInteractionEnabled":
                self.view.isUserInteractionEnabled = dict.tryConvert(forKey: key)
                break
            case "isHidden":
                self.view.isHidden = dict.tryConvert(forKey: key)
                break
                
            default: break
            }
        }
    }
    
}
