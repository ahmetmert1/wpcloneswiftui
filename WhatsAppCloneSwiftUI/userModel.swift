//
//  userModel.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Ahmet Mert ÖZ on 17.06.2022.
//

import Foundation
import SwiftUI

struct userModel : Identifiable {
    var id = UUID()
    var name : String
    var uidFromFirebase : String
    
}


