//
//  SignUpView.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 3/12/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var body: some View {
        ZStack{
            BackGroundSignUpImageView().scaledToFill().edgesIgnoringSafeArea(.all)
            UITabView()
        }.frame(width: self.width, height: self.height, alignment: .bottom)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct BackGroundSignUpImageView : View {
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var body : some View {
        HStack(alignment: .top){
            Color
                .white
            //.resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(width: self.width, height: self.height, alignment: .top)
                //.clipped()
                .opacity(1.0)
        }.frame(width: self.width, height: self.height, alignment: .top)// end of HStackBrackets
    }
}

struct UITabView : View {
    var height = CGFloat(UIScreen.main.bounds.height * (6/6))
    var width = CGFloat(UIScreen.main.bounds.width)

    var body : some View{
        ScrollView(.vertical , showsIndicators : false){
        VStack{
            ZStack{
                Color.black.opacity(1).scaledToFill().edgesIgnoringSafeArea(.all)
                Image("6-1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.8)
                Color.white.opacity(1)
                    VStack{
                            SignUpObjects()
                        }// VStack
            }.frame(width: Constant.share.Width, alignment: .center)//ZStack
        }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .center)//VStack in scrollview
        }//Scollview in the event the screen is to small for all the content to fit properly
    }//Body
}//Struct


struct SquareOrRectangle : Shape{
    func path(in rect: CGRect)-> Path{
        Path{ path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }// end of path brackets
    }// end of function brackets
}

struct SignUpObjects : View{
    var BackGroundImageReffernce = "6"
    var body : some View {
        VStack(alignment: .center){
//            Spacer().frame(height: CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * 0.5) , alignment: .center)
//            LogoImage()
//            Spacer()
            Text("Sign Up")
                .font(Font(StateSingleton.share.FontType(7, CGFloat(35.0))))
                .foregroundColor(Color(StateSingleton.share.ToddBlue))
                .padding([.top] , CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * 0.5))
            
            UserName(ImageRefference : self.BackGroundImageReffernce)
            Email(ImageRefference : self.BackGroundImageReffernce)
            Password(ImageRefference : self.BackGroundImageReffernce)
            PasswordConfrimation(ImageRefference : self.BackGroundImageReffernce)
            
            BottomUIButton()
        }.frame(width: Constant.share.Width, alignment: .leading)//VStack
    }//body
}//struct

struct UserName : View {
    var MaxWidth = CGFloat(UIScreen.main.bounds.width - (StateSingleton.share.PaddingFromTheLeadingEdge * 2))
    var MaxHeight = CGFloat(UIScreen.main.bounds.height * (40 / 600))
    var ImageRefference = "4"
    @State var UserName = ""
    var body : some View{
        ZStack(alignment : .leading){
//            Image(self.ImageRefference)
//            .resizable()
//            .scaledToFill()
//            .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .leading)
//            .clipped()
            RoundedRectangle(cornerRadius: 10).fill(Color(StateSingleton.share.TwentieFivePercentWhite))
                .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .leading)                .overlay(RoundedRectangle(cornerRadius: 10 ).stroke(Color(StateSingleton.share.TwentieFivePercentBlack), lineWidth: 1.5))
                

            
            
            VStack(alignment: .leading){
                ZStack(alignment: .leading){
                    Text("Username:")
                        .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                        .font(Font(StateSingleton.share.FontType(7, CGFloat(12.0))))
                        .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .topLeading)
                        .padding([.top], 5.0)
                    TextField("Username", text: self.$UserName , onEditingChanged: {(Bool) in
                        BackendSingleton.share.UserName = self.UserName
                        print(" UserName : \(BackendSingleton.share.UserName)")
                    } , onCommit: {
                        BackendSingleton.share.UserName = self.UserName
                    }).foregroundColor(Color.black).font(Font(StateSingleton.share.FontType(7, 14.0))).frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .leading).padding([.top ], 15.0)
                //TextField("Enter a username")// has to be implimented last.. because at the moment I'm not certain how to do it
                // TextField(<#T##title: StringProtocol##StringProtocol#>, text: <#T##Binding<String>#>, onEditingChanged: <#T##(Bool) -> Void#>, onCommit: <#T##() -> Void#>)
                }// vStack
            }.padding([.leading], CGFloat( StateSingleton.share.PaddingFromTheLeadingEdge / 2 ))// VStack
        }.cornerRadius(10)//zStack
    }//Body
}//Struct

struct Email : View {
    var MaxWidth = CGFloat(UIScreen.main.bounds.width - (StateSingleton.share.PaddingFromTheLeadingEdge * 2))
    var MaxHeight = CGFloat(UIScreen.main.bounds.height * (40 / 600))
    var ImageRefference = "4"
    @State private var Email : String = ""
    var body : some View{
        ZStack(alignment: .leading){
//            Image(self.ImageRefference)
//            .resizable()
//            .scaledToFill()
//            .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .leading)
//            .clipped()
            RoundedRectangle(cornerRadius: 10).fill(Color(StateSingleton.share.TwentieFivePercentWhite))
                .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .leading)                .overlay(RoundedRectangle(cornerRadius: 10 ).stroke(Color(StateSingleton.share.TwentieFivePercentBlack), lineWidth: 1.5))
            
            VStack(alignment: .leading){
                ZStack(alignment: .leading){
                    Text("Email:")
                        .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                        .font(Font(StateSingleton.share.FontType(7, CGFloat(12.0))))
                        .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .topLeading)
                        .padding([.top], 5.0)
                    TextField("Email", text: self.$Email ,onEditingChanged: {(Bool) in
                        BackendSingleton.share.Email = self.Email
//                        var Astrid = ""
//                        var SecureText = {
//                            for x in 1...self.Email.count{
//                                Astrid = Astrid + "*"
//                            }
//                        }
//                        self.Email = Astrid
                        print("Email : \(BackendSingleton.share.Email)")
                        
                    }, onCommit: { BackendSingleton.share.Email = self.Email })
                        .foregroundColor(Color.black)
                        .font(Font(StateSingleton.share.FontType(7, 14.0)))
                        .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .leading)
                        .padding([.top ], 15.0)
                //TextField("Enter a username")// has to be implimented last.. because at the moment I'm not certain how to do it
                
                }//ZStack
            }.padding([.leading], CGFloat( StateSingleton.share.PaddingFromTheLeadingEdge / 2 ))// vStack
        }.cornerRadius(10)//zStack
    }//Body
}//Struct

struct Password : View {
    var MaxWidth = CGFloat(UIScreen.main.bounds.width - (StateSingleton.share.PaddingFromTheLeadingEdge * 2))
    var MaxHeight = CGFloat(UIScreen.main.bounds.height * (40 / 600))
    var ImageRefference = "4"
    @State var Password = ""
    var body : some View{
        ZStack(alignment: .leading){
//            Image(self.ImageRefference)
//            .resizable()
//            .scaledToFill()
//            .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .leading)
//            .clipped()
            RoundedRectangle(cornerRadius: 10).fill(Color(StateSingleton.share.TwentieFivePercentWhite))
                .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .leading)                .overlay(RoundedRectangle(cornerRadius: 10 ).stroke(Color(StateSingleton.share.TwentieFivePercentBlack), lineWidth: 1.5))
            
            VStack(alignment: .leading){
                ZStack(alignment: .leading){
                    Text("Password:")
                    .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                        .font(Font(StateSingleton.share.FontType(7, CGFloat(12.0))))
                        .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .topLeading)
                        .padding([.top], 5.0)
                    
                    
                    TextField("Password", text: self.$Password, onEditingChanged: {_ in
                        BackendSingleton.share.PasswordInitial = self.Password
                        print(BackendSingleton.share.PasswordInitial)
                        print(self.Password)
                        
                    }).foregroundColor(Color.black).font(Font(StateSingleton.share.FontType(7, 14.0)))
                        .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .leading)
                        .padding([.top], 15.0)
                    
                }//ZStack
            }.padding([.leading], CGFloat( StateSingleton.share.PaddingFromTheLeadingEdge / 2 ))// VStack
        }.cornerRadius(10)//zStack
    }//Body
}//Struct

struct PasswordConfrimation : View {
    var MaxWidth = CGFloat(UIScreen.main.bounds.width - (StateSingleton.share.PaddingFromTheLeadingEdge * 2))
    var MaxHeight = CGFloat(UIScreen.main.bounds.height * (40 / 600))
    var ImageRefference = "4"
    @State var PasswordConfirm = ""
    @State var NavigateToSignInView = false
    var body : some View{
        ZStack(alignment : .leading){
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(StateSingleton.share.TwentieFivePercentWhite))
                .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .leading)                .overlay(RoundedRectangle(cornerRadius: 10 ).stroke(Color(StateSingleton.share.TwentieFivePercentBlack), lineWidth: 1.5))
            
            VStack(alignment: .leading){
                ZStack(alignment: .leading){
                    Text("Confirm Password:")
                    .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                        .font(Font(StateSingleton.share.FontType(7, CGFloat(12.0))))
                        .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .topLeading)
                        .padding([.top], 5.0)
                    
                    TextField("Confirm Password", text: self.$PasswordConfirm, onEditingChanged: {_ in
                        BackendSingleton.share.PasswordInitial = self.PasswordConfirm
                        print(BackendSingleton.share.PasswordInitial)
                        print(self.PasswordConfirm)
                    }).foregroundColor(Color.black).font(Font(StateSingleton.share.FontType(7, 14.0)))
                        .frame(width: self.MaxWidth, height: self.MaxHeight, alignment: .leading)
                        .padding([.top], 15.0)
                }
            }.padding([.leading], CGFloat( StateSingleton.share.PaddingFromTheLeadingEdge / 2 ))// VStack
        }.cornerRadius(10)//zStack
    }//Body
}//Struct

struct BottomUIButton : View {
    var width = CGFloat(UIScreen.main.bounds.width * (65 / 300))
    var Email = BackendSingleton.share.Email
    var UserName = BackendSingleton.share.UserName
    @State var NavigateToSignInView = false

    var body : some View{
        VStack(){
            HStack(alignment: .center){
                Spacer().frame(width : CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * 0.5))
                    Text("""
                            Let's fill the
                            little minds of
                            the future with
                            Big ideas,
                        """).foregroundColor(.black).font(Font(StateSingleton.share.FontType(7, 18.0)))
                        .multilineTextAlignment(.leading).offset(x: CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * -0.5))
                        
                Spacer()
                Button(action: {
//                    BackendSingleton.share.Password = BackendSingleton.share.PasswordComparisonCheck(InitialPassword: BackendSingleton.share.PasswordInitial, ConfirmPassword: BackendSingleton.share.PasswordConfimation)
                    BackendSingleton.share.signUp()
                }){
                ZStack(alignment: .center){
                    SquareOrRectangle()
                        .fill(Color(StateSingleton.share.ToddBlue))
                        .frame(width: self.width, height: self.width, alignment: .center)
                        .cornerRadius(CGFloat(Constant.share.Width * (1/25)))
                        .shadow(color: Color(StateSingleton.share.ToddBlueShadow), radius: CGFloat(Constant.share.Width * (1/60)), x: 0, y: CGFloat(Constant.share.Width * (1/60)))
                    
                    
                    Text("Okay")
                        .font(Font(StateSingleton.share.FontType(2, CGFloat(20)))).foregroundColor(Color.white)
                    }.frame(width: self.width, height: self.width, alignment: .center)//ZStack
                }.frame(width: self.width, height: self.width, alignment: .center)// Button Brackets
                Spacer().frame(width : StateSingleton.share.PaddingFromTheLeadingEdge)
            }.frame(width : Constant.share.Width, alignment: .center)//HStack
            
            Image("ThroughStory")
                .resizable()
                .scaledToFit()
                .frame(height: (Constant.share.Height / 14))
                .padding([.bottom], 15)
            
            
            Divider()
            
            Text("Sign In")
                .foregroundColor(Color(StateSingleton.share.SeventyFivePercentBlack))
                .font(Font(StateSingleton.share.FontType(7, CGFloat(14.0))))
                .frame(height: CGFloat(Constant.share.Height / 25), alignment: .center)
                .padding(2.5)
                .onTapGesture {
                    self.NavigateToSignInView.toggle()
                }.sheet(isPresented: self.$NavigateToSignInView ){ 
                    SignInView()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                 }
        }//VStack
    }//body
}//Struct

