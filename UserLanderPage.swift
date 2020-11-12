//
//  UserLanderPage.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 8/2/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import SwiftUI

struct UserLanderPage: View {
    var body: some View {
        ZStack(){
            ZStack(){
                BackgroundLanderImage(BackGroundImage: "8")
                BlurLanderBackground()
            }
            VStack(){
                Spacer().frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (0.07)), alignment: .top)
                LanderPageLogo()
                Spacer().frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (0.03)))
                WelcomeToToddLander()
                Spacer().frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (0.15)))
                UserToddLander()
                Spacer().frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (0.30)), alignment: .bottom)
            }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .center)
            
        }
    }
}

struct UserLanderPage_Previews: PreviewProvider {
    static var previews: some View {
        UserLanderPage()
    }
}


struct BackgroundLanderImage : View{
    var BackGroundImage : String = "Default"
    var body: some View{
        HStack(alignment : .top){
            Image(BackGroundImage)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 0.9)
                .frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .top)
        }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .top)

    }
}

struct BlurLanderBackground : View {
    var body: some View{
        HStack(){
            Color(.black)
                .opacity(0.05)
                .edgesIgnoringSafeArea(.all)
                .blendMode(.darken)
                .frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .center)
        }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .center)
    }
}


struct LanderPageLogo : View{
    var body: some View{
        HStack(){
            Image("ToddLogo")
                .resizable()
                .scaledToFit()
                .frame(height: CGFloat(Constant.share.Height * ( 1/12 )), alignment: .center)
        }.frame(width: Constant.share.Width, alignment: .center)
    }
}


struct WelcomeToToddLander : View{
    var body : some View{
        HStack(alignment : .center){
            VStack{
                Text("Welcome to").font(Font(StateSingleton.share.FontType(7, CGFloat(Constant.share.Height * (1/32)))))
                .foregroundColor(Color(.white))
                Text("TODDLIT").font(Font(StateSingleton.share.FontType(7, CGFloat(Constant.share.Height * (1/22)))))
                    .fontWeight(.bold)
                .foregroundColor(Color(.white))
            }
        }.frame(width: Constant.share.Width, alignment: .center)
    }
}


struct UserToddLander : View{
    var user : String = "Rosso Leo"
    var body : some View{
        HStack(alignment : .center){
            Text(user + ",")
                .font(Font(StateSingleton.share.FontType(7, CGFloat(Constant.share.Height * (1/25)))))
                .fontWeight(.bold)
                .foregroundColor(Color(.white))
        }.frame(width: Constant.share.Width, alignment: .center)
    }
}
