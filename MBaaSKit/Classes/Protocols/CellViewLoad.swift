//
//  CellViewLoad.swift
//  DIT-Timetable-V2
//
//  Created by Timothy Barnard on 11/02/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import UIKit

public protocol CellViewLoad { }

public extension CellViewLoad where Self: UITableViewCell {
    
    public func setupCellView( className: UIViewController, name:String = "" ) {
        self.setup(className: String(describing: type(of: className)), tagValue: name )
    }
    
    public func setupCellView( className: UIView, name:String = "") {
        self.setup(className: String(describing: type(of: className)), tagValue: name)
    }
    
    private func setup( className: String, tagValue : String ) {
        
        var viewName = tagValue
        if tagValue.isEmpty {
            viewName = String(self.tag)
        }
        
        let dict = RCConfigManager.getObjectProperties(className: className, objectName: viewName)
        
        var fontName: String = ""
        var size : CGFloat = 0.0
        for (key, value) in dict {
            
            switch key {
            case "textLabel_text" where dict.tryConvert(forKey: key) != "":
                self.textLabel?.text = value as? String
                break
            case "textLabel_textColor" where dict.tryConvert(forKey: key) != "":
                self.textLabel?.textColor = RCFileManager.readJSONColor(keyVal: value as! String)
                break
            case "textLabel_BkgdColor" where dict.tryConvert(forKey: key) != "":
                self.textLabel?.backgroundColor = RCFileManager.readJSONColor(keyVal: value as! String)
                break
            case "detailLabel_text" where dict.tryConvert(forKey: key) != "":
                self.detailTextLabel?.text = value as? String
                break
            case "detailLabel_textColor" where dict.tryConvert(forKey: key) != "":
                self.detailTextLabel?.textColor = RCFileManager.readJSONColor(keyVal: value as! String)
                break
            case "detailLabel_BkgdColor" where dict.tryConvert(forKey: key) != "":
                self.detailTextLabel?.backgroundColor = RCFileManager.readJSONColor(keyVal: value as! String)
                break
            case "backgroundColor" where dict.tryConvert(forKey: key) != "":
                self.contentView.backgroundColor = RCFileManager.readJSONColor(keyVal: value as! String)
                break
            case "font" where dict.tryConvert(forKey: key) != "":
                fontName = (value as! String)
                break
            case "fontSize" where dict.tryConvert(forKey: key) != "":
                size = value as! CGFloat
                break
            case "isMultipleTouchEnabled" where dict.tryConvert(forKey: key) != "":
                self.isMultipleTouchEnabled = ((value as! Int)  == 1) ? true : false
                break
            case "isHidden" where dict.tryConvert(forKey: key) != "":
                self.isHidden = ((value as! Int)  == 1) ? true : false
                break
            case "isUserInteractionEnabled" where dict.tryConvert(forKey: key) != "":
                self.isUserInteractionEnabled = ((value as! Int)  == 1) ? true : false
                break
            default: break
            }
        }
        if !fontName.isEmpty && size > 0.0 {
            self.textLabel?.font = UIFont(name: fontName, size: size)
            self.detailTextLabel?.font = UIFont(name: fontName, size: size)
        }
    }

}
