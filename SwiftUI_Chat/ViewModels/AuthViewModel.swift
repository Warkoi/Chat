//
//  AuthViewModel.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/8/22.
//

import Foundation
import FirebaseAuth


class AuthViewModel {
    
    static func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
        
    }
    
    static func getLoggedInuserID() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    static func logout(){
        try? Auth.auth().signOut()
    }
}
