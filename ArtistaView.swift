//
//  ArtistaView.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 4/25/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import SwiftUI

struct ArtistaView: View {
    var body: some View {
        ZStack{
        ArtistaBackGroundImageView()
            VStack{
                Spacer()
                Color.white.frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (0.4)), alignment: .bottom).edgesIgnoringSafeArea(.bottom)
            }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .bottom)
        ScrollView{
            VStack{
                Spacer().frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (0.3)), alignment: .top)
                WhiteTabContent()
                    }// vstack
            }// scroll view
        }// zstack
    }// body
}//struct

struct ArtistaView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistaView()
    }
}

struct ArtistaViewData : Identifiable{
    var id = UUID()
    var ArtistaName : String// actuall name placed here
    var ArtistaImageRefference : String// refference to be pulled from backend
    var ArtistaStories : [TopViewStructure]// refference
    var ArtistaSummary : String// actuall data
    var FaceBookUI : String// Reference string... which is to actualy be a string
    var InstagramUI : String// reffernce... which is to actually be a string
    var TumblrUI : String// refference... which is to actually be a string
    var DeviantArtUI : String // refference... which is to actually be a string
    init(ArtistaNameData : String , ArtistaImmagineData : String , ArtistaStoriesData : [TopViewStructure] , ArtistaSummaryData : String , Facebook : String , Instagram : String , Tumblr : String , DeviantArt : String) {
        self.ArtistaName = ArtistaNameData
        self.ArtistaImageRefference = ArtistaImmagineData
        self.ArtistaStories = ArtistaStoriesData
        self.ArtistaSummary = ArtistaSummaryData
        self.FaceBookUI = Facebook
        self.InstagramUI = Instagram
        self.TumblrUI = Tumblr
        self.DeviantArtUI = DeviantArt
    }
}
struct ArtistaBackGroundImageView: View{
    var Data = ArtistaViewData(ArtistaNameData: Constant.share.ArtistaName , ArtistaImmagineData: Constant.share.ArtistaImmagineData, ArtistaStoriesData: Constant.share.ArtistContentList, ArtistaSummaryData: Constant.share.ArtistaSummaryData, Facebook: Constant.share.FaceBookRef, Instagram: Constant.share.InstagramRef, Tumblr: Constant.share.TumblrRef , DeviantArt: Constant.share.TumblrRef)
    var ArtistaImage = "12"
    var body: some View{
        
        VStack{
            ZStack{
            Image(self.Data.ArtistaImageRefference)
            .resizable()
            .scaledToFill()
                .frame(width: CGFloat(Constant.share.Width + StateSingleton.share.PaddingFromTheLeadingEdge) , height: CGFloat(Constant.share.Height * 0.5), alignment: .top)
            .edgesIgnoringSafeArea(.top)
                
//            Color.gray
//            .blendMode(.saturation)
            }.frame(width: CGFloat(Constant.share.Width + StateSingleton.share.PaddingFromTheLeadingEdge) , height: CGFloat(Constant.share.Height * 0.5), alignment: .top)
           Spacer()
        }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .center)// VStack
    }// body
}//struct

struct WhiteTabContent: View {
 
    var FaceBookUI = "2"
    var InstagramUI = "1"
    var TumblrUI = "3"
    var DeviantArtUI = "5"
    var ExternalSourceButtonSize = CGFloat(Constant.share.Width * (18 / 300))
    var Data = ArtistaViewData(ArtistaNameData: Constant.share.ArtistaName, ArtistaImmagineData: Constant.share.ArtistaImmagineData, ArtistaStoriesData: Constant.share.ArtistContentList, ArtistaSummaryData: Constant.share.ArtistaSummaryData, Facebook: Constant.share.FaceBookRef, Instagram: Constant.share.InstagramRef, Tumblr: Constant.share.TumblrRef , DeviantArt: Constant.share.TumblrRef)
    
    var body: some View {
            ZStack{
                Color.white.cornerRadius(Constant.share.IphoneCornerRadius)
            VStack{
                HStack(spacing: CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (0.3)) ){
                    Text(Constant.share.ArtistaName).font(Font(StateSingleton.share.FontType(7, 20.0))).foregroundColor(Color.black).padding([.leading , .top], StateSingleton.share.PaddingFromTheLeadingEdge)
                    
                    Spacer()
                    ///FACEBOOK
                    Button(action: {
                        //
                    }){
                        Image(self.FaceBookUI)
                            .resizable()
                            .scaledToFill()
                    }.frame(width: self.ExternalSourceButtonSize, height: self.ExternalSourceButtonSize)
                    
                    
                    ///INSTAGRAM
                    Button(action: {
                        //
                    }){
                        Image(self.InstagramUI)
                            .resizable()
                            .scaledToFill()
                    }.frame(width: self.ExternalSourceButtonSize, height: self.ExternalSourceButtonSize)
                    
                    
                    ///TUMBLR
                    Button(action: {
                        //
                    }){
                        Image(self.TumblrUI)
                            .resizable()
                            .scaledToFill()
                    }.frame(width: self.ExternalSourceButtonSize, height: self.ExternalSourceButtonSize)
                    
                    ///DEVIANT ART
                    Button(action: {
                        //
                    }){
                        Image(self.DeviantArtUI)
                            .resizable()
                            .scaledToFill()
                    }.frame(width: self.ExternalSourceButtonSize, height: self.ExternalSourceButtonSize)
                
                }.padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge)//HStack With External media button
                HStack{
                    Text("Stories : ").font(Font(StateSingleton.share.FontType(7, 20.0))).foregroundColor(Color(StateSingleton.share.SeventyFivePercentBlack)).padding([.leading , .top], StateSingleton.share.PaddingFromTheLeadingEdge)
                    Spacer()
                }.frame(width: Constant.share.Width, alignment: .center)
                ArtistaContent().padding(.bottom, CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * 2.0))
                HStack{
                Text("Biography : ").font(Font(StateSingleton.share.FontType(7, 16.0))).foregroundColor(Color(StateSingleton.share.FiftyPercentBlack)).padding([.leading , .top], StateSingleton.share.PaddingFromTheLeadingEdge)
                    Spacer()
                }.frame(width: Constant.share.Width, alignment: .center)
                Biography()
                Spacer().frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (1/8)), alignment: .center)
                }.frame(width: Constant.share.Width, alignment: .center)//VStack
            }.frame(width: Constant.share.Width, alignment: .center)//ZStack
    }//body
}//Struct


struct ArtistaContent: View {
    var body : some View{
        TopContentView(Data: Constant.share.ArtistContentList)
    }
}


struct BiographyData : Identifiable {
    var id = UUID()
    var BioData : String
    init(Data : String) {
        self.BioData = Data
    }
}

struct Biography : View{
    var BiographyText = BiographyData(Data: "Sorry they have not shared their artistic Biography, but if you like thier work be sure to check if they have othe location for their data")
    var body : some View{
        HStack(alignment: .center){
            Text(BiographyText.BioData)
                            .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                            .font(Font(StateSingleton.share.FontType(6, 16.0)))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .frame(width: CGFloat(Constant.share.Width - (2 * StateSingleton.share.PaddingFromTheLeadingEdge)), alignment: .leading)
                            .padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
            Spacer()
            
        }.padding([.top , .leading], StateSingleton.share.PaddingFromTheLeadingEdge)//HStack
    }//body
}//struct




