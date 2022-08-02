//
//  ContactsListView.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/28/22.
//

import SwiftUI

struct ContactsListView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @State var filterText = ""
    
    var body: some View {
        
        VStack {
            HStack{
                Text("Contacts")
                    .font(Font.pageTitle)
                Spacer()
                Button{
                    
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icons-secondary"))
                }
            }
            .padding(.top, 20)
            // Search bar
            ZStack{
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                TextField("Search for contact or number", text: $filterText)
                    .font(Font.tabBar)
                    .padding()
                
            }
            .frame(height: 46)
            
            if contactsViewModel.users.count > 0 {
                // List
                List(contactsViewModel.users){ user in
                    
                    Text(user.FirstName ?? "Test User")
                    
                }
                .listStyle(.plain)
            }
            else {
                Spacer()
                
                Image("no-contacts-yet")
                
                Text("Hmm... Zero contacts?")
                    .font(Font.titleText)
                    .padding(.top, 32)
                
                Text("Try saving some contacts on your phone!")
                    .font(Font.bodyParagraph)
                    .padding(.top, 8)
                
                Spacer()
            }
            
        }
        .padding(.horizontal)
        .onAppear{
            // Get local contacts
            contactsViewModel.getLocalContacts()
        }
    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView()
    }
}
