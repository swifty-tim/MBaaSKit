//
//  TextLoad.swift
//  Remote Config
//
//  Created by Timothy Barnard on 23/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

public protocol TextLoad { }

public extension TextLoad where Self: UITextField {
    
    func setupLabelView( className: UIViewController, name:String = "" ) {
        self.setup(className: String(describing: type(of: className)), tagValue: name )
    }
    
    func setupLabelView( className: UIView, name:String = "") {
        self.setup(className: String(describing: type(of: className)), tagValue: name)
    }
    
    private func setup( className: String, tagValue : String ) {
        
        var viewName = tagValue
        if tagValue.isEmpty {
            viewName = String(self.tag)
        }
        
        let dict = RCConfigManager.getObjectProperties(className: className, objectName: viewName )
        
        var fontName: String = ""
        var size : CGFloat = 0.0
        for (key, value) in dict {
            
            switch key {
            case "text" where dict.tryConvert(forKey: key) != "":
                //self.text = value as? String
                break
            case "textAlignment" where dict.tryConvert(forKey: key) != "":
                self.textAlignment = NSTextAlignment(rawValue: (value as! Int))!
            case "backgroundColor" where dict.tryConvert(forKey: key) != "":
                self.backgroundColor = RCFileManager.readJSONColor(keyVal: value as! String)
                break
            case "font" where dict.tryConvert(forKey: key) != "":
                fontName = (value as! String)
                break
            case "fontSize" where dict.tryConvert(forKey: key) != "":
                size = value as! CGFloat
                break
            case "textColor" where dict.tryConvert(forKey: key) != "":
                self.textColor = RCFileManager.readJSONColor(keyVal: value as! String)
                break
            case "placeholder" where dict.tryConvert(forKey: key) != "":
                self.placeholder = (value as! String)
                break
            case "isEnabled" where dict.tryConvert(forKey: key) != "":
                self.isEnabled = ((value as! Int)  == 1) ? true : false
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
            self.font = UIFont(name: fontName, size: size)
        }
    }
}
