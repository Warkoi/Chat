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
                    
                    fileRef.downloadURL { url, error in
                        
                        // Check for errors
                        if url != nil && error == nil {
                            // Set that image path to the profile
                            doc.setData(["photo": url!.absoluteString], merge: true)
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
            }
        }
        else {
            // No image was set
            completion(true)
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
    
    // MARK: - Chat Methods
    
    /// This method returns all chat documents where the logged in user is a participant.
    func getAllChats(completion: @escaping ([Chat]) -> Void){
        
        // Get a reference to the DB
        let db = Firestore.firestore()
        
        // Perform a query against the chat collection for any chats where the user is a participant
        let chatsQuery = db.collection("Chats").whereField("participantsID", arrayContains: AuthViewModel.getLoggedInuserID())
        
        chatsQuery.getDocuments{ snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var chats = [Chat]()
                
                // Looop through all the returned chat docs
                for doc in snapshot!.documents{
                    
                    // Parse the data int Chat structs
                    let chat = try? doc.data(as: Chat.self)
                    
                    // Add the chat into the array
                    if let chat = chat {
                        chats.append(chat)
                    }
                }
                
                // Return the data
                completion(chats)
                
            }
            else {
                print("Error in db retrieval")
            }
            
        }
        
    }
    
    /// This method returns all message for a given chat
    func getAllMessages(chat: Chat, completion: @escaping ([ChatMessage]) -> Void){
        
        // Check that the ID is not nil
        guard chat.id != nil else {
            // Cant' fetch data
            completion([ChatMessage]())
            return
        }
        
        // Get a reference to teh database
        let db = Firestore.firestore()
        
        let msgsQuery = db.collection("Chats")
            .document(chat.id!)
            .collection("msgs")
            .order(by:"timeStamp")
        
        // Perform the query
        msgsQuery.getDocuments { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                //Loop through the msg documents and create ChatMessage instances
                var messages = [ChatMessage]()
                
                for doc in snapshot!.documents {
                    let msg = try? doc.data(as: ChatMessage.self)
                    
                    if let msg = msg {
                        messages.append(msg)
                        
                    }
                }
                
                //Return the results
                completion(messages)
            }
            else {
                print("Error in db retrieval")
            }
            
        }
    }
    
    /// Send a message to the DB
    
    func sendMessage(msg: String, chat: Chat){
        
        // Check that it's a valid chat
        guard chat.id != nil else {
          return
        }
        
        let db = Firestore.firestore()
        
        // Add msg document
        db.collection("Chats")
            .document(chat.id!)
            .collection("msgs")
            .addDocument(data: ["imageURL": "",
                                "msg": msg,
                                "senderID": AuthViewModel.getLoggedInuserID(),
                                "timeStamp": Date()])
        
    }
    
    
}
