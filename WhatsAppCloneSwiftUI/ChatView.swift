//
//  ChatView.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Ahmet Mert ÖZ on 17.06.2022.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ChatView: View {
    
    var userToChat : userModel
    @State var messageToSend : String = ""
    @ObservedObject var chatStore = ChatStore()
    
    
    
    let db = Firestore.firestore()
    
    var body: some View {
        
        VStack{
            
            /*List(chatStore.chatArray){ chats in
                
                ChatRow(chatMessage: chats, userToChatFromChatView: self.userToChat)
            }*/
            
            ScrollView{
                
                ForEach(chatStore.chatArray){ chats in
                    ChatRow(chatMessage: chats, userToChatFromChatView: self.userToChat)
                }
                
            }
            
            
            HStack{
                TextField("Type Here...", text: $messageToSend)
                    .padding()
                Button {
                    //Mesajı yolla fonksiyonu
                    messageToSendFirebase()
                } label: {
                    Text("Send")
                        .padding()
                        .foregroundColor(.blue)
                }

            }
        }
        
    }
    
    
    func messageToSendFirebase(){
        
        var ref : DocumentReference? = nil
        
        var myChatDictionary : [String : Any] = ["chatUserFrom" : Auth.auth().currentUser?.uid, "chatUserTo" : userToChat.uidFromFirebase, "date": generateDate(), "message" : self.messageToSend]
        
        ref = self.db.collection("Chats").addDocument(data: myChatDictionary, completion: { (error) in
            
            if error != nil{
                
            }else{
                self.messageToSend = ""
            }
        })
        
    }
    
    func generateDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
    
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(userToChat: userModel(name: "Ahmet", uidFromFirebase: "aoılhfdkaj"))
    }
}
