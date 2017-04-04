//
//  InstallationObject.swift
//  Pods
//
//  Created by Timothy Barnard on 19/02/2017.
//
//
import Foundation

public struct TBInstallation: TBJSONSerializable {
    
    private var date:String!
    private var token:String!
    private var buildVersion:String!
    private var buildName:String!
    private var OSVersion:String!
    private var deviceModel:String!
    
    
    /**
     Initialise object with device token
     
     - parameter deviceToken: Data
     */
    public init(deviceToken:Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        self.token = token
        self.getBuildValues()
        self.date = TBTime.nowDateTime()
    }
    
    public init() {}
    
    public init(jsonObject : TBJSON) {}
    
    //MARK: - Internal methods
    internal mutating func getBuildValues() {
        
        self.buildVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        self.buildName = RCFileManager.readPlistString(value: "CFBundleDisplayName")
        
        #if os(iOS) || os(tvOS)
            self.OSVersion = UIDevice.current.systemVersion as String
            self.deviceModel = UIDevice.current.model as String
        #endif
    }
}

class TBTime {
    
    static func nowDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        
        return dateFormatter.string(from: Date())
    }
}
