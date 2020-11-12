//
//  OldViews.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 9/29/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import SwiftUI

struct OldViews: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct OldViews_Previews: PreviewProvider {
    static var previews: some View {
        OldViews()
    }
}




//struct OldNavigationView : View {
//    @ObservedObject var ViewNumber =  ObserverView()
//    @State var ObjectChange = ChaingingObject(id: 0, ViewNumber: 0)
//    @ObservedObject var SignInStatus = isSigned()
//    var TabDistanceFromBottom = CGFloat(16)
//    var TabButtonDimensions = CGFloat((30 / 600) * (Constant.share.Height))
//    var body : some View {
//
//        //VStack{
//            ZStack(alignment: .bottom){
//
//
////
//////                Basic way we will implement checking if the user is logged in...
//                if SignInStatus.isSignedIn != nil {
//                    if self.ObjectChange.ViewNumber == 0 {
//                         Home()//UserLanderPage()//Home()
//                    }else if self.ObjectChange.ViewNumber == 1{
//                        Discovery()//SignUpView()
//                    }else if self.ObjectChange.ViewNumber == 2{
//                       Search()
//                    }else if self.ObjectChange.ViewNumber == 3{
//                        UserSettings()
//                    }else{
//                        Text("Error_Presenting_Tab_Views")
//                    }
//                } else {
//                   //User Not logged in
////                    if self.ObjectChange.ViewNumber == 0 {
//                    Login()
////                    }
//                }
//
//
//
//
//                if self.ObjectChange.ViewNumber == 0 {
//                     Home()//UserLanderPage()//Home()
//                }else if self.ObjectChange.ViewNumber == 1{
//                    Discovery()//SignUpView()
//                }else if self.ObjectChange.ViewNumber == 2{
//                   Login()// SignUpView()//ArtistaView() //SignUpView() // Login()//Search()
//                }else if self.ObjectChange.ViewNumber == 3{
//                    UserSettings()
//                }else{
//                    Text("Error_Presenting_Tab_Views")
//                }
//                VStack{
//                    Spacer()
//                    ZStack{
//                        SquareTab()
//                            .fill(Color.black)
//                            .frame(width: CGFloat(Constant.share.Width), height: CGFloat((50 / 600) * (Constant.share.Height)) , alignment: .bottom)
////                            .cornerRadius(100)
////                            .shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: 4.0, x: 0, y: 2.0)
//
//                          HStack(spacing : 10){
//                            Spacer()
//
//                              Button(action : {
//                                self.ObjectChange.ViewNumber = 0
//                                ChaingingObject(id: 0, ViewNumber: 0)
//                                print( self.ViewNumber)
//                                      }){
//                                      Image("108")
//                                        .renderingMode(.original)
//                                          .resizable()
//                                          .scaledToFill()
//                                        .frame(width: self.TabButtonDimensions, height: self.TabButtonDimensions, alignment: .bottom)
//                                          .cornerRadius(100)
//
//
//                              }
//                            Spacer()
//                              Button(action : {
//
//                                          self.ObjectChange.ViewNumber = 1
//                                    ChaingingObject(id: 0, ViewNumber: 1)
//                                           print( self.ViewNumber)
//                                      }){
//                                      Image("108")
//                                        .renderingMode(.original)
//                                          .resizable()
//                                          .scaledToFill()
//                                        .frame(width: self.TabButtonDimensions, height: self.TabButtonDimensions, alignment: .bottom)
//                                          .cornerRadius(100)
//                              }
//                            Spacer()
//                              Button(action : {
//                                         self.ObjectChange.ViewNumber = 2
//                                    ChaingingObject(id: 0, ViewNumber: 2)
//                                           print( self.ViewNumber)
//                              }){
//                                      Image("108")
//                                        .renderingMode(.original)
//                                          .resizable()
//                                          .scaledToFill()
//                                        .frame(width: self.TabButtonDimensions, height: self.TabButtonDimensions, alignment: .bottom)
//                                          .cornerRadius(100)
//                              }
//                            Spacer()
//                              Button(action : {
//                                          self.ObjectChange.ViewNumber = 3
//                                    ChaingingObject(id: 0, ViewNumber: 3)
//                                         print( self.ViewNumber)
//
//                              }){
//                                      Image("108")
//                                        .renderingMode(.original)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: self.TabButtonDimensions, height: self.TabButtonDimensions, alignment: .bottom)
//                                        .cornerRadius(100)
//
//                              }
//                            Spacer()
//                          }//HstackStruct
//                      }//ZStack   //.offset(y: TabDistanceFromBottom)
//
////                    Spacer().frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (1/25)), alignment: .bottom)
//                }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .bottom)//VStack
//           // } we will call this the v stack bracket
//        }/// ZSTACK OVER THE THE VIEWS WE NAVIGATE THROUGH
//    }/// BODY
//}/// STRUCT
