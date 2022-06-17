//
//  ContentView.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Ahmet Mert ÖZ on 14.06.2022.
//

import SwiftUI
import Firebase


struct AuthView: View {
    
    let ekranBoyut = UIScreen.main.bounds
    
    let db = Firestore.firestore()
    
    @ObservedObject var userStore = UserStore()
    
    @State var userMail = ""
    @State var userPassword = ""
    @State var userName = ""
    @State var showAuthView = true
    
    var body: some View {
       
        NavigationView{
            if showAuthView {
        VStack{
            Image("pngwing.com")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: ekranBoyut.width*0.6, height: ekranBoyut.width*0.6, alignment: .center)
            
            Text("WhatsApp Clone")
                .foregroundColor(.white)
                .font(.title3)
            Spacer()
            TextField("E-mail Adresini Giriniz", text: $userMail)
                .padding()
                .textFieldStyle(.roundedBorder)
                .font(.body)
            TextField("Şifrenizi Giriniz", text: $userPassword)
                .padding()
                .textFieldStyle(.roundedBorder)
                .font(.body)
            TextField("Kullanıcı Adı Giriniz", text: $userName)
                .padding()
                .textFieldStyle(.roundedBorder)
                .font(.body)
            
            Button {
                //Kayıt OL fonksiyonu
                Auth.auth().createUser(withEmail: self.userMail, password: self.userPassword) { result, error in
                    if error != nil{
                        print(error?.localizedDescription)
                    }else{
                        
                        //Kullanıcı Oluşturuldu.
                        //Database
                        
                        var ref: DocumentReference? = nil
                        let myUserDictionary : [String : Any] = ["username" : self.userName, "usermail":self.userMail,"useruidfromfirebase":result?.user.uid ]
                        ref = self.db.collection("Users").addDocument(data: myUserDictionary, completion: { (error) in
                            if error != nil {
                            }
                        })
                        //UserView
                        self.showAuthView = false
                    }
                }
            } label: {
                Text("Kayıt Ol !")
                    .foregroundColor(.white)
            }
            .padding()
            
            Button {
                //Giriş yap fonksiyonu
                Auth.auth().signIn(withEmail: self.userMail, password: self.userPassword) { result, error in
                    if error != nil{
                        print(error?.localizedDescription)
                    }else{
                        self.showAuthView = false
                    }
                }
            } label: {
                Text("Giriş Yap !")
                    .foregroundColor(.white)
            }
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
        .accentColor(Color.black)
        .background(Color.green)
            }//if sonu
            else{//User View
                NavigationView{
                    
                    List(userStore.userArray){ user in
                        
                        NavigationLink(destination: ChatView(userToChat: user)) {
                            Text(user.name)
                        }
                }
                    
   
                }
                .navigationTitle("Chat With Users!")
                .navigationBarItems(trailing: Button(action: {
                    //Log out
                    
                    do {
                        try Auth.auth().signOut()
                    }catch{
                        
                    }
                    self.showAuthView = true
                    
                }, label: {
                    Text("Log Out")
                        .foregroundColor(.red)
                }))

            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(showAuthView: false)
    }
}
}
