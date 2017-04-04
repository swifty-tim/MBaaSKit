//
//  Notification.swift
//  Pods
//
//  Created by Timothy Barnard on 06/02/2017.
//
//

import Foundation

public class TBNotification {
    
    private var deviceID: String = ""
    private var message: String = ""
    private var userID: String = ""
    private var badgeNo: String = ""
    private var contentAvailable: String = ""
    private var title:String = ""
    private var status:String = "0"
    
    public init(){}
    
    public func setDeviceID(_ deviceID:String) {
        self.deviceID = deviceID
    }
    public func setMessage(_ message:String) {
        self.message = message
    }
    public func setUserID(_ userID:String) {
        self.userID = userID
    }
    public func setTitle(_ title:String) {
        self.title = title
    }
    public func setBadgeNo(_ no: Int) {
        self.badgeNo = "\(no)"
    }
    public func setContentAvailable(_ set: Bool) {
        switch set {
        case true:
            self.contentAvailable = "1"
        default:
            self.contentAvailable = "0"
        }
    }
    
    
    private func getParamValues() -> (Bool, String) {
        
        var parameters = [String: AnyObject]()
        
        #if DEBUG
            parameters["testMode"] = "1" as AnyObject
        #endif
        
        if let buildVersion: AnyObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject? {
            parameters["appVersion"] = buildVersion
        }
        
        let parameterString = parameters.stringFromHttpParameters()
        
        return ( parameters.count > 0, "?" + parameterString )
    }

    
    /**
     Send Notificaitons
     - parameter appKey:
     - paramater notificationCompleted: return value of success state
     - paramater succeeded:
     - paramter: callback data: message back if sent
     */
    public func sendNotification(_ appKey: String = "", notificationCompleted : @escaping (_ succeeded: Bool, _ data: String) -> ()) {
        
        var url: String = ""
        url = url.readPlistString(value: "URL", "http://0.0.0.0:8181")
        
        var key: String = ""
        
        if appKey != "" {
            key = appKey
        } else {
            key = key.readPlistString(value: "APPKEY", "")
        }
        
        let apiEndpoint = "/api/" + key
        
        var networkURL =  url + apiEndpoint + "/notification/"
        
        let ( paramExist, paramValues) = getParamValues()
        
        if paramExist {
            networkURL = networkURL + paramValues
        }
    
        
        if (self.deviceID == "" && self.message == "") || (self.userID == "" && self.message == "") {
            notificationCompleted(false, "values not set")
            return
        }
        
        guard let endpoint = NSURL(string: networkURL) else {
            print("Error creating endpoint")
            notificationCompleted(false, "url incorrect")
            return
        }
        let request = NSMutableURLRequest(url: endpoint as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        #if DEBUG
            request.addValue("1", forHTTPHeaderField: "testMode")
        #endif
        
        let dict : [String:AnyObject] = [
            "deviceId":self.deviceID as AnyObject,
            "message":self.message as AnyObject,
            "userID":self.userID as AnyObject,
            "badgeNo":self.badgeNo as AnyObject,
            "contentAvailable":self.contentAvailable as AnyObject,
            "title":self.title as AnyObject,
            "status":self.status as AnyObject
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: dict, options: [])
        } catch {
            //err = error
            request.httpBody = nil
        }
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error -> Void in
            
            if ((error) != nil) {
                print(error!.localizedDescription)
                notificationCompleted(false, "not sent")
            } else {
                notificationCompleted(true, "sent")
            }
        })
        task.resume()
        
    }
}
