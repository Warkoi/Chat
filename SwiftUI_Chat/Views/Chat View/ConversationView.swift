//
//  ConversationView.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 8/7/22.
//

import SwiftUI

struct ConversationView: View {
    
    @Binding var isChatShowing: Bool
    
    @State var chatMessage = ""
    
    var body: some View {
        VStack(alignment: .leading){
            // Chat header
            HStack{
                VStack{
                    // Back arrow
                    Button{
                        
                        // Dismiss chat window
                        isChatShowing = false
                        
                    } label: {
                        
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color("text-primary"))
                    }
                    .padding(.bottom, 16)
                    
                    
                    // Name
                    Text("Albert Catano")
                        .font(Font.chatHeading)
                        .foregroundColor(Color("text-primary"))
                        
                    
                }
                
                Spacer()
                
                //Profile Image
                ProfilePicView(user: User())
            }
            .frame(height: 104)
            .padding(.horizontal)
            
            //Chat log
            ScrollView{
                
                VStack (spacing: 24){
                    //Their message
                    HStack{
                        
                        //Message
                        Text("Hi whats up")
                            .font(Font.bodyParagraph)
                            .foregroundColor(Color("text-primary"))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            .background(Color("bubble-secondary"))
                            .cornerRadius(30, corners: [.topLeft, .topRight, .bottomRight])
                        
                        Spacer()
                        
                        // Timestamp
                        Text("9:41")
                            .font(Font.smallText)
//                            .foregroundColor(Color("text-stamp"))
                    }.padding(.horizontal)
                    //Your message
                    
                    HStack{
                        
                        // Timestamp
                        Text("9:41")
                            .font(Font.smallText)
//                            .foregroundColor(Color("text-stamp"))
                        
                        Spacer()
                        
                        //Message
                        Text("Hi whats up")
                            .font(Font.bodyParagraph)
                            .foregroundColor(Color("text-button"))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            .background(Color("bubble-primary"))
                            .cornerRadius(30, corners: [.topLeft, .topRight, .bottomLeft])
                        
                       
                    }.padding(.horizontal)
                    
                }
                .padding(.horizontal)
                .padding(.top, 24)
            }
            .background(Color("backgroundcolor"))
            
            // Chat message bar
            ZStack{
                Color("backgroundcolor")
                    .ignoresSafeArea()
                HStack{
                    // Camera Button
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        
                    // Text Field
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color("date-pill"))
                            .cornerRadius(50)
                        
                        TextField("Type you message", text: $chatMessage)
                            .foregroundColor(Color("text-input"))
                            .font(Font.bodyParagraph)
                            .padding(10)
                       
                    
                        HStack{
                            
                            Spacer()
                            
                            Button{
                                //Emojis
                            } label: {
                                Image(systemName: "face.smiling")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color("text-input"))
                            }
                        }.padding(.trailing, 12)
                        
                    }
                    .frame(height: 44)
                    // Send Button
                    Button {
                        
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-primary"))
                    }
                }
                .padding(.horizontal)
                
            }
            .frame(height: 76)
        }
        
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(false))
    }
}
