//
//  DatabaseService.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/11/22.
//

import Foundation
import Contacts
import Firebase

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
    
    
}
