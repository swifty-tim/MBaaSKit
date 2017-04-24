//
//  Date+Ext.swift
//  Pods
//
//  Created by Timothy Barnard on 26/02/2017.
//
//

import Foundation

#if os(iOS)
    import UIKit
#elseif os(watchOS)
    import WatchKit
#endif


public extension Date {
    
    /**
     Converts date to string to default format yyyy-MM-dd'T'HH:mm:ss.SSSZ
     
     - parameter format: String
     
     - returns: String date
     */
    public func toDateString(_ dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let timeString = formatter.string(from: self)
        
        return timeString
    }
    
    /**
     Converts time to string format HH:mm
     
     - returns: String date
     */
    public func toTimeString() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: self)
        
        return timeString
    }
    
    /**
     Retrieves hour from date
     
     - returns: Integer hour
     */
    public func hour() -> Int {
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self as Date)
        return hour
    }
    
    /**
     Retrieves minute from date
     
     - returns: Intger minute
     */
    public func minute() -> Int {
        
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: self as Date)
        return minute
    }
    
    /**
     Retrieves day from date
     
     - returns: Integer day
     */
    public func day() -> Int {
        
        let calendar = Calendar.current
        let minute = calendar.component(.day, from: self as Date)
        return minute
    }
    
    /**
     Retrieves weekday from date
     
     - returns: Integer weekday
     */
    public func weekday() -> Int {
        
        let calendar = Calendar.current
        let minute = calendar.component(.weekday, from: self as Date)
        return minute
    }
    
    
}
