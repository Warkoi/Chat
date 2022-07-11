//
//  OnboardingButtonStyle.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/9/22.
//

import Foundation
import SwiftUI

struct OnboardingButtonStyle: ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        
        ZStack{
            Rectangle()
                .frame(height: 50)
                .cornerRadius(4)
                .foregroundColor(Color("button-primary"))
            
            configuration.label
                .font(Font.button)
                .foregroundColor(Color("text-button"))
                
        }
    }
}
