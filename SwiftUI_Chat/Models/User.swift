//
//  User.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/11/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    
    @DocumentID var id: String? 
    
    var FirstName: String?
    
    var LastName: String?
    
    var Phone: String?
    
    var Photo: String?
    
}
