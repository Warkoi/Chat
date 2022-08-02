//
//  PhoneNumberView.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/9/22.
//

import SwiftUI
import Combine

struct PhoneNumberView: View {
    
    @Binding var currentStep: OnboardingStep
    
    @State var phoneNumber = ""
    
    
    
    var body: some View {
        
        VStack{
            
            Text("Verfication")
                .font(Font.titleText)
                .padding(.top, 52)

            
            Text("Enter you mobile number below. We'll send you a verification code after.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            // Textfield
            ZStack{
                
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack{
                    TextField("e.g. +1 613 515 0123", text: $phoneNumber)
                        .font(Font.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(phoneNumber)) {_ in
                            TextHelper.applyPatternOnNumbers(&phoneNumber, pattern: "+# (###) ###-####", replacementCharacter: "#")
                        }
                    
                    Spacer()
                    
                    Button {
                        // Clear text field
                        phoneNumber = ""
                    }label:{
                        Image(systemName: "multiply.circle.fill")
                    }
                        .frame(width: 19, height: 19)
                        .tint(Color("icons-input"))
                    
                }.padding()
                
                
                
            }
            .padding(.top, 34)
            Spacer()
            Button{
                // Send their phone number to Firebase Auth
                
                AuthViewModel.sendPhoneNumber(phone: phoneNumber) { error in
                    // Check for errors
                    if error == nil {
                        //Next Step
                        currentStep = .verfication
                    }
                    else {
                        
                    }
                }
                
                
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
        }
        .padding(.horizontal)
    }
}

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(currentStep: .constant(.phonenumber))
    }
}
