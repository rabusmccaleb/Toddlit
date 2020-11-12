//
//  LoginView.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 3/5/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import SwiftUI
import Combine

struct Login: View {
    var body: some View {

        ZStack(alignment: .center){
            BackgroundLogin(backgroundImage: "13")
            VStack(alignment: .center, spacing: 0){
                Spacer()
                LogoImage()
                //            Spacer().frame(height: CGFloat(Constant.share.Height * (1/28)), alignment: .center)
                Spacer()
                SignUP()
                Spacer().frame(height: CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (2)), alignment: .center)
                LogIn()
            }
            
        }.background(Color.white)//.cornerRadius(CGFloat(Constant.share.Height * ( 1 / 30 )))
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}



struct LogoImage : View {
    var widthAndHeight = CGFloat(UIScreen.main.bounds.height / (8))
    var body : some View {
        VStack{
        Spacer()
        Image("ToddLogo")
            .resizable()
            .scaledToFit()
            .frame(height: widthAndHeight, alignment: .center)
        Image("ToddlitFontBold")
            .resizable()
            .scaledToFit()
            .frame( width: CGFloat(self.widthAndHeight)  , height: CGFloat(self.widthAndHeight * ( 1 / 5 ) ), alignment: .center)
            
            Spacer().frame(height: CGFloat(Constant.share.Height * ( 1 / 30 ) ))
        //Text("TODDLIT").font(Font(StateSingleton.share.FontType(2, CGFloat(25.0)))).padding(.all, 0.0)
        }// VStack
    }//body
}


struct LoginMissionStatement : View{
    var body: some View{
        VStack(){
            Text("Sign Up or Sign In")
                .foregroundColor(Color(#colorLiteral(red: 0.5136993838, green: 0.5136993838, blue: 0.5136993838, alpha: 1)))
                .font(Font(StateSingleton.share.FontType(7, CGFloat(Constant.share.Height * (1 / 38) ) ) ))
//
//            Text("Big Concepts through Innovative Storytelling.")
//                .foregroundColor(Color.black)
//                .font(Font(StateSingleton.share.FontType(5, CGFloat(Constant.share.Height * (1 / 40) ) ) ))
            }
        }
}

struct SignUP : View{
    @State private var presentSignUp = false
    var Width = CGFloat(UIScreen.main.bounds.width - ( StateSingleton.share.PaddingFromTheLeadingEdge  * 2))
    var Height = CGFloat(UIScreen.main.bounds.height * (150 / 620))
    var body: some View{
        Button(action:{
         //Should Navigate them to the sign up page with the sheet
            self.presentSignUp.toggle()
        }){
            ZStack(alignment : .center){
                SquareTab()
                    .fill(Color(StateSingleton.share.ToddBlue))
                    .frame(width: self.Width, height: self.Height, alignment: .topLeading)
                    .cornerRadius( CGFloat(Constant.share.Width * (1 / 30) ))
                    .shadow(color: Color(StateSingleton.share.ToddBlueShadow), radius: CGFloat(self.Height * (1/60)), y: CGFloat(self.Height * (1/16)))
                Text("Sign Up").font(Font(StateSingleton.share.FontType(5, CGFloat(20.0)))).foregroundColor(Color.white).fontWeight(.bold)
                }//Zstack
        }.sheet(isPresented: self.$presentSignUp){
        
         SignUpView()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
         }.buttonStyle(PlainButtonStyle())//button discrptor
    }// body
}// struct


struct LogIn : View{
//    var Width = CGFloat(UIScreen.main.bounds.width * (170 / 300))
//    var Height = CGFloat(UIScreen.main.bounds.height * (40 / 620))
    var Width = CGFloat(UIScreen.main.bounds.width)
    var Height = CGFloat(UIScreen.main.bounds.height * (62 / 620))
    var body: some View{
        Button(action:{
         //should navigate them to the sign in page with the sheet
        }){
            ZStack(alignment : .center){
                SquareTab()
                    .fill(Color.white)
                    .frame(width: self.Width, height: self.Height, alignment: .topLeading)
//                    .shadow(color: Color(StateSingleton.share.TwentieFivePercentBlack), radius: CGFloat(self.Height * (1/28)), y: CGFloat(self.Height * (1/18)))
//                    .shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(self.Height * (1/14)), y: CGFloat(self.Height * (1/14)))
                Text("Sign In")
                    .font(Font(StateSingleton.share.FontType(5, CGFloat(18.0))))
                    .foregroundColor(Color(#colorLiteral(red: 0.3241637324, green: 0.3241637324, blue: 0.3241637324, alpha: 1))).fontWeight(.bold)
                }//Zstack
        }.buttonStyle(PlainButtonStyle())//button discrptor
    }// body
}// structLo


struct BackgroundLogin : View{
    var backgroundImage = "Default"
    var body: some View{
        ZStack(){
            HStack(){
                Image(backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .center)
            }
            
            HStack(){
                Color(.white)
                    .opacity(1)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .center)
//                    .background(Color(StateSingleton.share.ToddMainUIColor))
            }
        }
    }
}


