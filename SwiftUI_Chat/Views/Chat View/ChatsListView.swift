//
//  ChatsListView.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/28/22.
//

import SwiftUI

struct ChatsListView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var isChatShowing: Bool
    
    var body: some View {
        
        if chatViewModel.chats.count > 0 {
            List(chatViewModel.chats) { chat in
                
                Button {
                    
                    // Set selected chat for the chatviewmodel
                    chatViewModel.selectedChat = chat
                    
                    //display conversation view
                    isChatShowing = true
                    
                    
                } label: {
                    Text(chat.id ?? "Empty Chat ID")
                }
                
                
            }
        }
        else {
            Text("No Chats")
        }
        
        VStack {
            
            //Chat header
            HStack{
                VStack {
                    // Back arrow
                    // Name
                }
            }
            //Chat log
            
            //
        }
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView(isChatShowing: .constant(false))
    }
}
