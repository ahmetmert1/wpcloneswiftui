//
//  ChatStore.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Ahmet Mert ÖZ on 18.06.2022.
//

import Foundation
import SwiftUI
import Firebase
import Combine


class ChatStore : ObservableObject {
    
    
    let db = Firestore.firestore()
    
    var chatArray : [ChatModel] = []

    var objectWillChange = PassthroughSubject<Array<Any> , Never>()
    
    init(){
        
        
        db.collection("Chats").whereField("chatUserFrom", isEqualTo: Auth.auth().currentUser?.uid)
            .addSnapshotListener { snapshot, error in
                if error != nil {
                    print(error?.localizedDescription)
                }else{
                    
                    self.chatArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        let chatUidFromFireBase = document.documentID
                        if let chatMessage = document.get("message") as? String{
                            if let messageFrom = document.get("chatUserFrom") as? String {
                                if let messageTo = document.get("chatUserTo") as? String {
                                    if let dateString = document.get("date") as? String {
                                        
                                        
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                        let dateFromFB = dateFormatter.date(from: dateString)
                                        
                                        let currentIndex = self.chatArray.last?.id
                                        
                                        let createdChat = ChatModel(id: (currentIndex ?? -1) + 1, message: chatMessage, uidFromFirebase: chatUidFromFireBase, messageFrom: messageFrom, messageTo: messageTo, messageDate: (dateFromFB)!, messageFromMe: true)
                                        
                                        self.chatArray.append(createdChat)
                                    }
                                }
                            }
                        }
                    }
                    
                    self.db.collection("Chats").whereField("chatUserTo", isEqualTo: Auth.auth().currentUser?.uid)
                        .addSnapshotListener { snapshot, error in
                            if error != nil {
                                print(error?.localizedDescription)
                            }else{
                                for document in snapshot!.documents{
                                    let chatUidFromFireBase = document.documentID
                                    if let chatMessage = document.get("message") as? String{
                                        if let messageFrom = document.get("chatUserFrom") as? String {
                                            if let messageTo = document.get("chatUserTo") as? String {
                                                if let dateString = document.get("date") as? String {
                                                    
                                                    
                                                    let dateFormatter = DateFormatter()
                                                    dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                                    let dateFromFB = dateFormatter.date(from: dateString)
                                                    
                                                    let currentIndex = self.chatArray.last?.id
                                                    
                                                    let createdChat = ChatModel(id: (currentIndex ?? -1) + 1, message: chatMessage, uidFromFirebase: chatUidFromFireBase, messageFrom: messageFrom, messageTo: messageTo, messageDate: (dateFromFB)!, messageFromMe: true)
                                                    
                                                    self.chatArray.append(createdChat)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                self.objectWillChange.send(self.chatArray)
                                
                            }
                        }
                    
                }
            }
    }
    
}
