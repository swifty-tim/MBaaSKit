//
//  LabelLoad.swift
//  Remote Config
//
//  Created by Timothy Barnard on 23/10/2016.
//  Copyright © 2016 Timothy Barnard. All rights reserved.
//

import UIKit

public protocol LabelLoad {}

public extension LabelLoad where Self: UILabel {
    
    public func setupLabelView( className: UIViewController, name: String = "") {
       self.setup(className: String(describing: type(of: className)), tagValue: name)
    }
    
    public func setupLabelView( className: UIView, name: String = "") {
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
            case "text" where dict.tryConvert(forKey: key) != "":
                self.text = RCConfigManager.getTranslation(name: viewName)
                break
            case "textAlignment" where dict.tryConvert(forKey: key) != "":
                self.textAlignment = NSTextAlignment(rawValue: (value as! Int))!
            case "backgroundColor" where dict.tryConvert(forKey: key) != "":
                self.backgroundColor = RCConfigManager.getColor(name: (value as! String), defaultColor: .white)
                break
            case "font" where dict.tryConvert(forKey: key) != "":
                fontName = (value as! String)
                break
            case "fontSize" where dict.tryConvert(forKey: key) != "":
                size = value as! CGFloat
                break
            case "textColor" where dict.tryConvert(forKey: key) != "":
                self.textColor = RCConfigManager.getColor(name: (value as! String), defaultColor: .black)
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
        
        if !fontName.isEmpty && size != 0.0 {
            self.font = UIFont(name: fontName, size: size)
        }
    }

    func readFromJSON() -> UIColor {
        //print("readFromJSON")
        //print(MyFileManager.readJSONFile(parseKey: "maps", keyVal: "id"))
        let defaultColor = UIColor(red: 38/255, green: 154/255, blue: 208/255, alpha: 1)
        return RCConfigManager.getColor(name: "navColor", defaultColor: defaultColor)
    }
}
