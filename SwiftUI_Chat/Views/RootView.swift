//
//  ContentView.swift
//  swiftui-chat
//
//  Created by Warkois on 7/4/22.
//

import SwiftUI

struct RootView: View {
    
    
    @State var selectedTab: Tabs = .contacts
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    
   
    var body: some View {
        
        
        
        VStack {
            
            Text("Hello World")
                .padding()
                .font(Font.chatHeading)
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .fullScreenCover(isPresented: $isOnboarding) {
            // on dismiss
        } content: {
           OnboardingContainerView(isOnboarding: $isOnboarding)
        }
        
        
    }
    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

