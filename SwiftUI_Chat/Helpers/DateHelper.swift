//
//  DateHelper.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 8/17/22.
//

import Foundation

class DateHelper {
    
    static func chatTimestampFrom(date: Date?) -> String {
        
        guard date != nil else {
            return ""
        }
        
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        
        return df.string(from: date!)
    }
    
}
