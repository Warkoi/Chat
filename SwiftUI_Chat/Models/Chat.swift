//
//  Chat.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 8/11/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Chat: Codable, Identifiable{
    
    @DocumentID var id: String?
    
    var lastMessage: String?
    var numParticipants: Int
    var participantsID: [String]
    
    @ServerTimestamp var updated: Date?
    
    var msgs: [ChatMessage]?
    
}

struct ChatMessage: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var imageURL: String?
    var msg: String
    @ServerTimestamp var timeStamp: Date?
    var senderID: String
    
}

