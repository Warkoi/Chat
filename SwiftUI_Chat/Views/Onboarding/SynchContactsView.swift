//
//  SynchContactsView.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/9/22.
//

import SwiftUI

struct SynchContactsView: View {
    
//    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var isOnboarding: Bool
    
    var body: some View {
        
        VStack{
            Spacer()
            
            Image("onboarding-all-set")
            
            Text("Awesome")
                .font(Font.titleText)
                .padding(.top, 32)
            
            Text("Continue to start chatting with your friends")
                .font(Font.bodyParagraph)
                .padding(.top, 8)
            
            Spacer()
            
            Button{
                //End Onboarding
                isOnboarding = false
                
            }label:{
                Text("Continue")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)

        }
        .padding(.horizontal)
       
    }
    
}

struct SynchContactsView_Previews: PreviewProvider {
    static var previews: some View {
        SynchContactsView(isOnboarding: .constant(true))
    }
}
