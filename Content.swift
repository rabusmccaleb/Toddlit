//
//  Content.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 11/8/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.verticalSizeClass) var horizontalSizeClass
    var body : some View {
        Group {
            if horizontalSizeClass == .compact {
                landScapeContent()
            } else {
                portriatContent()
            }
        }
    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct landScapeContent : View {
    var body: some View{
        VStack(){
            // Landscape
            ContentWeb()//.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .center)
        }
    }
}


struct portriatContent : View {
    var portWidth = Constant.share.Width
//    var portHeight = CGFloat(Constant.share.Width * (0.618034) )// golden ratio
    var portHeight = CGFloat(Constant.share.Width * (0.69841269841) )// golden ratio

//0.69841269841 = 8.36 / 11.97 comes from the apple 13 inch retnia size
    var body: some View{
        ZStack(){
            //Portrait
            VStack(){
                ContentWeb().frame(width: self.portWidth, height: self.portHeight, alignment: .center)
                Spacer()
            }
            VStack{
                Spacer().frame(width: self.portWidth, height: CGFloat(self.portHeight * 1), alignment: .center)
                Spacer().background(ContentBottomData()).frame(width: self.portWidth, alignment: .center).cornerRadius(0)
            }
        }//.background(Color.black)
    }
}



struct ContentBottomData : View {
    var Padding = StateSingleton.share.PaddingFromTheLeadingEdge
    @Environment(\.presentationMode ) var ViewIsBeingPresented
    @State var ImmageRefference : String = StateSingleton.share.ImmageRefference
    @State var TitoloRefference : String = StateSingleton.share.TitoloRefference
    @State var ArtistaRefference : String = StateSingleton.share.ArtistaRefference
    var SpacerHeightTopPushTab = CGFloat(Constant.share.Height * (2.5 / 6))
    @State var SummaryRefference : String = StateSingleton.share.Summary
    @State var CreatorsData = [ArtistasData(Immagine: "7", ArtistName: "Rosso Leo", ArtistasDataRefference: "") ,  ArtistasData(Immagine: "3", ArtistName: "Rosso Leo", ArtistasDataRefference: "")]
    
    var portWidth = Constant.share.Width
//    var portHeight = CGFloat(Constant.share.Width * (0.618034) )// golden ratio
    var portHeight = CGFloat(Constant.share.Width * (0.69841269841) )// golden ratio
    
    var body: some View {
        ZStack(alignment : .bottom){
            SquareTab().fill(Color.white)
                .frame(width: Constant.share.Width, alignment: .center)
                .edgesIgnoringSafeArea(.all)
            
                ScrollView{
                    VStack(){
                        Spacer()
                        ZStack(alignment: .bottom){
                        Color.white
                            VStack(alignment: .leading){
                                ContentTitle(TitoloRefference: self.TitoloRefference)
                                ArtistasShareFavoriteAddToMyList(ArtistasRefference: self.ArtistaRefference).frame(width: Constant.share.Width)
                                Summary(SummaryRef : self.SummaryRefference)
                                ContentTags(Data: "Advendture, Family, Pastels, Man vs Nature").padding([.leading , .top ], StateSingleton.share.PaddingFromTheLeadingEdge)

                        }
                    }.frame(width: Constant.share.Width, alignment: .top)//Zstack in vstack
                }// VStack in scroll view
            }//ZStack In ZStack
        }//ZStack
    }//body
}

struct ContentTitle : View {
    var TitoloRefference : String = ""
    var body: some View {
        Text(self.TitoloRefference)
            .foregroundColor(Color.black)
            .font(Font(StateSingleton.share.FontType(7, 24)))
            .lineLimit(Int(2))
            .fixedSize(horizontal: false, vertical: false)
            .frame(width: CGFloat(Constant.share.Width / 1.5) , alignment: .leading)
            .padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
    }
}
