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
    
    @Binding var isChatShowing: Bool
    
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
            .onChange(of: filterText) { _ in
                // Filter the results
                contactsViewModel.filteredContacts(filterBy:
                                                    filterText.lowercased()
                    .trimmingCharacters(in: .whitespacesAndNewlines))
            }
            
            if contactsViewModel.filteredUsers.count > 0 {
                // List
                List(contactsViewModel.filteredUsers){ user in
                    
                    Button{
                        
                        isChatShowing = true
                        
                    } label: {
                        ContactRow(user: user)
                            
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(Visibility.hidden)
                    
                }
                .listStyle(.plain)
                .padding(.top, 12)
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
        ContactsListView(isChatShowing: .constant(false))
    }
}
