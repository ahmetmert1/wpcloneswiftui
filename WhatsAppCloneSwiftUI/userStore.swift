//
//  userStore.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Ahmet Mert ÖZ on 17.06.2022.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore


//Gelen kullanıcıların verileri saklanacak
//Değişiklik olursa hemen gidip ilgili objeye haber verilecek

class UserStore : ObservableObject {
    
    //Observable object sayesinde diğer tarafta bir obje oluşturacağız.
    //Oluşturduğumuz obje tüm değişiklikleri alacak ve bize haber verecek
    
    let db = Firestore.firestore()
    
    var userArray : [userModel] = []
    
    var objectWillChange = PassthroughSubject<Array<Any> ,Never>()
    
    
    init(){
        //Sınıf içerisindeki tüm değişiklikleri dinler ve bildirir.
        db.collection("Users").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                
                self.userArray.removeAll(keepingCapacity: false)
                
                for document in snapshot!.documents{
                    if let userUidFromFirebase = document.get("useruidfromfirebase") as? String{
                        if let userName = document.get("username") as? String{
                            
                            let createdUser = userModel.init(id: UUID(), name: userName, uidFromFirebase: userUidFromFirebase)
                            
                            self.userArray.append(createdUser)
                        }
                    }
                }
                
                self.objectWillChange.send(self.userArray)
                
            }
        }
        
    }
    
    
    
}
