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
    
    static func getLoggedInUserPhone() -> String {
        return Auth.auth().currentUser?.phoneNumber ?? ""
    }
    
    static func logout(){
        try? Auth.auth().signOut()
    }
    
    static func sendPhoneNumber(phone: String, completion: @escaping (Error?) -> Void) {
        
        //Send the phone number
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil)
        { verficationID, error in
            if error == nil {
                UserDefaults.standard.set(verficationID, forKey: "authVerificationID")
                
                
            }
            // Notify the UI
            DispatchQueue.main.async {
                // Notify the UI
                completion(error)
            }
            
        }
    }
    
    static func verifyCode(code: String, completion: @escaping (Error?) -> Void){
        
        // Get the verication id from local storage
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        
        // send the code
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        
        //Sign in the user
        Auth.auth().signIn(with: credential){
            authResult, error in
            
            DispatchQueue.main.async {
                // Notify the UI
                completion(error)
            }
           
            
        }
    }
}
