//
//  Downloads.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 10/9/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import SwiftUI

struct Downloads: View {
    var body: some View {
        ZStack(alignment: .topLeading){
            ScrollView(.vertical, showsIndicators: false) {
                    ZStack{
//                        userWebQuestionaire(url: "https://toddlit.com").frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .center)

                        VStack(spacing : StateSingleton.share.DiscoveryPadding){
                            DownloadsLogoAndUser()
                            DownloadedContentView()
                        }.frame(width: Constant.share.Width, alignment: .top)//Vstack brackets
                        VStack(){
                            Spacer()
                        }//.frame(width: Constant.share.Width , height: Constant.share.Height, alignment: .top)
                    }//ZStack
                }.background(Color.black)  // end of scroll view brackets
        }.background(Color.black).edgesIgnoringSafeArea(.top) // end of VStack Brackets
    }
}

struct Downloads_Previews: PreviewProvider {
    static var previews: some View {
        Downloads()
    }
}




struct DownloadsLogoAndUser : View {
    var width = CGFloat(Constant.share.Width)// complete width of recommended story image
    var height = CGFloat(Constant.share.Height * (0.6))//60% of the screens... hight of recommended story image
    var TopContentHeight = CGFloat(Constant.share.Height * (1 / 14))
    var UserImageHeightAndWidth = CGFloat(Constant.share.Height * (10/300))
    var padding = CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (0.5))
    var ToddLogoText = "Downloads"
    
    var body : some View{
                HStack(alignment : .bottom){
                    ToddHomeLogo(FontColor: StateSingleton.share.white, ToddLogoText: self.ToddLogoText)
                    Spacer()
                    UserImageAndName(FontColor : StateSingleton.share.FiftyPercentWhite).padding([.trailing], StateSingleton.share.PaddingFromTheLeadingEdge)
                    
                }.frame(width: Constant.share.Width, height: self.TopContentHeight, alignment: .bottom).padding([.bottom], StateSingleton.share.PaddingFromTheLeadingEdge)//Hstack
                

    }//body viuew
}// LogoUserTab brackets



struct DownloadedContentView : View {
    var downloadedContent = [""]
    var body : some View{
        if(self.downloadedContent.count > 1){// will need to fix this if statement and base it on the amount of downloaded content... this data hasn't been established...
            
        }else{
            noDownloadsView()
        }
    }
}




struct noDownloadsView : View{
    var fontSize = CGFloat( Constant.share.Height * (1/70) )
    var widthAndHeight = CGFloat(Constant.share.Width * (0.375))
    var body : some View{
        VStack(){
            Spacer()
            
            //Icons made by <a href="https://www.flaticon.com/authors/catalin-fertu" title="Catalin Fertu">Catalin Fertu</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
            Image("whiteNoDownloads")
                .resizable()
                .frame(width: self.widthAndHeight, height: self.widthAndHeight, alignment: .center)
                .scaledToFit()
                .opacity(0.5)
            Text("No Current Downloads")
                .font( Font(StateSingleton.share.FontType(8, self.fontSize)) )
                .foregroundColor( Color(StateSingleton.share.white) )
//            userWebQuestionaire(url: "https://google.com")
            Spacer()
//            Spacer()
        }
    }
}
