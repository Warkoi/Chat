//
//  CreateProfileTextFieldStyle.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/10/22.
//

import Foundation
import SwiftUI


struct CreateProfileTextFieldStyle: TextFieldStyle {
    
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(Color("input"))
                .cornerRadius(8)
                .frame(height: 46)
            
            // This references the textfield
            configuration
                .font(Font.chatHeading)
                .padding()
            
        }
        
    }
    
}
