//
//  ChatRow.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Ahmet Mert ÖZ on 19.06.2022.
//

import SwiftUI
import Firebase
struct ChatRow: View {
    
    var chatMessage : ChatModel
    var userToChatFromChatView : userModel
    
    
    var body: some View {
        
        Group {
            
            
            
            if chatMessage.messageFrom == Auth.auth().currentUser?.uid && chatMessage.messageTo == userToChatFromChatView.uidFromFirebase {
                
                HStack{
                    Text(chatMessage.message)
                        .bold()
                        .foregroundColor(.black)
                        .padding()
                    
                    Spacer()
                }
                
            }else if chatMessage.messageFrom == userToChatFromChatView.uidFromFirebase && chatMessage.messageTo == Auth.auth().currentUser?.uid{
                
                HStack{
                    Spacer()
                    Text(chatMessage.message)
                        .bold()
                        .foregroundColor(.black)
                        .padding()
                    
                    
                }
                
            }else{
                //gösterme
            }
                
                
            
        }.frame(width: UIScreen.main.bounds.width * 0.95)
        
        
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chatMessage: ChatModel(id: 2, message: "asdnf", uidFromFirebase: "osdkj", messageFrom: "sjdnfg", messageTo: "jewkfln", messageDate: Date(), messageFromMe: false), userToChatFromChatView: userModel(name: "haha", uidFromFirebase: "ıehewr"))
    }
}
