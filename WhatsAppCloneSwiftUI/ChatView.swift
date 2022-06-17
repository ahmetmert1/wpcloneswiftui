//
//  ChatView.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Ahmet Mert ÖZ on 17.06.2022.
//

import SwiftUI

struct ChatView: View {
    
    var userToChat : userModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(userToChat: userModel(name: "Ahmet", uidFromFirebase: "aoılhfdkaj"))
    }
}
