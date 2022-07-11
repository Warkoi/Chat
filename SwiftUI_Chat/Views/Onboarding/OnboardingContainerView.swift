//
//  OnboardingContainerView.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 7/9/22.
//

import SwiftUI

enum OnboardingStep: Int {
    
    case welcome = 0
    case phonenumber = 1
    case verfication = 2
    case profile = 3
    case contacts = 4
}
struct OnboardingContainerView: View {
    
    @Binding var isOnboarding: Bool
    @State var currentStep: OnboardingStep = .welcome
    
    var body: some View {
        
        ZStack{
            Color("backgroundcolor")
                .ignoresSafeArea(edges: [.top, .bottom])
            
            switch currentStep {
            case .welcome:
                WelcomeView(currentStep: $currentStep)
            case .phonenumber:
                PhoneNumberView(currentStep: $currentStep)
            case .verfication:
                VerficationView(currentStep: $currentStep)
            case .profile:
                CreateProfileView(currentStep: $currentStep)
            case .contacts:
                SynchContactsView(isOnboarding: $isOnboarding)
            }
            
        }
    }
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContainerView(isOnboarding: .constant(true))
    }
}
