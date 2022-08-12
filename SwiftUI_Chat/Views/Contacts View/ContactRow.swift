//
//  ContactRow.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 8/3/22.
//

import SwiftUI

struct ContactRow: View {
    
    var user: User
    
    var body: some View {
        
        
        
        HStack(spacing: 24){
            // Profile Image
            ProfilePicView(user: user)
            
            VStack(alignment:.leading, spacing: 4){
                //Name
                Text("\(user.FirstName ?? "") \(user.LastName ?? "")")
                    .font(Font.button)
                //Phone NUmber
                Text(user.Phone ?? "")
                    .font(Font.bodyParagraph)
                    .foregroundColor(Color("text-input"))
            }
            
            // Extra Space
            Spacer()
        }
        
        
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(user: User())
    }
}
