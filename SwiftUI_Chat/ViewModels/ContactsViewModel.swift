//
//  ContactsViewModel.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/10/22.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject{
    
    private var users = [User]()
    
    private var filteredText = ""
    
    @Published var filteredUsers = [User]()
    
    
    private var localContacts = [CNContact]()
    
    func getLocalContacts(){
        
        DispatchQueue.init(label: "getcontacts").async{
            do {
            //Ask for permission
            let store = CNContactStore()
            
            // List of keys we want to get
            let keys = [CNContactPhoneNumbersKey,CNContactGivenNameKey,CNContactFamilyNameKey] as! [CNKeyDescriptor]
                
            // Create a Fetch request
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
                
            
            //Get contacts
            
                try store.enumerateContacts(with: fetchRequest, usingBlock: {contact, success in
                    // Do somehting with the contact
                    self.localContacts.append(contact)
                })
                
               // See which local contacts are actually users of this app
            
                DatabaseService().getPlatformUsers(localContacts: self.localContacts) { platformUsers in
                    
                    // Update the UI in the main thread
                    DispatchQueue.main.async {
                    
                        // Set the fetched users to the published users property
                        self.users = platformUsers
                        
                        // Set the filtered list
                        self.filteredContacts(filterBy: self.filteredText)
                        
                    }
                    
                   
                    
                }
                
                
            }
            catch {
                
            }
        }
        
        
    }
    
    func filteredContacts(filterBy: String){
        
        // Store parameter into property
        self.filteredText = filterBy
        
        // If filter is empty show all users
        if filteredText == "" {
            self.filteredUsers = users
            return
        }
        
        // Filter user list
        self.filteredUsers = users.filter({ user in
            
            //Criteria for including User
            user.FirstName?.lowercased().contains(filteredText) ?? false ||
            user.LastName?.lowercased().contains(filteredText) ?? false ||
            user.Phone?.lowercased().contains(filteredText) ?? false
            
        })
        
    }
    
}
