//
//  Date+Ext.swift
//  Pods
//
//  Created by Timothy Barnard on 26/02/2017.
//
//

import Foundation
import UIKit

extension Date {
    
    func toDateString(_ dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let timeString = formatter.string(from: self)
        
        return timeString
    }
    
    func toTimeString() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: self)
        
        return timeString
    }
    
    func hour() -> Int {
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self as Date)
        return hour
    }
    
    
    func minute() -> Int {
        
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: self as Date)
        return minute
    }
    
    func day() -> Int {
        
        let calendar = Calendar.current
        let minute = calendar.component(.day, from: self as Date)
        return minute
    }
    
    func weekday() -> Int {
        
        let calendar = Calendar.current
        let minute = calendar.component(.weekday, from: self as Date)
        return minute
    }
    
    
}
