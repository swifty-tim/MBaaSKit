//
//  Float+Ext.swift
//  Pods
//
//  Created by Timothy Barnard on 05/02/2017.
//
//

import Foundation

public extension Float {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}


public extension CGFloat {
    var radians: CGFloat {
        return self * CGFloat(2 * Double.pi / 360)
    }
    
    var degrees: CGFloat {
        return 360.0 * self / CGFloat(2 * Double.pi)
    }
}
