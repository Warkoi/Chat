//
//  SwiftUI_ChatApp.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/7/22.
//

import SwiftUI

@main
struct SwiftUI_ChatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
