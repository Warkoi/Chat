//
//  VerficationView.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/9/22.
//

import SwiftUI
import Combine

struct VerficationView: View {
    
    @Binding var currentStep: OnboardingStep
    @Binding var isOnboarding: Bool
    
    @State var verificationCode = ""
    
    var body: some View {
        
        VStack{
            
            Text("Verfication")
                .font(Font.titleText)
                .padding(.top, 52)

            
            Text("Enter the 6-digit verification code we sent to your device")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            // Textfield
            ZStack{
                
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack{
                    TextField("", text: $verificationCode)
                        .font(Font.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(verificationCode)) { _ in
                            TextHelper.limitText(&verificationCode, 6)
                        }
                    Spacer()
                    Button {
                        // Clear text field
                        verificationCode = ""
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
                
                AuthViewModel.verifyCode(code: verificationCode) { error in
                    
                    if error == nil {
                        
                        // Check if this user has a profile
                        DatabaseService().checkUserProfile { exists in
                            if exists {
                                // End onboarding
                                isOnboarding = false
                            }
                            else{
                                //Next Step
                                                        currentStep = .profile
                            }
                        }
//
                    }
                    else{
//
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

struct VerficationView_Previews: PreviewProvider {
    static var previews: some View {
        VerficationView(currentStep: .constant(.verfication), isOnboarding: .constant(true))
    }
}
