//
//  RCConfigManager.swift
//  Pods
//
//  Created by Timothy Barnard on 19/02/2017.
//
//
import Foundation
import UIKit

public class RCConfigManager {
    
    public func initConfigManager() -> Bool {
        
        if RCFileManager.checkFilesExists(fileName: RCFile.readConfigJSON.rawValue)
            && RCFileManager.checkFilesExists(fileName: RCFile.readLangJSON.rawValue) {
            
            return true
        } else {
            return false
        }
    }
    
    private func checkAndGetVersion(_ key: String, version: String) {
        
        UserDefaults.standard.set(key, forKey: version)
    }
    
    public class func getColor( name: String, defaultColor: UIColor = .black ) -> UIColor {
        
        guard let returnColor = RCFileManager.readJSONColor(keyVal: name) else {
            return defaultColor
        }
        
        return returnColor
    }
    
    public class func getTranslation( name: String, defaultName: String = "") -> String {
        
        guard let returnTranslation = RCFileManager.readJSONTranslation(keyName: name) else {
            return defaultName
        }
        
        return returnTranslation
    }
    
    public class func getLangugeList() -> [String] {
        
        let returnVal = [String]()
        
        guard let returnTranslation = RCFileManager.readJSONLanuageList() else {
            return returnVal
        }
        
        return returnTranslation
    }
    
    public class func getThemesList() -> [String] {
        
        let returnVal = [String]()
        
        guard let returnThemes = RCFileManager.readJSONThemesList() else {
            return returnVal
        }
        
        return returnThemes
    }
    
    public class func getMainSetting(name: String, defaultName: String = "") -> String {
        
        guard let returnSetting = RCFileManager.readJSONMainSettings(keyName: name ) else {
            return defaultName
        }
        
        return returnSetting
    }
    
    public class func getObjectProperties( className: String, objectName: String  ) -> [String:AnyObject] {
        
        return RCFileManager.getJSONDict(parseKey: className, keyVal: objectName)
    }
    
    public class func getClassProperties(className: String  ) -> [String:AnyObject] {
        
        return RCFileManager.getJSONClassProperties(parseKey: className)
    }
    
    public class func checkIfFilesExist() -> Bool {
        
        if RCFileManager.checkFilesExists(fileName: RCFile.readConfigJSON.rawValue)
            && RCFileManager.checkFilesExists(fileName: RCFile.readLangJSON.rawValue) {
            return true
        } else {
            return false
        }
    }
//    /**
//     getConfigVersion
//     - parameters
//     - getCompleted: return value of success state
//     - data: return array of objects
//     */
    public class func getConfigVersion() {
        
        self.getConfigVersion { (completed, data) in
            DispatchQueue.main.async {
                
            }
        }
    }
//    /**
//     getConfigThemeVersion
//     - parameters
//     - getCompleted: return value of success state
//     - data: return array of objects
//     */
//    public class func getConfigThemeVersion(theme:String ) {
//        
//        self.getConfigThemeVersion(theme:theme) { (completed, data) in
//            DispatchQueue.main.async {
//                
//            }
//        }
//    }

    
    public class func updateConfigFileNames(fileType : RCFileType) {
        
       RCFileManager.updateJSONFile(fileType: fileType)
    }
    
    private class func updateConfigFiles() {
        //RCFileManager.changeJSONFileName(oldName: RCFile.saveConfigJSON.rawValue, newName: RCFile.readConfigJSON.rawValue)
        //RCFileManager.changeJSONFileName(oldName: RCFile.saveLangJSON.rawValue, newName: RCFile.readLangJSON.rawValue)
        
        guard let doAnalytics = RCFileManager.readConfigVersion("doAnalytics") else {
            return
        }
        UserDefaults.standard.set(doAnalytics, forKey: "doAnalytics")
        //self.checkAndGetVersion("doAnalytics", version: doAnalytics)
        
        guard let version = RCFileManager.readConfigVersion("version") else {
            return
        }
        UserDefaults.standard.set(version, forKey: "version")
        //self.checkAndGetVersion("version", version: version)
    }
    
    /**
     updateNavigationBar
     - parameters
     - className: UIResponder self
     - objectName: String
     */
    public class func updateNavigationBar(className: UIResponder, objectName: String = "UINavigationBar" ) {
        
        let dict = RCConfigManager.getObjectProperties(className:  String(describing: type(of: className)), objectName: objectName)
        
        UserDefaults.standard.set(String(describing: type(of: className)), forKey: "navClass")
        
        var fontName: String = ""
        var size : CGFloat = 0.0
        for (key, value) in dict {
            
            switch key {
            //lightContent = 1 default = 0 dark
            case "statusBarStyle":
                UIApplication.shared.statusBarStyle = UIStatusBarStyle(rawValue: (value as! Int))!
                break
            case "barTintColor" where dict.tryConvert(forKey: key) != "":
                UINavigationBar.appearance().barTintColor = RCConfigManager.getColor(name: (value as! String), defaultColor: .white)
                break
            case "font" where dict.tryConvert(forKey: key) != "":
                fontName = (value as! String)
                break
            case "fontSize" where dict.tryConvert(forKey: key) != "":
                size = dict.tryConvert(forKey: "fontSize")
                break
            case "tintColor" where dict.tryConvert(forKey: key) != "":
                UINavigationBar.appearance().tintColor  = RCConfigManager.getColor(name: (value as! String), defaultColor: .black)
                break
            case "isTranslucent" where dict.tryConvert(forKey: key) != "":
                UINavigationBar.appearance().isTranslucent = ((value as! Int)  == 1) ? true : false
                break
            default: break
            }
        }
        
        if !fontName.isEmpty && size != 0.0 {
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName: UIFont(name: fontName, size: size)!]
        }
        
    }
    
    /**
     *  updateNavigationBar
     *
     *  - parameter className:
     *  - parameter className:  UIViewController self
     *  - parameter objectName:     String
     *  - parameter limit:    Optional. return no more than the supplied number of records.
     *  - parameter batchSize:    Optional. Change number of automatically iterated documents.
     *
     *  - returns: the count of documents that would match a find() query. The count() method does not perform the find() operation but instead counts and returns the number of results that match a query.
     */
    public class func updateNavigationBar(className: UIViewController, objectName: String = "UINavigationBar" ) {
        
        let navClass = UserDefaults.standard.string(forKey: "navClass") ?? "AppDelegate"
        
        let dict = RCConfigManager.getObjectProperties(className: navClass, objectName: objectName)
        
        var fontName: String = ""
        var size : CGFloat = 0.0
        for (key, value) in dict {
            
            switch key {
            //lightContent = 1 default = 0 dark
            case "statusBarStyle":
                UIApplication.shared.statusBarStyle = UIStatusBarStyle(rawValue: (value as! Int))!
                break
            case "barTintColor" where dict.tryConvert(forKey: key) != "":
                className.navigationController?.navigationBar.barTintColor = RCConfigManager.getColor(name: (value as! String), defaultColor: .white)
                break
            case "font" where dict.tryConvert(forKey: key) != "":
                fontName = (value as! String)
                break
            case "fontSize" where dict.tryConvert(forKey: key) != "":
                size = dict.tryConvert(forKey: "fontSize")
                break
            case "tintColor" where dict.tryConvert(forKey: key) != "":
                className.navigationController?.navigationBar.tintColor  = RCConfigManager.getColor(name: (value as! String), defaultColor: .white)
                break
            case "isTranslucent" where dict.tryConvert(forKey: key) != "":
                className.navigationController?.navigationBar.isTranslucent = ((value as! Int)  == 1) ? true : false
                break
            default: break
            }
        }
        
        if !fontName.isEmpty && size != 0.0 {
            className.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName: UIFont(name: fontName, size: size)!]
        }
        
    }

    /**
     getConfigThemeVersion
     - parameters
     - getCompleted: return value of success state
     - data: return array of objects
     */
    public class func getConfigLanguageVersion(name:String, getCompleted : @escaping (_ succeeded: Bool, _ message: String ) -> ()) {
        
        var version: String = ""
        
        if let buildVersion: AnyObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject? {
            version = buildVersion as! String
        }
        
        var url: String = ""
        url = url.readPlistString(value: "URL", "http://0.0.0.0:8181")
        
        var key: String = ""
        key = key.readPlistString(value: "APPKEY", "")
        
        let apiEndpoint = "/api/"+key+"/translation/" + name + "/" + version
        
        let networkURL = url + apiEndpoint
        
        guard let endpoint = URL(string: networkURL) else {
            print("Error creating endpoint")
            return
        }
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        //if let token = _currentUser?.currentToken {
        //    request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        // }
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if ((error) != nil) {
                getCompleted(false, "error")
            }
            
            guard let data = data else {
                return
            }
            
            RCFileManager.writeJSONFile(jsonData: data as NSData, fileType: .language)
            
            //self.updateConfigFiles()
            
            getCompleted(true, "success")
            
            }.resume()
    }

    
    
    /**
     getConfigThemeVersion
     - parameters
     - getCompleted: return value of success state
     - data: return array of objects
     */
    public class func getConfigThemeVersion(theme:String, getCompleted : @escaping (_ succeeded: Bool, _ message: String ) -> ()) {
        
        var version: String = ""
        
        if let buildVersion: AnyObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject? {
            version = buildVersion as! String
        }
        
        var url: String = ""
        url = url.readPlistString(value: "URL", "http://0.0.0.0:8181")
        
        var key: String = ""
        key = key.readPlistString(value: "APPKEY", "")
        
        let apiEndpoint = "/api/"+key+"/remote/" + version + "/" + theme
        
        let networkURL = url + apiEndpoint
        
        guard let endpoint = URL(string: networkURL) else {
            print("Error creating endpoint")
            return
        }
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        //if let token = _currentUser?.currentToken {
        //    request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        // }
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if ((error) != nil) {
                getCompleted(false, "error")
            }
            
            guard let data = data else {
                return
            }
            
            RCFileManager.writeJSONFile(jsonData: data as NSData, fileType: .config)
            
            self.updateConfigFiles()
            
            getCompleted(true, "success")
            
            }.resume()
    }

    
    
    /**
     getConfigVersion
     - parameters
     - getCompleted: return value of success state
     - data: return array of objects
     */
    public class func getConfigVersion(getCompleted : @escaping (_ succeeded: Bool, _ message: String ) -> ()) {
        
        var version: String = ""
        
        if let buildVersion: AnyObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject? {
            version = buildVersion as! String
        }
        
        var url: String = ""
        url = url.readPlistString(value: "URL", "http://0.0.0.0:8181")
        
        var key: String = ""
        key = key.readPlistString(value: "APPKEY", "")
        
        let apiEndpoint = "/api/"+key+"/remote/" + version
        
        let networkURL = url + apiEndpoint
        
        guard let endpoint = URL(string: networkURL) else {
            print("Error creating endpoint")
            return
        }
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        //if let token = _currentUser?.currentToken {
        //    request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        // }
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if ((error) != nil) {
                getCompleted(false, "error")
            }
            
            guard let data = data else {
                return
            }
            
            RCFileManager.writeJSONFile(jsonData: data as NSData, fileType: .config)
            
            self.updateConfigFiles()
            
            getCompleted(true, "success")
            
            }.resume()
    }
    
}
