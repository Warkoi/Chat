//
//  ProfilePicView.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 8/7/22.
//

import SwiftUI

struct ProfilePicView: View {
    
    var user: User
    
    var body: some View {
       
        // Create URL from user photo url
        let photoURL = URL(string: user.Photo ?? "")
        
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
    }
}

struct ProfilePicView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicView(user: User())
    }
}
