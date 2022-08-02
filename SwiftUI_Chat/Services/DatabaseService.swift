//
//  DatabaseService.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/11/22.
//

import Foundation
import Contacts
import Firebase
import UIKit
import FirebaseStorage
import FirebaseFirestore

class DatabaseService {
    
    func getPlatformUsers(localContacts: [CNContact], completion: @escaping ([User]) -> Void) {
        
        var platformUsers = [User]()
        
        //Construct an array of string phone numbers to look up
        var lookupPhoneNumbers =  localContacts.map { contact  in
            
            // Turn the contact into a phone number as a string
            return TextHelper.sanitzePhoneNumber(contact.phoneNumbers.first?.value.stringValue ?? "")
            
        }
        
        //Make suer that there are lookup nubmers
        guard lookupPhoneNumbers.count > 0 else {
            
            // Callback
            completion(platformUsers)
            return
        }
        
        //Query the DB for these phone numbers
        let db = Firestore.firestore()
        
        
        
        // Perform queries while we still have phone numbers to look up
        while !lookupPhoneNumbers.isEmpty {
            
            // Get the first < 10 phone numbers to look up
            let tenPhoneNumbers = Array(lookupPhoneNumbers.prefix(10))
            
            // Remove the < 10 that we're looking up
            lookupPhoneNumbers = Array(lookupPhoneNumbers.dropFirst(10))
            
            let query = db.collection("users").whereField("Phone", in: tenPhoneNumbers)
            
            //Retrieve the users that are on the platform
            query.getDocuments { snapshot, error in
                
                if error == nil && snapshot != nil {
                    
                    //for each doc that was fetched, create a user
                    for doc in snapshot!.documents{
                        
                        if let user = try? doc.data(as: User.self){
                            
                            platformUsers.append(user)
                            // Append to the platform Users Array
                        }
                    }
                    
                    // Check if we have anymore phone numbers to look up
                    // If not , we can call the complietion block and we are done
                    
                    if lookupPhoneNumbers.isEmpty{
                        
                        //Return these users
                        completion(platformUsers)
                    }
                }
                
            }
            
        }
        
        
        
        
        
    }
    
    func setUserProfile(firstName: String, lastName: String, image: UIImage?, completion: @escaping(Bool) -> Void){
        
        // Ensure that the user is logged in
        guard AuthViewModel.isUserLoggedIn() != false else {
            // User is not logged in
            return
        }
        
        // Get user's phone number
        let userPhone = TextHelper.sanitzePhoneNumber(AuthViewModel.getLoggedInUserPhone())
        
        //Get a reference to the Firestore
        let db = Firestore.firestore()
        
        //Set the profile data
        let doc = db.collection("users").document(AuthViewModel.getLoggedInuserID())
        doc.setData(["firstName": firstName,
                     "lastName": lastName,
                     "phone": userPhone])
        
        //Check if an image is passed through
        if let image = image {
            //Upload the image data
            
            // Create storage reference
            let storageRef = Storage.storage().reference()
            
            //Turn image into data
            let imageData = image.jpegData(compressionQuality: 0.8)
            
            guard imageData != nil else {
                return
            }
            
            // Specify the file path and name
            let path = "images/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            
            let uploadTask = fileRef.putData(imageData!, metadata: nil) { meta, error in
                
                if error == nil && meta != nil{
                    doc.setData(["photo": path], merge: true)
                    if error == nil {
                        // Success, notify caller
                        completion(true)
                    }
                }
                else {
                    // Upload wasnt succesful, notify caller
                    completion(false)
                    
                }
            }
        }
        
        
        //Check if an image is passed through
        
        
        
    }
    
    func checkUserProfile(completion: @escaping (Bool) -> Void){
        
        // Check that the user is logged in
        guard AuthViewModel.isUserLoggedIn() != false else {
            return
        }
        // Create firebase ref
        let db = Firestore.firestore()
        
        db.collection("users").document(AuthViewModel.getLoggedInuserID()).getDocument {
            snapshot, error in
            
            if snapshot != nil && error == nil {
                completion(snapshot!.exists)
            }
            else{
                completion(false)
            }
            
        }
    }
    
    
}
