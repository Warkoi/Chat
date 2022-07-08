//
//  ContentView.swift
//  swiftui-chat
//
//  Created by Warkois on 7/4/22.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .contacts
    
    
   
    var body: some View {
        
        VStack {
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        
        
    }
    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

