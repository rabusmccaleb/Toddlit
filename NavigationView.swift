//
//  NavigationView.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 2/23/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//
import Foundation
import Combine
import SwiftUI
import FirebaseAuth
import FirebaseFirestore


class isSigned : ObservableObject{
    @Published var isSignedIn = Auth.auth().currentUser
    @Published var isSignInBool = false
    init() {
//        printAuth()
        
        StateChecker()
    }
    func signoutAuth(){
    let firebaseAuth = Auth.auth()
        
        do {
          try firebaseAuth.signOut()
            
            if Auth.auth().currentUser == nil {
                self.isSignInBool = false
            }
            
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    
    func StateChecker(){
        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          // ...
            if auth.currentUser != nil {
                self.isSignInBool = true
                StateSingleton.share.userId = user!.uid
                print(user!.uid)
            }
        }
        
        handle
    }
}



struct NavigationView : View{
    var TabItemHeightWidth = CGFloat(Constant.share.Height * (1 / 300) )
    @ObservedObject var SignInStatus = isSigned()
    @State var isSignIn : Bool = false
    init() {
        setupTabBar()
    }
    var body: some View{
///             Basic way we will implement checking if the user is logged in...
        if SignInStatus.isSignInBool == true {
                TabView{
                    Home().tabItem{
                        Text("Home").foregroundColor(.white)
                    }.tag(1)
                    Discovery().tabItem{
                        Text("Discovery").foregroundColor(.white)
                    }.tag(2)
                    Search().tabItem{
                        Text("Search").foregroundColor(.white)
                    }.tag(3)
//                    Downloads().tabItem{
//                        Text("Downloads").foregroundColor(.white)
//                    }.tag(4)
                    UserSettings().tabItem{
                        Text("User").foregroundColor(.white)
                    }.tag(4)
                }
        } else {
                SignUpView()
        }
    }
}


extension NavigationView {
  func setupTabBar() {
    UITabBar.appearance().barTintColor = .black
    if #available(iOS 14.0, *) {
        UITabBar.appearance().tintColor = UIColor(Color.white)
    } else {
        // Fallback on earlier versions
        UITabBar.appearance().tintColor = .blue
    }
    UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
    UITabBar.appearance().clipsToBounds = true
  }
}





struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
//        OldNavigationView(ViewNumber: ObserverView())
       // NavigationView(ChangingObject: ObserverView())
        
    }
}


struct ChaingingObject : Identifiable {
    var id: Int
    var ViewNumber : Int
    
    init(id : Int, ViewNumber : Int){
        self.id = id
        self.ViewNumber = ViewNumber
        
    }
}


////Tab Control
struct ViewForBottomTabControl: View {
    var body: some View {
        ZStack {
            Image("108")
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 60, alignment: .bottom)
                .cornerRadius(100)
            
            HStack(spacing : 10){
                Button(action : {
                    StateSingleton.share.NavigationNumber = 0
                        }){
                        Image("108")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50, alignment: .bottom)
                            .cornerRadius(100)
                
                }
                
                Button(action : {
                    StateSingleton.share.NavigationNumber = 1
                        }){
                        Image("108")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50, alignment: .bottom)
                            .cornerRadius(100)
                }
  
                Button(action : {
                        StateSingleton.share.NavigationNumber = 2
                }){
                        Image("108")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50, alignment: .bottom)
                            .cornerRadius(100)
                
                }
                
                
                
                Button(action : {
                        StateSingleton.share.NavigationNumber = 3
                }){
                        Image("108")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50, alignment: .bottom)
                            .cornerRadius(100)
                
                }
            }//HstackStruct
        }//.offset(y: CGFloat(400))
    }
}
//ObserverView
class ObserverView: ObservableObject{
    let Change = PassthroughSubject<ObserverView ,Never>()
    var ViewNumber : Int = 0 {
        didSet {
            Change.send(self)
        }
    }
    // we default this value to zero such that the  view actually loads the value when it reaches a change
}
