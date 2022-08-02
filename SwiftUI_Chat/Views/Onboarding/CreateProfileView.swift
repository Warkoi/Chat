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
    
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    
    @State var isSourceDialogShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State var isSaveButtonDisabled = false
    
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
               isSourceDialogShowing = true
                
            }label: {
                ZStack{
                    
                    if selectedImage != nil {
                        
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                        
                    } else {
                        Circle()
                            .foregroundColor(Color.white)
                        
                        
                        Image(systemName: "camera.fill")
                            .tint(Color("icons-input"))
                    }
                    Circle()
                        .stroke(Color("create-profile-border"), lineWidth: 2)
                    
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
                
                // Prevent double tapping
                isSaveButtonDisabled = true
                //Next Step
                
                //Save the data
                
                DatabaseService().setUserProfile(firstName: firstName, lastName: lastName, image: selectedImage){ isSuccess in
                    if isSuccess {
                        currentStep = .contacts
                       
                    }
                    else{
                        
                    }
                    isSaveButtonDisabled = false
                }
                
                
            } label: {
                Text( isSaveButtonDisabled ? "Uploading" : "Save")
            }
            .buttonStyle(OnboardingButtonStyle())
            .disabled(isSaveButtonDisabled)
        }
        .padding(.horizontal)
        .confirmationDialog("From where?", isPresented: $isSourceDialogShowing, actions: {
            
            Button{
                // Set the source to photo library
                // Show the image picker
                self.source = .photoLibrary
                isPickerShowing = true
    
            } label: {
                Text("Photo Library")
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                Button{
                    // Set the source to camera
                    self.source = .camera
                    isPickerShowing = true
                }label: {
                    Text("Take Photo")
                }
            }
            
            
            
        })
        .sheet(isPresented: $isPickerShowing) {
            //Show Image Picker
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: self.source)
        }
    
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(currentStep: .constant(.profile))
    }
}
