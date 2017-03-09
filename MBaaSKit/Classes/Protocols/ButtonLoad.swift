//
//  ButtonLoad.swift
//  Remote Config
//
//  Created by Timothy Barnard on 23/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

public protocol ButtonLoad { }

public extension ButtonLoad where Self: UIButton {
    
    /**
     - parameters:
        - className: put self
        - name: the name of the object instance
     
     */
    public mutating func setupButton( className: UIViewController, _ name: String = "" ) {
        
        self.setup(className: String(describing: type(of: className)), tagValue: name)
    }
    
    /**
     - parameters:
     - className: put self
     - name: the name of the object instance
     
     */
    public func setupButton( className: UIView, _ name:String = "" ) {
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
        for (key, _) in dict {
            
            switch key {
            case "title" where dict.tryConvert(forKey: key) != "":
                self.setTitle( dict.tryConvert(forKey: key) , for: .normal)
                break
            case "backgroundColor" where dict.tryConvert(forKey: key) != "":
                self.backgroundColor = RCFileManager.readJSONColor(keyVal:  dict.tryConvert(forKey: key) )
                break
            case "fontName" where dict.tryConvert(forKey: key) != "":
                fontName = dict.tryConvert(forKey: key)
                break
            case "fontSize" where dict.tryConvert(forKey: key) != "":
                size = dict.tryConvert(forKey: key)
                break
            case "titleColor" where dict.tryConvert(forKey: key) != "":
                self.setTitleColor(RCFileManager.readJSONColor(keyVal: dict.tryConvert(forKey: key)), for: .normal)
                break
            case "cornerRadius" where dict.tryConvert(forKey: key) != "":
                self.layer.cornerRadius = 10
                break
            case "clipsToBounds" where dict.tryConvert(forKey: key) != "":
                self.clipsToBounds = dict.tryConvert(forKey: key)
            case "isEnabled" where dict.tryConvert(forKey: key) != "":
                self.isEnabled = dict.tryConvert(forKey: key)
                break
            case "isHidden" where dict.tryConvert(forKey: key) != "":
                self.isHidden = dict.tryConvert(forKey: key)
                break
            case "isUserInteractionEnabled" where dict.tryConvert(forKey: key) != "":
                self.isUserInteractionEnabled = dict.tryConvert(forKey: key)
                break
            default: break
            }
        }
        
        if fontName != "" && size != 0.0 {
            self.titleLabel!.font = UIFont(name: fontName, size: size)
        }
    }
    
}
