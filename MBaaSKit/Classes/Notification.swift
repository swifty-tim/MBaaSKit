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
    
    init(){}
    
    func setDeviceID(_ deviceID:String) {
        self.deviceID = deviceID
    }
    func setMessage(_ message:String) {
        self.message = message
    }
    func setUserID(_ userID:String) {
        self.userID = userID
    }
    func setTitle(_ title:String) {
        self.title = title
    }
    func setBadgeNo(_ no: Int) {
        self.badgeNo = "\(no)"
    }
    func setContentAvailable(_ set: Bool) {
        switch set {
        case true:
            self.contentAvailable = "1"
        default:
            self.contentAvailable = "0"
        }
    }
    
    /**
     Send Notificaitons
     - parameters:
     - appKey:
     - notificationCompleted: return value of success state
     - succeeded:
     - data: message back if sent
     */
    func sendNotification(_ appKey: String = "", notificationCompleted : @escaping (_ succeeded: Bool, _ data: String) -> ()) {
        
        var url: String = ""
        url = url.readPlistString(value: "URL", "http://0.0.0.0:8181")
        
        var key: String = ""
        
        if appKey != "" {
            key = appKey
        } else {
            key = key.readPlistString(value: "APPKEY", "")
        }
        
        let apiEndpoint = "/api/" + key
        
        let networkURL =  url + apiEndpoint + "/notification/"
        
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
