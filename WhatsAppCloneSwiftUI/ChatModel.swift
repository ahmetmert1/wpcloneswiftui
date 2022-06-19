//
//  ChatModel.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Ahmet Mert ÖZ on 18.06.2022.
//

import SwiftUI

struct ChatModel : Identifiable {
    
    var id : Int
    var message : String
    var uidFromFirebase : String
    var messageFrom : String
    var messageTo : String
    var messageDate : Date
    var messageFromMe : Bool
}
