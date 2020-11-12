//
//  PreviewContent.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 3/6/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import SwiftUI
import Combine

struct PreviewContent: View {
    var Padding = StateSingleton.share.PaddingFromTheLeadingEdge
    @Environment(\.presentationMode ) var ViewIsBeingPresented
    @State var ImmageRefference : String = StateSingleton.share.ImmageRefference
    @State var TitoloRefference : String = StateSingleton.share.TitoloRefference
    @State var ArtistaRefference : String = StateSingleton.share.ArtistaRefference
    var SpacerHeightTopPushTab = CGFloat(Constant.share.Height * (2.5 / 6))
    @State var SummaryRefference : String = StateSingleton.share.Summary
    @State var CreatorsData = [ArtistasData(Immagine: "7", ArtistName: "Rosso Leo", ArtistasDataRefference: "") ,  ArtistasData(Immagine: "3", ArtistName: "Rosso Leo", ArtistasDataRefference: "")]
    var body: some View {
        ZStack(alignment : .bottom){
            SquareTab().fill(Color.white)
                .frame(width: Constant.share.Width, height: Constant.share.Height , alignment: .center)
                .edgesIgnoringSafeArea(.all)
           VStack{
               Image(self.ImmageRefference)
                   .resizable()
                   .scaledToFill()
                   .frame(width: Constant.share.Width, height: Constant.share.Width, alignment: .top)
                   .clipped()
               Spacer()
           }
                ScrollView{
                    VStack(){
                    Spacer().frame(width: Constant.share.Height, height: self.SpacerHeightTopPushTab, alignment: .top)
                        ZStack(alignment: .bottom){
                        Color.white
                            .cornerRadius(Constant.share.IphoneCornerRadius)
                            
                            VStack(alignment: .leading){
                                HStack(alignment: .top){
                                   // Spacer()

                                    TitoloPlay(TitoloRefference: self.TitoloRefference)
                                }.frame(width: Constant.share.Width)//PlayButtonSpacerHStack
                                ArtistasShareFavoriteAddToMyList(ArtistasRefference: self.ArtistaRefference).frame(width: Constant.share.Width)
                                Summary(SummaryRef : self.SummaryRefference)
                                HStack{
                                    ContentArtistas(Data: self.CreatorsData).padding(.top, CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge))
                                Spacer()
                                }
                                ContentTags(Data: "Advendture, Family, Pastels, Man vs Nature").padding([.leading , .top ], StateSingleton.share.PaddingFromTheLeadingEdge)
                                Spacer().frame(width: CGFloat(Constant.share.Width), height: CGFloat(Constant.share.Height * (5/100)), alignment: .top)
                        }
                    }.frame(width: Constant.share.Width, alignment: .top)//Zstack in vstack
                }// VStack in scroll view
            }//ZStack In ZStack
        }//ZStack
    }//body
}// Struct

struct PreviewContent_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContent()
    }
}

struct TitoloPlay : View{
    var TitoloRefference : String
    var PlayButtonSize : CGFloat = CGFloat(Constant.share.Width * (45 / 300))
    var body : some View {
        HStack{
        Text(self.TitoloRefference)
            .foregroundColor(Color.black)
            .font(Font(StateSingleton.share.FontType(7, 24)))
            .lineLimit(Int(2))
            .fixedSize(horizontal: false, vertical: true)
            .frame(width: CGFloat(Constant.share.Width / 1.5) , alignment: .leading)
            .padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
                
                Spacer()
                
        PlayButton().padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge).offset(x: 0 , y: CGFloat( (Constant.share.Width * (45 / 300)) * (-0.5) ))
        }
    }
}

struct ArtistasShareFavoriteAddToMyList : View {
    var ArtistasRefference : String
    var ShareAndFavorite : CGFloat = CGFloat(Constant.share.Width * (15 / 300))
    var AddToMyList : CGFloat = CGFloat(Constant.share.Width * (20 / 300))
    var body : some View{
        HStack{
            Text(self.ArtistasRefference)
                .foregroundColor(Color(StateSingleton.share.SeventyFivePercentBlack))
                .font(Font(StateSingleton.share.FontType(7, 16)))
                .padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
            Spacer()
            Button(action :{
                /// share with other parents / share on social media ... mainly made for the purpose of the parents to share stories that they think was great for their kids
            }){
                Image("AddToMyList")
                .resizable()
                .scaledToFit()
                .frame(width: self.ShareAndFavorite, height: self.ShareAndFavorite, alignment: .center)
            }// sharebutton end bracket
            
            Button(action :{
                /// allows for user engagement and to notify the creative client side what content really ressonates with the audiance
                /// will need to be a state var such that it can change appearence under certain conditons
            }){
                Image("AddToMyList")
                .resizable()
                .scaledToFit()
                .frame(width: self.ShareAndFavorite, height: self.ShareAndFavorite, alignment: .center)
            }// document as a favorite
            
            Button(action :{
                /// add the content to their list... this may be costly... because it doesn't asks users to be active it may be removed  until scalling is sufficient
                /// will need to be a state var such that it can change appearence under certain conditons
            }){
                Image("AddToMyList")
                    .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: self.AddToMyList, height: self.AddToMyList, alignment: .center)
                    .padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge)
            }// sharebutton end bracket
        }
        
    }
}

struct Summary : View {
    var SummaryRef : String
    
    var body : some View {
        Text(self.SummaryRef)
        .font(Font(StateSingleton.share.FontType(6, CGFloat(16.0))))
            .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)))
        .lineLimit(nil)
        .fixedSize(horizontal: false, vertical: true)
        .multilineTextAlignment(.leading)
        .frame(width: CGFloat(Constant.share.Width - (2 * StateSingleton.share.PaddingFromTheLeadingEdge)), alignment: .top)
        .padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
    }
}




struct ArtistasData : Identifiable{
    var id = UUID()
    var Immagine : String
    var ArtistName : String
    var ArtistasDataRefference : String // will be a url to load the next view
}

struct ContentArtistas : View {
    var Data = [ArtistasData(Immagine: "1", ArtistName: "DummyNameLol", ArtistasDataRefference: "")]
    var ImageWidthAndHeight = CGFloat((Constant.share.Width) * (50 / 300))
    var TitleText : String = "Creatives:"
    var body : some View{
        VStack(alignment : .leading){
            Text(self.TitleText)
                .font(Font(StateSingleton.share.FontType(7, 13)))
                .foregroundColor(Color(StateSingleton.share.SeventyFivePercentBlack))
        ScrollView{
        HStack(spacing : StateSingleton.share.PaddingFromTheLeadingEdge){
            ForEach(self.Data){ data in
                VStack{
                    Image(data.Immagine)
                        .resizable()
                        .scaledToFill()
                        .frame(width: self.ImageWidthAndHeight, height: self.ImageWidthAndHeight, alignment: .leading)
                        .clipShape(Circle())
                    Text(data.ArtistName)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(Font(StateSingleton.share.FontType(5, 12.0)))
                        .foregroundColor(Color.black)
                    
                }//.frame(width: (self.ImageWidthAndHeight + StateSingleton.share.PaddingFromTheLeadingEdge), height: (self.ImageWidthAndHeight + StateSingleton.share.PaddingFromTheLeadingEdge) , alignment: .leading)
                }// for each loop
            }// HStack
        }// ScrollView in the event thtat the somehow there are someany people part of a single project that it calls for the a number that stretches across the width of the screen
        }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)///VStack
    }//body
}// struct


struct ContentTags : View {
    var CategoriesTitle = "Categories :"
    var Data : String //[[String : String]] = // Refference : Tag name
    var body : some View{
        VStack(alignment : .leading){
        Text(self.CategoriesTitle)
        .font(Font(StateSingleton.share.FontType(7, 12)))
        .foregroundColor(Color(StateSingleton.share.SeventyFivePercentBlack))
        
            HStack{
               // ForEach(self.Data , id : UUID()){ data in// will use the for loop later when I know the propre way I want to impliment the structure
                    Button(action : {
                        ///should dismiss this view and then
                    }){
                            Text(self.Data)
                            .font(Font(StateSingleton.share.FontType(5, 10)))
                            .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                    }//tag button
              //  }//ForEach loop
            }//Hstack holding button and for each loop
        }//VStack holding category and category buttons
    }//body
}//struct


struct MoreLikeThisData : Identifiable {
    var id = UUID()
    var Immagine : String //likely a reference
    var Titolo : String //literally a reference
    
}
struct MoreLikeThis : View {
    var TitoloOfContent : String
    var ContentWidth = CGFloat( (Constant.share.Width / 2)  - (StateSingleton.share.PaddingFromTheLeadingEdge * 3))// needs to be three less than the padding such that the view can have padding on both the trailing and leading... and padding on the space between both objecs
    var body : some View {
        VStack{
            Text("More Like \(self.TitoloOfContent)")
            HStack(spacing : StateSingleton.share.PaddingFromTheLeadingEdge){
                Button(action : {
                    ///action
                }){
                    Image("")
                }
                Button(action : {
                    ///action
                }){
                    Image("")
                }
                
            }
        }
    }
}
