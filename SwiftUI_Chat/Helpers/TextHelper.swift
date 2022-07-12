//
//  TextHelper.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/11/22.
//

import Foundation

class TextHelper {
    
    static func sanitzePhoneNumber(_ phone: String) -> String {
        
        return phone
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: " ", with: "")
        
    }
    
}
