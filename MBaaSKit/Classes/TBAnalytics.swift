//
//  TBAnalytics.swift
//  Pods
//
//  Created by Timothy Barnard on 08/02/2017.
//
//

import Foundation


public enum SendType: String {
    case OpenApp = "OpenApp"
    case CloseApp = "CloseApp"
    case ViewOpen = "ViewOpen"
    case ViewClose = "ViewClose"
    case ButtonClick = "ButtonClick"
    case Generic = "Generic"
}

public class TBAnalytics {
    
    class private var dateFormatter : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }
    
    class private var nowDate: String {
        return self.dateFormatter.string(from: NSDate() as Date)
    }
    
    //MARK: - Internal methods
    class private func getTags() -> [String:AnyObject] {
        
        var tags = [String:AnyObject]()
        
        if tags["Build version"] == nil {
            
            if let buildVersion: AnyObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject?
            {
                tags["Build version"] = buildVersion as AnyObject?
                tags["Build name"] = RCFileManager.readPlistString(value: "CFBundleDisplayName") as AnyObject?
            }
        }
        
        #if os(iOS) || os(tvOS)
            if (tags["OS version"] == nil) {
                tags["OS version"] = UIDevice.current.systemVersion as AnyObject?
            }
            
            if (tags["Device model"] == nil) {
                tags["Device model"] = UIDevice.current.model as AnyObject?
            }
        #endif
        
        return tags
        
    }
    
    
    struct TBAnalyitcs: TBJSONSerializable {
        
        var timeStamp: String = ""
        var method: String = ""
        var className: String = ""
        var fileName: String = ""
        var configVersion: String = ""
        var type: String = ""
        var tags = [String:AnyObject]()
        
        init() {}
        init(jsonObject: TBJSON) {}
    }
    
    /**
     SendOpenApp
     - parameters:
     - app: Self if running from AppDelegate class
     */
    public class func sendOpenApp(_ app: UIResponder , method: String? = #function , file: String? = #file) {
        self.sendData(String(describing: type(of: app)), file: file ?? "", method: method ?? "", type: .OpenApp )
    }
    
    /**
     SendOpenApp
     - parameters:
     - app: Self if running from UIVIew class
     */
    public class func sendOpenApp(_ view: UIView , method: String? = #function , file: String? = #file){
        self.sendData(String(describing: type(of: view)), file: file ?? "", method: method ?? "", type: .OpenApp  )
    }
    
    /**
     SendCloseApp
     - parameters:
     - app: Self if running from AppDelegate class
     */
    public class func sendCloseApp(_ app: UIResponder , method: String? = #function , file: String? = #file) {
        self.sendData(String(describing: type(of: app)), file: file ?? "", method: method ?? "", type: .CloseApp )
    }
    
    /**
     SendCloseApp
     - parameters:
     - app: Self if running from UIView class
     */
    public class func sendCloseApp(_ view: UIView , method: String? = #function , file: String? = #file){
        self.sendData(String(describing: type(of: view)), file: file ?? "", method: method ?? "", type: .CloseApp )
    }
    
    /**
     SendButtonClick
     - parameters:
     - view: Self if running from UIView class
     */
    public class func sendButtonClick(_ view: UIView , method: String? = #function , file: String? = #file){
        self.sendData(String(describing: type(of: view)), file: file ?? "", method: method ?? "", type: .ButtonClick )
    }
    
    
    /**
     SendButtonClick
     - parameters:
     - view: Self if running from UIViewController class
     */
    public class func sendButtonClick(_ view: UIViewController , method: String? = #function , file: String? = #file){
        self.sendData(String(describing: type(of: view)), file: file ?? "", method: method ?? "", type: .ButtonClick)
    }
    
    /**
     SendViewOpen
     - parameters:
     - view: Self if running from UIView class
     */
    public class func sendViewOpen(_ view: UIView , method: String? = #function , file: String? = #file){
        self.sendData(String(describing: type(of: view)), file: file ?? "", method: method ?? "", type: .ViewOpen )
    }
    
    
    /**
     SendViewOpen
     - parameters:
     - view: Self if running from UIViewController class
     */
    public class func sendViewOpen(_ view: UIViewController , method: String? = #function , file: String? = #file){
        self.sendData(String(describing: type(of: view)), file: file ?? "", method: method ?? "", type: .ViewOpen)
    }
    
    /**
     SendViewClose
     - parameters:
     - view: Self if running from UIView class
     */
    public class func sendViewClose(_ view: UIView , method: String? = #function , file: String? = #file){
        self.sendData(String(describing: type(of: view)), file: file ?? "", method: method ?? "", type: .ViewClose )
    }
    
    /**
     SendViewClose
     - parameters:
     - view: Self if running from UIViewController class
     */
    public class func sendViewClose(_ view: UIViewController , method: String? = #function , file: String? = #file){
        self.sendData(String(describing: type(of: view)), file: file ?? "", method: method ?? "", type: .ViewClose)
    }
    
    /**
     Send
     - parameters:
     - view: Self if running from UIResponder class
     - type: of tpye SendType
     */
    public class func send(_ app: UIResponder, type: SendType , method: String? = #function , file: String? = #file) {
        self.sendData(String(describing: type(of: app)), file: file ?? "", method: method ?? "", type: type )
    }
    
    /**
     Send
     - parameters:
     - view: Self if running from UIView class
     - type: of tpye SendType
     */
    class func send(_ view: UIView ,type: SendType, method: String? = #function , file: String? = #file){
        self.sendData(String(describing: type(of: view)), file: file ?? "", method: method ?? "", type: type )
    }
    
    /**
     Send
     - parameters:
     - view: Self if running from UIViewController class
     - type: of tpye SendType
     */
    class func send(_ view: UIViewController ,type: SendType , method: String? = #function , file: String? = #file){
        self.sendData(String(describing: type(of: view)), file: file ?? "", method: method ?? "", type: type )
    }
    
    /**
     Send
     - parameters:
     - view: Self if running from UIResponder class
     */
    public class func send(_ app: UIResponder , method: String? = #function , file: String? = #file) {
        self.sendData(String(describing: type(of: app)), file: file ?? "", method: method ?? "" )
    }
    
    /**
     Send
     - parameters:
     - view: Self if running from UIView class
     */
    public class func send(_ view: UIView , method: String? = #function , file: String? = #file){
        self.sendData(String(describing: type(of: view)), file: file ?? "", method: method ?? "" )
    }
    
    /**
     Send
     - parameters:
     - view: Self if running from UIViewController class
     */
    public class func send(_ view: UIViewController , method: String? = #function , file: String? = #file){
        self.sendData(String(describing: type(of: view)), file: file ?? "", method: method ?? "" )
    }
    
    private class func sendData(_ className: String, file:String, method:String, type: SendType = .Generic ) {
        
        let doAnalytics = UserDefaults.standard.value(forKey: "doAnalytics") as? String ?? "0"
        
        if doAnalytics == "1" {
            
            let version = UserDefaults.standard.value(forKey: "version") as? String
            
            var newAnalytics = TBAnalyitcs()
            newAnalytics.className = className
            newAnalytics.fileName = file
            newAnalytics.method = method
            newAnalytics.timeStamp = self.nowDate
            newAnalytics.configVersion = version ?? "0.0"
            newAnalytics.tags = self.getTags()
            newAnalytics.type = type.rawValue
            self.sendUserAnalytics(newAnalytics)
        }
    }
    
    
    class private func sendUserAnalytics(_ tbAnalyitcs: TBAnalyitcs) {
        
        tbAnalyitcs.sendInBackground("") { (completed, data) in
            
            DispatchQueue.main.async {
                if (completed) {
                    print("sent")
                } else {
                    print("error")
                }
            }
            
        }
        
    }
    
}
