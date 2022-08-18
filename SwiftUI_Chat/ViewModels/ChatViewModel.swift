//
//  ChatViewModel.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 8/13/22.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject{
    
    @Published var chats = [Chat]()
    
    @Published var selectedChat: Chat?
    
    @Published var messages = [ChatMessage]()
    
    
    var databaseService = DatabaseService()
    
    init(){
        //Retreive chats when ChatViewModel is create
        getChats()
    }
    
    func getChats() {
        
        //Use the DB service to get the chats
        databaseService.getAllChats { chats in
            
            self.chats = chats
        }
        //Set the retreived data to the chats property
    }
    
    func getMessages() {
        // Check that thers a selected chat
        guard selectedChat != nil else {
            return
        }
        
        databaseService.getAllMessages(chat: selectedChat!) {msgs in
            
            //set returned to property
            self.messages = msgs
        }
    }
    
    func sendMessage(msg: String){
        // Check that we have a selected chat
        guard selectedChat != nil else {
            return
        }
        
        databaseService.sendMessage(msg: msg, chat: selectedChat!)
    }
    
    
    
}
