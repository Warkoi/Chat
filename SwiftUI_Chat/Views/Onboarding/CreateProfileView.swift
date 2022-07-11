//
//  CreateProfileView.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/9/22.
//

import SwiftUI

struct CreateProfileView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var firstName = ""
    @State var lastName = ""
    
    
    var body: some View {
    
        VStack{
            
            Text("Setup your Profile")
                .font(Font.titleText)
                .padding(.top, 52)

            
            Text("Just a few more details to get started")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            Spacer()
           // Profile image button
            Button{
                //show action sheet
            }label: {
                ZStack{
                    Circle()
                        .foregroundColor(Color.white)
                    Circle()
                        .stroke(Color("create-profile-border"), lineWidth: 2)
                    
                    Image(systemName: "camera.fill")
                        .tint(Color("icons-input"))
                }
                .frame(width:134, height: 134)
                
            }
            Spacer()
            
            // First Name
            TextField("Given Name", text: $firstName)
                .textFieldStyle(CreateProfileTextFieldStyle())
                
            // Last Name
            
            TextField("Last Name", text: $lastName)
                .textFieldStyle(CreateProfileTextFieldStyle())
            
            Spacer()
            
            Button{
                //Next Step
                currentStep = .contacts
            } label: {
                Text("Next")
            }
            
            
            
            .buttonStyle(OnboardingButtonStyle())
        }
        .padding(.horizontal)
    
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(currentStep: .constant(.profile))
    }
}
