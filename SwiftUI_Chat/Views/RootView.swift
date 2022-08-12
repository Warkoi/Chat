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
    @State var isChatShowing = false
    
    
   
    var body: some View {
        
        
        
        ZStack {
            
            Color("backgroundcolor")
                .ignoresSafeArea()
            VStack {
                
                switch selectedTab {
                case .chats:
                    ChatsListView()
                case .contacts:
                   ContactsListView(isChatShowing: $isChatShowing)
                }
                   
                
                Spacer()
                
                CustomTabBar(selectedTab: $selectedTab)
            }
            
        }.fullScreenCover(isPresented: $isOnboarding) {
            // on dismiss
        } content: {
           OnboardingContainerView(isOnboarding: $isOnboarding)
        }
        .fullScreenCover(isPresented: $isChatShowing, onDismiss: nil) {
            ConversationView(isChatShowing: $isChatShowing)
        }
        
        
    }
    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

