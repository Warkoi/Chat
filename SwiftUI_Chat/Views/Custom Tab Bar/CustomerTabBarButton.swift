//
//  CustomTabBarButton.swift
//  swiftui-chat
//
//  Created by Warkois on 7/6/22.
//

import SwiftUI

struct CustomTabBarButton: View {
    
    var buttonText: String
    var imageName: String
    var isActive: Bool
    
    var body: some View {
        
        GeometryReader { geo in
            
            if isActive{
                
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geo.size.width/2, height: 4)
                    .padding(.leading, geo.size.width/4)
            }
            
            VStack (alignment: .center, spacing: 4){
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text("Contacts")
                    .font(Font.tabBar)
            }.frame(width: geo.size.width, height: geo.size.height)
        }
        
    }
}

struct CustomTabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarButton(buttonText: "Chats", imageName: "bubble.left" , isActive: true)
    }
}

