//
//  ConversationView.swift
//  SwiftUI_Chat
//
//  Created by Warkois on 8/7/22.
//

import SwiftUI

struct ConversationView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var isChatShowing: Bool
    
    @State var chatMessage = ""
    
    var body: some View {
        VStack (spacing: 0){
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
                .onAppear{
                    // call chat 
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
                    
                    ForEach (chatViewModel.messages) { msg in
                        
                        let isFromUser = msg.senderID == AuthViewModel.getLoggedInuserID()
                        // Dynamic Message
                        HStack{
                            
                            if isFromUser {

                                // Timestamp
                                Text(DateHelper.chatTimestampFrom(date: msg.timeStamp))
                                    .font(Font.smallText)
                                    .padding(.trailing)
                                
                                Spacer()
                            }
                            //Message
                            Text(msg.msg)
                                .font(Font.bodyParagraph)
                                .foregroundColor(isFromUser ? Color("text-button") : Color("text-primary"))
                                .padding(.vertical, 16)
                                .padding(.horizontal, 24)
                                .background(isFromUser ? Color("bubble-primary"): Color("bubble-secondary"))
                                .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                            
                            if !isFromUser {
                                Spacer()
                                
                                // Timestamp
                                Text(DateHelper.chatTimestampFrom(date: msg.timeStamp))
                                    .font(Font.smallText)
                                    .padding(.trailing)
                                
                            }
                            

                        }
                        
                    }
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 24)
            }
            .background(Color("backgroundcolor"))
            
            // Chat message bar
            ZStack{
                Color("backgroundcolor")
                    .ignoresSafeArea()
                HStack (spacing: 15){
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
                        
                        // Clean up text
                        
                        //Send message
                        chatViewModel.sendMessage(msg: chatMessage)
                        
                        // clear textbox
                        chatMessage = ""
                        
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
        .onAppear{
            //Call chat view model to retrieve all chats
            chatViewModel.getMessages()
        }
        
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(false))
    }
}
