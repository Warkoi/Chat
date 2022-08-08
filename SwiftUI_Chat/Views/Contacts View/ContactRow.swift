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
        
        // Create URL from user photo url
        let photoURL = URL(string: user.Photo ?? "")
        
        HStack(spacing: 24){
            // Profile Image
            ZStack{
                
                //Check if user has a photo
                if user.Photo == nil {
                    Circle()
                        .foregroundColor(.white)
                    
                    Text(user.FirstName?.prefix(1) ?? "")
                        .bold()
                }
                else{
                    // Profile image
                    AsyncImage(url: photoURL) { phase in
                        
                        switch phase {
                        case .empty: ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFill()
                                .clipped()
                        case .failure:
                            Circle()
                                .foregroundColor(.white)
                            
                            Text(user.FirstName?.prefix(1) ?? "")
                                .bold()
                            
                        }
                    }
                    
                    
                    Circle()
                        .stroke(Color("create-profile-border"), lineWidth: 2)
                }
                
                
            }
            .frame(width: 44, height: 44)
            
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
