//
//  Home.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 2/16/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import SwiftUI
import SwiftAudio

struct OldHome: View {
    var GenreDataOneThroughThree = [
        AllGenresData(GenreTitolo: Constant.share.genreOne, GenreData: Constant.share.genreOneData)
        ,
        AllGenresData(GenreTitolo: Constant.share.genreTwo, GenreData: Constant.share.genreTwoData)
        ,
        AllGenresData(GenreTitolo: Constant.share.genreThree, GenreData: Constant.share.genreThreeData)
    ]
    var GenreDataFourThroughSix = [
        AllGenresData(GenreTitolo: Constant.share.genreFour, GenreData: Constant.share.genreFourData)
        ,
        AllGenresData(GenreTitolo: Constant.share.genreFive, GenreData: Constant.share.genreFiveData)
        ,
        AllGenresData(GenreTitolo: Constant.share.genreSix, GenreData: Constant.share.genreSixData)
                        
    ]
    var body: some View {
        ZStack{
              Color.white
            VStack{
            Spacer()
                SquareTab().fill(Color.white).edgesIgnoringSafeArea(.bottom).frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (3 / 8)), alignment: .bottom)
            }

            ScrollView(.vertical , showsIndicators: false){
                
                VStack(spacing: CGFloat( 3 / 600 * (Constant.share.Height))){
                    ZStack(alignment: .center){
                        ReccomendedStory()
                        VStack{
                            LogoUserTab().frame(alignment: .topLeading)
                            Spacer().frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (5/10)), alignment: .center)
                        }
                    }.edgesIgnoringSafeArea(.top).frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (5/10)), alignment: .topLeading)
                    ZStack(alignment : .top){
                        Color.white.cornerRadius(Constant.share.IphoneCornerRadius)
                        // if you look at the frame size I used for the square tab below you will see that it is not only the content size but also the 15% of the screen size such that it does't cause errors scrolling
                        //SquareTab().fill(Color.white).edgesIgnoringSafeArea(.bottom).frame(width: Constant.share.Width, height: CGFloat(geometry.size.height + (Constant.share.Height * 0.15) ), alignment: .bottom).fixedSize(horizontal: true, vertical: false).cornerRadius(28.0)
                        VStack(alignment: .leading , spacing : 0){
                            PlayReccomended()
                            
                            
                            Spacer().frame(width: Constant.share.Width, height: (StateSingleton.share.PaddingFromTheLeadingEdge * 0.3), alignment: .center)

                            Group{
                            Spacer().frame(width: Constant.share.Width, height: CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * 1.3), alignment: .center)
                            //MainImagesView()
                           // Group{
                            TitleViewAll()
                            GoodStories()
                            }// group
                            
                            TitleViewAll(TitoloText: "Artists & Writers").padding([.top], StateSingleton.share.PaddingFromTheLeadingEdge)
                            ArtistasCircleView().padding(.bottom, StateSingleton.share.PaddingFromTheLeadingEdge)

                            
                //GenreTitolo GenreData
                            Group{
                                VStack(spacing : 0){
                            ForEach(self.GenreDataOneThroughThree) {data in
                                TitleViewAll(TitoloText: data.GenreTitolo).padding([.top], CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (0.2) ))
                                GoodStories(Data: data.GenreData)
                                Spacer().frame(width: Constant.share.Width, height: StateSingleton.share.PaddingFromTheLeadingEdge)
                                }//ForeEach
                                }//Vstack
                            }//group
                            
                            
                            

                            
                            DiscoverArtista().frame(width: Constant.share.Width, alignment: .center).padding([.bottom , .top],
                                                                                    StateSingleton.share.PaddingFromTheLeadingEdge)
                            
                            Group{
                                VStack(spacing : CGFloat(0)){
                            ForEach(self.GenreDataFourThroughSix) {data in
                                TitleViewAll(TitoloText: data.GenreTitolo).padding([.top], CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (0.2) ))
                                GoodStories(Data: data.GenreData)
                                Spacer().frame(width: Constant.share.Width, height: StateSingleton.share.PaddingFromTheLeadingEdge)
                                }//ForeEach
                                }//Vstack
                            }//group
                        }//.padding([.top, .bottom], StateSingleton.share.PaddingFromTheLeadingEdge)
                    }.frame(width: Constant.share.Width, alignment: .top)
                }//vstack in scrollview
            }.simultaneousGesture(DragGesture().onChanged({_ in
                //StateSingleton.share.PlayASong()
            }))// scroll view

        }// ZStack In the gemoerty reader
      // }.animation(.spring())// geometery reader
    }// body
}// struct

struct OldHome_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}





//Reusable Structres For looping through all conent that needs to be loaded:
struct AllGenresData : Identifiable{
    var id = UUID()
    var GenreTitolo : String
    var GenreData : [GoodStorysData]
}




struct TopViewStructure : Identifiable {
    var id  = UUID()
    var Titolo : String
    var Immagine : String
    var Artistas : String
    var InfoRefference : String
    var ContentReffernce : String
    var ThisRefference : String
    var Genres : String
    
    var CreatorsImage : String
    // the old reffence that is source of the inial node in the tree
    
}

struct TopContentView : View{
    @State private var presentPreviewContent = false
    var AddToMyListWidth : CGFloat = CGFloat(UIScreen.main.bounds.width * CGFloat(0.055))
    var MainImageWidth = CGFloat(Constant.share.Width * (18 / 30))
    var MainImageHeight = CGFloat((Constant.share.Width * (21 / 30)) * (1.3))
    var CornerRadiusForViewSet : CGFloat = CGFloat(28.0)
    var Data = [TopViewStructure(Titolo: "Boy At Sea", Immagine: "Boy", Artistas: "Rosso Leo", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Adventure, Existentialism, WaterColor, Man vs Nature" , CreatorsImage : "1")
    ,
                TopViewStructure(Titolo: "Mountain View", Immagine: "1", Artistas: "Lisa Lang", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Adventure, Existentialism, WaterColor, Man vs Nature", CreatorsImage : "2")
    ,
                TopViewStructure(Titolo: "Spider-Man", Immagine: "2", Artistas: "Steve Dicko", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Altruism, Moral Objectivism, Man vs Man" , CreatorsImage : "3")
    ,
                TopViewStructure(Titolo: "Home Sick", Immagine: "3", Artistas: "Jessie Sharp", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Slice Of Life, Loniness, Indivdualism, Graphic Gradients", CreatorsImage: "4")
    ,
                TopViewStructure(Titolo: "Old Days", Immagine: "108", Artistas: "Marydith Martin", InfoRefference: "", ContentReffernce: "", ThisRefference : "" ,   Genres: "Adventure, Family, Pastels, Man vs Nature",  CreatorsImage : "5")
        
    ]
var body : some View{
    ScrollView(.horizontal , showsIndicators: false){
        HStack(spacing : CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * 1.5)){
            ForEach(Data) {data in
              //  GeometryReader{ geom in
                HStack{
                    ZStack{
                       // SquareTab().fill(Color.black).frame(width : self.MainImageWidthAndHeight, height : self.MainImageWidthAndHeight , alignment : .top).cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                    ZStack{
                    /// IMAGE
                        HStack(alignment: .center){
                        Button(action : {
                       // PreviewContent(ImmageRefference: data.CopetinaImmagine , TitoloRefference: data.Titolo , ArtistaRefference: data.Artistas)
                            
                            
                            StateSingleton.share.PassingDataBetweenViews(Image: data.Immagine, Title: data.Titolo, Artists: data.Artistas, ArtistaImage: data.CreatorsImage)
                            self.presentPreviewContent.toggle()
                            //Home()
                        }){
                            
                            
                            Image(data.Immagine)// has the Id I have to loop through
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.top)
                            .frame(width : self.MainImageWidth, height : self.MainImageHeight , alignment : .top)
                            .clipped()
                            .cornerRadius(CGFloat(35.0))
                                //.shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                        }.sheet(isPresented: self.$presentPreviewContent){
                           
                            PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                            }// end of buton modifier brakets
                        }.frame(width : CGFloat(self.MainImageWidth + StateSingleton.share.PaddingFromTheLeadingEdge), height :CGFloat(self.MainImageHeight + StateSingleton.share.PaddingFromTheLeadingEdge) , alignment : .bottom)//.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// end of zstack brackets
                    /// END OF IMAGE
                        
                        VStack(alignment : .leading){// to push everything down
                        Spacer()// the spacer pushes everything down
                        HStack(alignment: .bottom){
                        VStack(alignment : .leading , spacing : 3.0){
                                Button(action : {
                                    // segue to summary and info view on this content
                                }){
                                    Text(data.Titolo)
                                    .font(Font(StateSingleton.share.FontType(5, CGFloat(20.0))))
                                    .foregroundColor(Color.white)
                                    
                                    
                                }// end of actio button fot titolo
                            Text("By: \(data.Artistas)")
                                    .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                                    .foregroundColor(Color(StateSingleton.share.SeventyFivePercentWhite))
                            }// V Stack : with titolo and artistas
                            
                        Spacer()// to distribute the objects out in the view
                    HStack(spacing : 5.0){// need to have an if conditional statement
                        Button(action : {
                            //segue to summary and info view on this content
                            }){
                                Image("ContentInfo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        
                        Button(action: {
                            // add to my list functionality which means that it will have to store the
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        }.padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack : holding info and add to my list buttons
                        
                        }.frame(width : self.MainImageWidth , alignment : .bottom).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)//Hstack in zstack:             holding the titolo, artistas, add to my list, and info button
                        
                            Text("Tags : \(data.Genres)")
                            .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                            .foregroundColor(Color(StateSingleton.share.FiftyPercentWhite))
                            .lineLimit(1)
                            .frame(width : CGFloat(self.MainImageWidth - StateSingleton.share.PaddingFromTheLeadingEdge), alignment : .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
                            
                            
                        }.padding(.bottom, StateSingleton.share.PaddingFromTheLeadingEdge)// VStack to push all objects down to the bottom of the frame that are in the artista, titolo, info, and add to my list
                    }.frame(width : CGFloat(self.MainImageWidth), height :CGFloat(self.MainImageHeight) , alignment : .bottom)//ZStack in Hstack
                }//.cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))/// final ZStack Braket for shadow under the entire set of buttons
                    
                }//HStack Bracket after the geometry reader and for each loop
                
                // }//             GEOMETRY READER
                }//                 FOR EACH LOOP
        }.padding([.leading , .trailing], StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack in scrollView
        }//.shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.45)), radius: CGFloat(15.0), x: CGFloat(0.0), y: CGFloat(30.0))// SCROLL VIEW
    }//                             BODY
}//                                  STRUCT


struct GoodStorysData : Identifiable{
    var id = UUID()// to generate a random ID
    var Titolo : String
    var Artistas : String
    var Immagine : String
    var ContentType : String
    var ReferenceToInforView : String // will be a Url in th future
    var RefferenceToContent : String // will be a Url to grab the tree such that all the data can be loaded
    
    var CreatorsImage : String
}
struct GoodStories : View{
    var Data = [GoodStorysData(Titolo: "Exploration", Artistas: "Lisa Apple", Immagine: "4", ContentType: "Solo", ReferenceToInforView: "", RefferenceToContent: "" , CreatorsImage : "1")
        ,
                GoodStorysData(Titolo: "We're All The Same", Artistas: " Anna Edison", Immagine: "5", ContentType: "Series", ReferenceToInforView: "", RefferenceToContent: "" , CreatorsImage : "2" )
        ,
                GoodStorysData(Titolo: "Uhh Spiderman", Artistas : "Steve Dick" , Immagine: "6", ContentType: "Series", ReferenceToInforView: "", RefferenceToContent: "" , CreatorsImage : "3")
        ,
                GoodStorysData(Titolo: "The Creepy House", Artistas : "Kim Jung", Immagine: "7", ContentType: "Solo", ReferenceToInforView: "", RefferenceToContent: "" , CreatorsImage : "4" )
        ,
                GoodStorysData(Titolo: "Best Of Friends", Artistas : "Riley Lee" , Immagine: "8", ContentType: "Series", ReferenceToInforView: "", RefferenceToContent: "" , CreatorsImage : "5")
            ,
                GoodStorysData(Titolo: "Lost Again", Artistas : "Richard Sake", Immagine: "9", ContentType: "Series", ReferenceToInforView: "", RefferenceToContent: "" , CreatorsImage : "6")
            ,
                GoodStorysData(Titolo: "Fairy Fairy Happy", Artistas : "Jean la Piche", Immagine: "10", ContentType: "Series", ReferenceToInforView: "", RefferenceToContent: "" , CreatorsImage : "7")
            ,
                GoodStorysData(Titolo: "The Meta and The Magical", Artistas: "Art Simmson, Lisa Grab" , Immagine: "13", ContentType: "Solo", ReferenceToInforView: "", RefferenceToContent: "" , CreatorsImage : "8")
    ]
    
    @State var presentPreviewContent = false
    var ObjectWidth : CGFloat = CGFloat(UIScreen.main.bounds.width / 4.0)
    var ObjectHeight : CGFloat = CGFloat((UIScreen.main.bounds.width / 4.0) * 1.3333333)//
    
    
    
    var body : some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing : CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * 0.5)){
                ForEach(self.Data){ data in
                   // GeometryReader{ geom in
                VStack(alignment: .leading){
                    Button(action : {
                        // action to srgue to view
                        StateSingleton.share.PassingDataBetweenViews(Image: data.Immagine, Title: data.Titolo, Artists: data.Artistas, ArtistaImage: data.CreatorsImage)
                        self.presentPreviewContent.toggle()
                    }){
                        Image(data.Immagine)
                        .renderingMode(.original)// used to remove blue color
                        .resizable()
                        .scaledToFill()
                        .frame(width: self.ObjectWidth , height: self.ObjectHeight , alignment: .center)
                        .clipped()
                        .cornerRadius(20.0)
                    }.frame(width: self.ObjectWidth , height: self.ObjectHeight , alignment: .top).sheet(isPresented: self.$presentPreviewContent ){
                        PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                     }
                    
                    Button(action : {
                        //action to seguee to view
                        StateSingleton.share.PassingDataBetweenViews(Image: data.Immagine, Title: data.Titolo, Artists: data.Artistas,  ArtistaImage: data.CreatorsImage )
                        self.presentPreviewContent.toggle()
                    }){
                        VStack{
                            Text(data.Titolo).lineLimit(2).fixedSize(horizontal: false, vertical: true).foregroundColor(Color.black).font(Font(StateSingleton.share.FontType(5, 12))).frame(width: self.ObjectWidth , alignment: .leading)
                    Text(data.ContentType).foregroundColor(Color(StateSingleton.share.TwentieFivePercentBlack)).font(Font(StateSingleton.share.FontType(5,  10))).frame(width: self.ObjectWidth , alignment: .leading)
                        }
                    }.frame(width: self.ObjectWidth , alignment: .leading).sheet(isPresented: self.$presentPreviewContent ){
                       PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                    }
                    
                    }.fixedSize(horizontal: false, vertical: true).frame(width: self.ObjectWidth  , alignment: .top)// VStack end bracket in the for each end bracket
                    }//For Each
                //}// Geometry reader
            }.padding([.leading , .trailing], StateSingleton.share.PaddingFromTheLeadingEdge)// Hstack
        }//.shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: 10.0, x: 0.0, y: 2.0)///Scroll VIew
    }// Body
}// Struct

struct CircleData : Identifiable{
    var id = UUID()
    var Artista : String
    var Immagine : String
    var ArtistaViewRefference : String // a url for the next view to load data
     
}
struct ArtistasCircleView : View{
    var CircleRadius = CGFloat((CGFloat(UIScreen.main.bounds.width)) / 3.0 )
    var Data = [
        CircleData(Artista: "Rosso Leo", Immagine: "Boy", ArtistaViewRefference: "")
        ,
        CircleData(Artista: "Ayn Rand", Immagine: "16", ArtistaViewRefference: "")
        ,
        CircleData(Artista: "Fred Niech", Immagine: "15", ArtistaViewRefference: "")
        ,
        CircleData(Artista: "Allison Fits", Immagine: "14", ArtistaViewRefference: "")
        ,
        CircleData(Artista: "Tole Stoyp", Immagine: "12", ArtistaViewRefference: "")
        ,
        CircleData(Artista: "Karl Youngman", Immagine: "11", ArtistaViewRefference: "")
    ]
    var body : some View {
        ScrollView(.horizontal , showsIndicators: false){
            HStack{
                ForEach(Data){ data in
                    VStack{
                            Button(action:{
                                //actions
                            }){
                                Image(data.Immagine)
                                .renderingMode(.original)// used to remove blue color
                                .resizable()
                                .scaledToFill()
                                .frame(width: self.CircleRadius, height: self.CircleRadius, alignment: .center)
                                .clipShape(Circle())
                                
                            }.frame(width: CGFloat(self.CircleRadius + 10), height: CGFloat(self.CircleRadius + 10), alignment: .center)
                           // .shadow(color: Color(StateSingleton.share.TwentieFivePercentBlack) , radius: 2.0 , x: 2.0 , y: 10.0)
                            Button(action : {
                                //action to seguee to view
                            }){
                                Text(data.Artista).lineLimit(1).foregroundColor(Color(StateSingleton.share.FiftyPercentBlack)).font(Font(StateSingleton.share.FontType(7, 13))).frame(width: self.CircleRadius , alignment: .center)
                            }
                    }// VSTACK
                }// FOR EACH
                
            }//HSTACK
        }// SCROLLVIEW
        
    }// body
}// struct








/// Home Views :
struct MainImagesView : View{
    var WidthAndHeight = CGFloat(Constant.share.Width * (2 / 3))
    var body : some View{
        ZStack(){
            Button(action : {
                //
            }){
            Image("2")
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.top)
                .frame(width : self.WidthAndHeight, height : self.WidthAndHeight , alignment : .top)
                .clipped()
                .cornerRadius(25.0)
            }// end of buton modifier brakets
        }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// end of zstack brackets
    }
}

struct HomeMainBackGroundImage : View{
    var body : some View {
        ZStack{
        Image("12")
        .resizable()
        .scaledToFill()
        .frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .top)
        }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .top)
    }
}

struct HomeWhiteTab : View{
    var TabHeight = CGFloat(Constant.share.Height * (8 / 9))
    var CornerRadius = CGFloat(30.0)
    var body : some View{
        HStack(alignment : .bottom){
            SquareTab().fill(Color.white).frame(width: Constant.share.Width, height: self.TabHeight, alignment: .bottom).cornerRadius(self.CornerRadius).edgesIgnoringSafeArea(.bottom)
        }.frame(width: Constant.share.Height, height: self.TabHeight, alignment: .bottom)
    }
}

struct LogoUserTab : View { 
    var TopContentHeight = CGFloat(Constant.share.Height * (1 / 14))
    var UserImageHeightAndWidth = CGFloat(Constant.share.Height * (10/300))
    var body : some View{
        ZStack{
            Color.white.cornerRadius(CGFloat(Constant.share.Height * (3 / 100 ))).frame(width: CGFloat(Constant.share.Width), height: CGFloat((Constant.share.Height * (1 / 14) + (StateSingleton.share.PaddingFromTheLeadingEdge))), alignment: .topLeading)
            
            VStack{
                HStack(alignment : .bottom){
                        HStack{
                            Image("ToddLogo")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: self.UserImageHeightAndWidth, height: self.UserImageHeightAndWidth, alignment: .bottom)
                            
                            Text("TODDLIT")
                            .font(Font(StateSingleton.share.FontType(2, CGFloat(20.0))))
                                .foregroundColor(Color.black)//.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)//.padding(.trailing, CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge / 2 ))
                        }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// hstack in hstak end brackets
                    
                    Spacer()
                    UserButtonAndName().padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge)
                    
                }.frame(width: Constant.share.Width, height: self.TopContentHeight, alignment: .bottom)
                
            }// VStack
        }.edgesIgnoringSafeArea(.all).frame(width: CGFloat(Constant.share.Width), height: CGFloat((Constant.share.Height * (1 / 14) + (StateSingleton.share.PaddingFromTheLeadingEdge))), alignment: .topLeading)//ZStack
    }//body viuew
}// LogoUserTab brackets

struct UserButtonAndName : View {
    var UserImageHeightAndWidth = CGFloat(Constant.share.Height * (10/300))
    @State var UserSettingPage = false
    var UserName = "Clarke"
    var body : some View{
        HStack{
            Button(action : {
                self.UserSettingPage.toggle()
                // should segue user to his profile image for a change and to change his usernam if wanted
            }){
                Image("108")
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: CGFloat(self.UserImageHeightAndWidth * (1/30))))
                    .frame(width: self.UserImageHeightAndWidth, height: self.UserImageHeightAndWidth, alignment: .center)
            }.frame(width: self.UserImageHeightAndWidth, height: self.UserImageHeightAndWidth, alignment: .center).sheet(isPresented: self.$UserSettingPage ){
               UserSettings()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
            }// button action modifier
            Button(action : {
                self.UserSettingPage.toggle()
                // should segue user to his profile image for a change and to change his usernam if wanted
                
            }){
            Text(self.UserName)
                .font(Font(StateSingleton.share.FontType(2, CGFloat(14.0))))
                .foregroundColor(Color(StateSingleton.share.SeventyFivePercentBlack))
            }.sheet(isPresented: self.$UserSettingPage ){
               UserSettings()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
            }
        }// hstack end bracket
    }//body bracket
}// struct end bracket




struct ReccomendedStory: View{
    var body: some View{
        ZStack{
            /// Button
            Button(action: {
                // Perform action show content
            }){
                Image("13")
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (55/100)), alignment: .center)
            }.frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (55/100)), alignment: .center)
        
            Spacer().frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (50 / 100)), alignment: .center)
        }.frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (50 / 100)), alignment: .center)
    }
}

struct PlayReccomended : View {
        var PlayButtonSize : CGFloat = CGFloat(Constant.share.Width * (45 / 300))
    var StoryTitle : String = "The Meta and the Magical"
    var Artists : String = "Joesph Hue"
    var Tags : String = "Exitential, Metaphysics, Ontology,..."
    var body: some View{
        VStack{
            HStack{
                Text(StoryTitle)
                    .foregroundColor(Color.black)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(Font(StateSingleton.share.FontType(5, CGFloat(Constant.share.Height * (6/600) ))))
                Spacer()
                
                Button(action : {
                    /// This is one of the most crucial button in the whole application it has to be done correctly
                }){
                    Circle()
                        .fill(Color.black)
                        .shadow(color: Color(StateSingleton.share.ShadowColor), radius: 5.0, x: 3.0, y: 10.0)
                        .frame(width: self.PlayButtonSize, height: self.PlayButtonSize, alignment: .trailing)
                        .padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge)
                        .offset(x: 0.0, y: CGFloat( -1 * ((self.PlayButtonSize / 3 ) + StateSingleton.share.PaddingFromTheLeadingEdge )))
                    
                }.padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge)
            }// HSTACK TITLE AND PLAY BUTTON
            
            
        }//VSTACK
    }
}











struct MainTopControl : View {
    var Authors : String = "Rosso Leo"
    var ReadMe : String  = "R E A D"
    var AddToMyListWidth : CGFloat = CGFloat(UIScreen.main.bounds.width * CGFloat(0.07))
    var AllFrameWidth = CGFloat((UIScreen.main.bounds.width) / 3.5 )

    var body : some View{
        
        HStack{
            VStack(alignment: .leading){
                Text(self.Authors)
                
            }.frame(width: self.AllFrameWidth , height: 5.0 , alignment: .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)///VStack End Bracket
            
            Spacer()
            
            VStack(alignment: .center){
                //image... to be pulled down.
                Text(self.ReadMe)
                ToggleDownCapsule()
                
            }.frame(width: self.AllFrameWidth , height: 5.0 , alignment: .center)
            
            Spacer()
            
            VStack(alignment: .trailing){
                    Button(action : {
                        // action
                    }){
                        Image("AddToMyList")
                            .resizable()
                            .scaledToFit()
                            .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                    }.padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())
            }.frame(width: self.AllFrameWidth , height: 5.0 , alignment: .trailing)
            
            
            
        }.frame(width: UIScreen.main.bounds.width, height: 100 , alignment: .bottom)
            .padding(.bottom, 30.0)//HStack End Bracket
        
    }
}




struct RectangleRowOfContent : View{
    
    var body : some View{
        ScrollView(.horizontal){
            HStack(spacing : CGFloat(15.0)){
                ContentImage()
                ContentImage()
                ContentImage()
                ContentImage()
                ContentImage()
                ContentImage()
                ContentImage()
                ContentImage()
            }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// end of HStack brackets
        }//end of scroll view brackets
    }// end of body brackets
}// end of FirstRowOfContent brackets


struct TitleViewAll : View {
    var TitoloText : String = "Good Stories"
    var ViewAllRef : String = "108"
    var ArrowRef : String =  "108"
    var ViewAllSizeWidth : CGFloat = CGFloat((CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))) * (16.0 / 9.0))
    var ArrowSize : CGFloat =  CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))
    var FontSize : CGFloat = CGFloat( (11 / 600) * (Constant.share.Height))
    var body : some View{
        HStack{
        Text(self.TitoloText)
            .font(Font(StateSingleton.share.FontType(5, FontSize )))
            .foregroundColor(Color.black)
//            .foregroundColor(Color(StateSingleton.share.SubtitleFontColor))
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
        //Font Color and type end here
            Spacer()
            ViewMoreArrow()

        }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)/// end of Hstack brackets
        
    }// end of body brackets
}// end of title view all brackets


struct ViewMoreArrow : View {
    var ViewAllSizeWidth : CGFloat = CGFloat((CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))) * (16.0 / 9.0))
    var ArrowSize : CGFloat =  CGFloat(UIScreen.main.bounds.width * CGFloat(0.05))
    var ViewAllRef : String = "108"
    var ArrowRef : String =  "MoreArrow"
    var body : some View{
        HStack(spacing : 10){
        Button(action :{
           //Should Segue to view all content of this sort
        } ){
            ZStack{
                SquareTab()
                    .fill(Color.clear)
                    .overlay(RoundedRectangle(cornerRadius: CGFloat(self.ArrowSize * (1/5)))                   .stroke(Color(StateSingleton.share.TwentieFivePercentBlack) , lineWidth: CGFloat(self.ArrowSize * (1/12))))
                    .frame(width: self.ViewAllSizeWidth , height: self.ArrowSize, alignment: .center)
                
                
                Text("more")
                    .font(Font(StateSingleton.share.FontType(5, CGFloat(self.ArrowSize * (1/2) ))))
                    .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                
                }.frame(width: self.ViewAllSizeWidth , height: self.ArrowSize, alignment: .center)// zstack
            
            }.frame(width: self.ViewAllSizeWidth , height: self.ArrowSize, alignment: .center)//Buttton
        
        Button(action :{
            //
        }){
        Image(ArrowRef)
            .renderingMode(.original)// used to remove blue color
            .resizable()
            .scaledToFit()
            .frame(width: CGFloat(self.ArrowSize * (4.3/6)) , height: CGFloat(self.ArrowSize * (4.3/6)), alignment: .center)
            .clipped()
        }
        }.padding(.trailing, CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * 0.625 ))//Hstack
    } // body
}// struct
















struct ContentImage : View {
    var URLData : String = ""
    var ObjectWidth : CGFloat = CGFloat(UIScreen.main.bounds.width / 5)
    var ObjectHeight : CGFloat = CGFloat(((UIScreen.main.bounds.width/5) / 2.0) * 3.0)// this math is to make an the image view that has the ration of 2:3(Width:Height)
    

    var body : some View{
        VStack{
            Button(action: {
    //
            }){
                Image("108")
            .renderingMode(.original)// used to remove blue color
            .resizable()
            .scaledToFill()
            .frame(width: self.ObjectWidth , height: self.ObjectHeight , alignment: .center)
            .clipped()
            .cornerRadius(20.0)
            }.frame(width: CGFloat(self.ObjectWidth + 10) , height: CGFloat(self.ObjectHeight + 10) , alignment: .leading)
               // .shadow(color: Color(StateSingleton.share.ShadowColor) , radius: 2.0 , x: 2, y: 0)// end of button call
            
        }// VStack bracket
    }// end of body
}





struct TitoloForContent : View {
    var Title : String = ""/// have to figure out how to change this according to the data that needs to be place in here
    var body : some View {
        Text(self.Title)
        .lineLimit(2)
    }
}









struct CircleHorizontalStack : View {
    var body : some View {
        ScrollView(.horizontal){
            HStack(spacing: 15.0){
                CircleButtons()
                CircleButtons()
                CircleButtons()
                CircleButtons()
                CircleButtons()
                CircleButtons()
                
            }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
        }
    }
}


struct CircleButtons : View{
    var Url : String = ""
    var ImaggineRef : String = "1"
    var CircleRadius = CGFloat((CGFloat(UIScreen.main.bounds.width)) / 3.0 )
    var body : some View{
        Button(action:{
            //
        }){
            Image(self.ImaggineRef)
            .renderingMode(.original)// used to remove blue color
            .resizable()
            .scaledToFill()
            .frame(width: self.CircleRadius, height: self.CircleRadius, alignment: .center)
            .clipShape(Circle())
//            .shadow(color: Color(StateSingleton.share.ShadowColor) , radius: 5.0 , x: 2.0 , y: 4.0)
            
        }.frame(width: CGFloat(self.CircleRadius + 10), height: CGFloat(self.CircleRadius + 10), alignment: .center)
        .shadow(color: Color(StateSingleton.share.ShadowColor) , radius: 2.0 , x: 2.0 , y: 4.0)
    }
}

struct ThirdRowTrapazoid: View {

    var body : some View{
        ScrollView(.horizontal){
            HStack{
                TrapazoidDuo()
                TrapazoidDuo()
        }//Major HStack Just under the scroll view
    }//scroll view
    }//body
}//struct


struct TrapazoidDuo : View {
    var Url : String = ""
    var ImmagineRef : String = ""
    var TrapazoidHeight = CGFloat((CGFloat(UIScreen.main.bounds.width)) / 3.0 )
    var TrapazoidWidth =  CGFloat((UIScreen.main.bounds.width) * (2 / 3))
    
    var body : some View{
        HStack(spacing: -50.0){
        Button(action : {
            //action
        }){
            Image("3")
            .renderingMode(.original)// used to remove blue color
            .resizable()
            .scaledToFill()
            .frame(width: self.TrapazoidWidth, height: self.TrapazoidHeight, alignment: .center)
            .clipShape(firstHalf())
                .cornerRadius(5.0)
              
                .shadow(color: Color(StateSingleton.share.ShadowColor), radius: 2.0 , x: 2.0, y: 4.0)
        }.frame(width: self.TrapazoidWidth, height: self.TrapazoidHeight, alignment: .center)
        
        Button(action : {
            //action
        }){
            Image("108")
            .renderingMode(.original)// used to remove blue color
            .resizable()
            .scaledToFill()
            .frame(width: self.TrapazoidWidth, height: self.TrapazoidHeight, alignment: .center)
            .clipShape(secondHalf())
                .cornerRadius(5.0)
              
                .shadow(color: Color(StateSingleton.share.ShadowColor), radius: 2.0 , x: 2.0, y: 4.0)
        }.frame(width: self.TrapazoidWidth, height: self.TrapazoidHeight, alignment: .center)
        }.padding(StateSingleton.share.PaddingFromTheLeadingEdge)//hstack
        
        
    }
}


struct firstHalf : Shape{
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: CGFloat((rect.maxX) * 0.75), y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }// end of path brackets
    
    }// End of func path in rect brackets
}// end of "First Half" of struct brackets
//path.addLine(to: CGPoint(x: CGFloat(rect.minX + ((rect.maxX) * 0.75)) , y: rect.minY))
struct secondHalf : Shape{
    func path(in rect: CGRect)-> Path{
        Path{ path in
            path.move(to: CGPoint(x: rect.minX , y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: CGFloat(rect.minX + ((rect.maxX) * 0.25)) , y: rect.maxY))
            //path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
           // path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            //path.addLine(to: CGPoint(x: CGFloat(rect.minX + ((rect.maxX) * 0.25)) , y: rect.minY))
           // path.addLine(to: CGPoint(x: ((rect.maxX) * 0.25), y: rect.maxY))
        }
    }
}


struct DiscoverArtistaData : Identifiable {
    var id = UUID()
    var ArtistaName : String
    
    init(Artistaname : String) {
        self.ArtistaName = Artistaname
    }
}
struct DiscoverArtista : View{
    var width = CGFloat((UIScreen.main.bounds.width) * (2.5 / 3))
    var height = CGFloat((UIScreen.main.bounds.height) * (1.5 / 6.0))
    var DiscoverfontSizeProportional = CGFloat(Constant.share.Height * (1/20))
    var ArtistafontSizeProportional = CGFloat(Constant.share.Height * (1/40))
    var ArrowButtonSize = CGFloat(Constant.share.Width * (1 / 22))
    @State var ArtistaViewBool = false
    
    var Data = ArtistaViewData(ArtistaNameData: Constant.share.ArtistaName , ArtistaImmagineData: Constant.share.ArtistaImmagineData, ArtistaStoriesData: Constant.share.ArtistContentList, ArtistaSummaryData: Constant.share.ArtistaSummaryData, Facebook: Constant.share.FaceBookRef, Instagram: Constant.share.InstagramRef, Tumblr: Constant.share.TumblrRef , DeviantArt: Constant.share.TumblrRef)
    init(){
        Constant.share.FunctionFetchArtistaData()
    }
    var body : some View {
        ZStack{
            HStack{
                Button(action : {
                //action
                    
                    self.ArtistaViewBool.toggle()
                }){
                    Image("10")
                        .renderingMode(.original)// used to remove blue color
                        .resizable()
                        .scaledToFill()
                        .frame(width: (Constant.share.Width - (StateSingleton.share.PaddingFromTheLeadingEdge * 2)), height: self.height, alignment: .center)
                        .cornerRadius(CGFloat(self.height * (1.5 / 10)))
                        .clipped()
                    }//button end of modifier
            }.sheet(isPresented: self.$ArtistaViewBool){
                ArtistaView()
            }//HStack
            HStack{
                Spacer()
                VStack(alignment : .leading , spacing : StateSingleton.share.PaddingFromTheLeadingEdge){
                    Text("Discover")
                        .foregroundColor(Color.black)
                        .font((Font(StateSingleton.share.FontType(5, self.DiscoverfontSizeProportional))))
                    Text(Constant.share.ArtistaName)
                        .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                        .font((Font(StateSingleton.share.FontType(5, self.ArtistafontSizeProportional))))
                    DiscoveryArrow()

                }.padding(.all , StateSingleton.share.PaddingFromTheLeadingEdge)//VStack
            }//HStack
        }.frame(width: (Constant.share.Width - (StateSingleton.share.PaddingFromTheLeadingEdge * 2)), height: self.height, alignment: .center)//ZStack
    }//Body
}//Struct

struct DiscoveryArrow : View{
    var ArrowButtonSize = CGFloat(Constant.share.Width * (1 / 22))
    var body : some View{
        VStack{
            Spacer()
            Button(action:{
                //action next arrow
            }){
                Image("ContentInfo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: self.ArrowButtonSize, height: self.ArrowButtonSize, alignment: .center)
//                    .renderingMode(.original)
            }//button modifuer
        }// vstack
    }
}

struct ToggleDownCapsule : View{
    var Height = CGFloat((UIScreen.main.bounds.height) * (4 / 620))
    var Width = CGFloat((UIScreen.main.bounds.width) * (50 / 300))
    var body : some View {
        Image("108")
        .resizable()
        .scaledToFill()
        .frame(width: self.Width, height: self.Height, alignment: .center)
        .clipped()
        .clipShape(Capsule())
        
    }
}



struct Data {
    var id : String
    var discription : String
    var reference : String /// reference for  the next view to make a async request. What ever Place Here has to be able to make an async requestt
    var immagienReference : String
    
}










///// Genre One :
struct GenreOneTitleViewAll : View {
    var TitoloText : String = "Great Stories"
    var ViewAllRef : String = "108"
    var ArrowRef : String =  "108"
    var ViewAllSizeWidth : CGFloat = CGFloat((CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))) * (16.0 / 9.0))
    var ArrowSize : CGFloat =  CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))
    
    var body : some View{
        HStack{
        Text(self.TitoloText)
            .font(Font(StateSingleton.share.FontType(5, 16)))
            .foregroundColor(Color(StateSingleton.share.SubtitleFontColor))
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
        //Font Color and type end here
            Spacer()
            ViewMoreArrow()

        }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)/// end of Hstack brackets
        
    }// end of body brackets
}
struct GenreOne : View{
    @State private var presentPreviewContent = false
    var AddToMyListWidth : CGFloat = CGFloat(UIScreen.main.bounds.width * CGFloat(0.055))
    var MainImageWidth = CGFloat(Constant.share.Width * (21 / 30))
    var MainImageHeight = CGFloat((Constant.share.Width * (21 / 30)) * (1.4444))
    var CornerRadiusForViewSet : CGFloat = CGFloat(28.0)
    var Data = [TopViewStructure(Titolo: "Boy At Sea", Immagine: "Boy", Artistas: "Rosso Leo", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Adventure, Existentialism, WaterColor, Man vs Nature" , CreatorsImage : "1")
    ,
                TopViewStructure(Titolo: "Mountain View", Immagine: "1", Artistas: "Lisa Lang", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Adventure, Existentialism, WaterColor, Man vs Nature", CreatorsImage : "2")
    ,
                TopViewStructure(Titolo: "Spider-Man", Immagine: "2", Artistas: "Steve Dicko", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Altruism, Moral Objectivism, Man vs Man" , CreatorsImage : "3")
    ,
                TopViewStructure(Titolo: "Home Sick", Immagine: "3", Artistas: "Jessie Sharp", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Slice Of Life, Loniness, Indivdualism, Graphic Gradients", CreatorsImage: "4")
    ,
                TopViewStructure(Titolo: "Old Days", Immagine: "108", Artistas: "Marydith Martin", InfoRefference: "", ContentReffernce: "", ThisRefference : "" ,   Genres: "Adventure, Family, Pastels, Man vs Nature",  CreatorsImage : "5")
        
    ]
var body : some View{
    ScrollView(.horizontal , showsIndicators: false){
        HStack(spacing : StateSingleton.share.PaddingFromTheLeadingEdge){
            ForEach(Data) {data in
                HStack{
                    ZStack{
                       // SquareTab().fill(Color.black).frame(width : self.MainImageWidthAndHeight, height : self.MainImageWidthAndHeight , alignment : .top).cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                    ZStack{
                    /// IMAGE
                        HStack(alignment: .center){
                        Button(action : {
                       // PreviewContent(ImmageRefference: data.CopetinaImmagine , TitoloRefference: data.Titolo , ArtistaRefference: data.Artistas)
                            
                            
                            StateSingleton.share.PassingDataBetweenViews(Image: data.Immagine, Title: data.Titolo, Artists: data.Artistas, ArtistaImage: data.CreatorsImage)
                            self.presentPreviewContent.toggle()
                            //Home()
                        }){
                            
                            
                            Image(data.Immagine)// has the Id I have to loop through
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.top)
                            .frame(width : self.MainImageWidth, height : self.MainImageHeight , alignment : .top)
                            .clipped()
                            .cornerRadius(CGFloat(28.0))
                                //.shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                        }.sheet(isPresented: self.$presentPreviewContent ){
                           
                            PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                            }// end of buton modifier brakets
                        }.frame(width : CGFloat(self.MainImageWidth + StateSingleton.share.PaddingFromTheLeadingEdge), height :CGFloat(self.MainImageHeight + StateSingleton.share.PaddingFromTheLeadingEdge) , alignment : .bottom)//.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// end of zstack brackets
                    /// END OF IMAGE
                        
                        VStack(alignment : .leading){// to push everything down
                        Spacer()// the spacer pushes everything down
                        HStack(alignment: .bottom){
                        VStack(alignment : .leading , spacing : 3.0){
                                Button(action : {
                                    // segue to summary and info view on this content
                                }){
                                    Text(data.Titolo)
                                    .font(Font(StateSingleton.share.FontType(5, CGFloat(20.0))))
                                    .foregroundColor(Color.white)
                                    
                                    
                                }// end of actio button fot titolo
                            Text("By: \(data.Artistas)")
                                    .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                                    .foregroundColor(Color(StateSingleton.share.SeventyFivePercentWhite))
                            }// V Stack : with titolo and artistas
                            
                        Spacer()// to distribute the objects out in the view
                    HStack(spacing : 5.0){// need to have an if conditional statement
                        Button(action : {
                            //segue to summary and info view on this content
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        
                        Button(action: {
                            // add to my list functionality which means that it will have to store the
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        }.padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack : holding info and add to my list buttons
                        
                        }.frame(width : self.MainImageWidth , alignment : .bottom).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)//Hstack in zstack:             holding the titolo, artistas, add to my list, and info button
                        
                            Text("Tags : \(data.Genres)")
                            .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                            .foregroundColor(Color(StateSingleton.share.FiftyPercentWhite))
                            .lineLimit(1)
                            .frame(width : CGFloat(self.MainImageWidth - StateSingleton.share.PaddingFromTheLeadingEdge), alignment : .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
                            
                            
                        }.padding(.bottom, StateSingleton.share.PaddingFromTheLeadingEdge)// VStack to push all objects down to the bottom of the frame that are in the artista, titolo, info, and add to my list
                    }.frame(width : CGFloat(self.MainImageWidth), height :CGFloat(self.MainImageHeight) , alignment : .bottom)//ZStack in Hstack
                }// final ZStack Braket for shadow under the entire set of buttons
                    
                }//HStack Bracket after the geometry reader and for each loop
                

                }//                 FOR EACH LOOP
        }.padding([.leading , .trailing], StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack in scrollView
        }.shadow(color: Color(StateSingleton.share.TwentieFivePercentBlack), radius: CGFloat(20.0), x: CGFloat(3.0), y: CGFloat(15.0))// SCROLL VIEW
    }//                             BODY
}//                                  STRUCT


















/////GenreTwo
struct GenreTwoTitleViewAll : View {
    var TitoloText : String = "Great Stories"
    var ViewAllRef : String = "108"
    var ArrowRef : String =  "108"
    var ViewAllSizeWidth : CGFloat = CGFloat((CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))) * (16.0 / 9.0))
    var ArrowSize : CGFloat =  CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))
    
    var body : some View{
        HStack{
        Text(self.TitoloText)
            .font(Font(StateSingleton.share.FontType(5, 16)))
            .foregroundColor(Color(StateSingleton.share.SubtitleFontColor))
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
        //Font Color and type end here
            Spacer()
            ViewMoreArrow()

        }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)/// end of Hstack brackets
        
    }// end of body brackets
}
struct GenreTwo : View{
    @State private var presentPreviewContent = false
    var AddToMyListWidth : CGFloat = CGFloat(UIScreen.main.bounds.width * CGFloat(0.055))
    var MainImageWidth = CGFloat(Constant.share.Width * (21 / 30))
    var MainImageHeight = CGFloat((Constant.share.Width * (21 / 30)) * (1.4444))
    var CornerRadiusForViewSet : CGFloat = CGFloat(28.0)
    var Data = [TopViewStructure(Titolo: "Boy At Sea", Immagine: "Boy", Artistas: "Rosso Leo", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Adventure, Existentialism, WaterColor, Man vs Nature" , CreatorsImage : "1")
    ,
                TopViewStructure(Titolo: "Mountain View", Immagine: "1", Artistas: "Lisa Lang", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Adventure, Existentialism, WaterColor, Man vs Nature", CreatorsImage : "2")
    ,
                TopViewStructure(Titolo: "Spider-Man", Immagine: "2", Artistas: "Steve Dicko", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Altruism, Moral Objectivism, Man vs Man" , CreatorsImage : "3")
    ,
                TopViewStructure(Titolo: "Home Sick", Immagine: "3", Artistas: "Jessie Sharp", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Slice Of Life, Loniness, Indivdualism, Graphic Gradients", CreatorsImage: "4")
    ,
                TopViewStructure(Titolo: "Old Days", Immagine: "108", Artistas: "Marydith Martin", InfoRefference: "", ContentReffernce: "", ThisRefference : "" ,   Genres: "Adventure, Family, Pastels, Man vs Nature",  CreatorsImage : "5")
        
    ]
var body : some View{
    ScrollView(.horizontal , showsIndicators: false){
        HStack(spacing : StateSingleton.share.PaddingFromTheLeadingEdge){
            ForEach(Data) {data in
              //  GeometryReader{ geom in
                HStack{
                    ZStack{
                       // SquareTab().fill(Color.black).frame(width : self.MainImageWidthAndHeight, height : self.MainImageWidthAndHeight , alignment : .top).cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                    ZStack{
                    /// IMAGE
                        HStack(alignment: .center){
                        Button(action : {
                       // PreviewContent(ImmageRefference: data.CopetinaImmagine , TitoloRefference: data.Titolo , ArtistaRefference: data.Artistas)
                            
                            
                            StateSingleton.share.PassingDataBetweenViews(Image: data.Immagine, Title: data.Titolo, Artists: data.Artistas, ArtistaImage: data.CreatorsImage)
                            self.presentPreviewContent.toggle()
                            //Home()
                        }){
                            
                            
                            Image(data.Immagine)// has the Id I have to loop through
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.top)
                            .frame(width : self.MainImageWidth, height : self.MainImageHeight , alignment : .top)
                            .clipped()
                            .cornerRadius(CGFloat(28.0))
                                //.shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                        }.sheet(isPresented: self.$presentPreviewContent ){
                           
                            PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                            }// end of buton modifier brakets
                        }.frame(width : CGFloat(self.MainImageWidth + StateSingleton.share.PaddingFromTheLeadingEdge), height :CGFloat(self.MainImageHeight + StateSingleton.share.PaddingFromTheLeadingEdge) , alignment : .bottom)//.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// end of zstack brackets
                    /// END OF IMAGE
                        
                        VStack(alignment : .leading){// to push everything down
                        Spacer()// the spacer pushes everything down
                        HStack(alignment: .bottom){
                        VStack(alignment : .leading , spacing : 3.0){
                                Button(action : {
                                    // segue to summary and info view on this content
                                }){
                                    Text(data.Titolo)
                                    .font(Font(StateSingleton.share.FontType(5, CGFloat(20.0))))
                                    .foregroundColor(Color.white)
                                    
                                    
                                }// end of actio button fot titolo
                            Text("By: \(data.Artistas)")
                                    .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                                    .foregroundColor(Color(StateSingleton.share.SeventyFivePercentWhite))
                            }// V Stack : with titolo and artistas
                            
                        Spacer()// to distribute the objects out in the view
                    HStack(spacing : 5.0){// need to have an if conditional statement
                        Button(action : {
                            //segue to summary and info view on this content
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        
                        Button(action: {
                            // add to my list functionality which means that it will have to store the
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        }.padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack : holding info and add to my list buttons
                        
                        }.frame(width : self.MainImageWidth , alignment : .bottom).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)//Hstack in zstack:             holding the titolo, artistas, add to my list, and info button
                        
                            Text("Tags : \(data.Genres)")
                            .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                            .foregroundColor(Color(StateSingleton.share.FiftyPercentWhite))
                            .lineLimit(1)
                            .frame(width : CGFloat(self.MainImageWidth - StateSingleton.share.PaddingFromTheLeadingEdge), alignment : .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
                            
                            
                        }.padding(.bottom, StateSingleton.share.PaddingFromTheLeadingEdge)// VStack to push all objects down to the bottom of the frame that are in the artista, titolo, info, and add to my list
                    }.frame(width : CGFloat(self.MainImageWidth), height :CGFloat(self.MainImageHeight) , alignment : .bottom)//ZStack in Hstack
                }//.cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))/// final ZStack Braket for shadow under the entire set of buttons
                    
                }//HStack Bracket after the geometry reader and for each loop
                
                // }//             GEOMETRY READER
                }//                 FOR EACH LOOP
        }.padding([.leading , .trailing], StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack in scrollView
        }.shadow(color: Color(StateSingleton.share.TwentieFivePercentBlack), radius: CGFloat(20.0), x: CGFloat(3.0), y: CGFloat(15.0))// SCROLL VIEW
    }//                             BODY
}//                                  STRUCT















///Genre Three :
struct GenreThreeTitleViewAll : View {
    var TitoloText : String = "Great Stories"
    var ViewAllRef : String = "108"
    var ArrowRef : String =  "108"
    var ViewAllSizeWidth : CGFloat = CGFloat((CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))) * (16.0 / 9.0))
    var ArrowSize : CGFloat =  CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))
    
    var body : some View{
        HStack{
        Text(self.TitoloText)
            .font(Font(StateSingleton.share.FontType(5, 16)))
            .foregroundColor(Color(StateSingleton.share.SubtitleFontColor))
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
        //Font Color and type end here
            Spacer()
            ViewMoreArrow()

        }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)/// end of Hstack brackets
        
    }// end of body brackets
}
struct GenreThree : View{
    @State private var presentPreviewContent = false
    var AddToMyListWidth : CGFloat = CGFloat(UIScreen.main.bounds.width * CGFloat(0.055))
    var MainImageWidth = CGFloat(Constant.share.Width * (21 / 30))
    var MainImageHeight = CGFloat((Constant.share.Width * (21 / 30)) * (1.4444))
    var CornerRadiusForViewSet : CGFloat = CGFloat(28.0)
    var Data = [TopViewStructure(Titolo: "Boy At Sea", Immagine: "Boy", Artistas: "Rosso Leo", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Adventure, Existentialism, WaterColor, Man vs Nature" , CreatorsImage : "1")
    ,
                TopViewStructure(Titolo: "Mountain View", Immagine: "1", Artistas: "Lisa Lang", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Adventure, Existentialism, WaterColor, Man vs Nature", CreatorsImage : "2")
    ,
                TopViewStructure(Titolo: "Spider-Man", Immagine: "2", Artistas: "Steve Dicko", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Altruism, Moral Objectivism, Man vs Man" , CreatorsImage : "3")
    ,
                TopViewStructure(Titolo: "Home Sick", Immagine: "3", Artistas: "Jessie Sharp", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Slice Of Life, Loniness, Indivdualism, Graphic Gradients", CreatorsImage: "4")
    ,
                TopViewStructure(Titolo: "Old Days", Immagine: "108", Artistas: "Marydith Martin", InfoRefference: "", ContentReffernce: "", ThisRefference : "" ,   Genres: "Adventure, Family, Pastels, Man vs Nature",  CreatorsImage : "5")
        
    ]
var body : some View{
    ScrollView(.horizontal , showsIndicators: false){
        HStack(spacing : StateSingleton.share.PaddingFromTheLeadingEdge){
            ForEach(Data) {data in
              //  GeometryReader{ geom in
                HStack{
                    ZStack{
                       // SquareTab().fill(Color.black).frame(width : self.MainImageWidthAndHeight, height : self.MainImageWidthAndHeight , alignment : .top).cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                    ZStack{
                    /// IMAGE
                        HStack(alignment: .center){
                        Button(action : {
                       // PreviewContent(ImmageRefference: data.CopetinaImmagine , TitoloRefference: data.Titolo , ArtistaRefference: data.Artistas)
                            
                            
                            StateSingleton.share.PassingDataBetweenViews(Image: data.Immagine, Title: data.Titolo, Artists: data.Artistas, ArtistaImage: data.CreatorsImage)
                            self.presentPreviewContent.toggle()
                            //Home()
                        }){
                            
                            
                            Image(data.Immagine)// has the Id I have to loop through
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.top)
                            .frame(width : self.MainImageWidth, height : self.MainImageHeight , alignment : .top)
                            .clipped()
                            .cornerRadius(CGFloat(28.0))
                                //.shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                        }.sheet(isPresented: self.$presentPreviewContent ){
                           
                            PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                            }// end of buton modifier brakets
                        }.frame(width : CGFloat(self.MainImageWidth + StateSingleton.share.PaddingFromTheLeadingEdge), height :CGFloat(self.MainImageHeight + StateSingleton.share.PaddingFromTheLeadingEdge) , alignment : .bottom)//.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// end of zstack brackets
                    /// END OF IMAGE
                        
                        VStack(alignment : .leading){// to push everything down
                        Spacer()// the spacer pushes everything down
                        HStack(alignment: .bottom){
                        VStack(alignment : .leading , spacing : 3.0){
                                Button(action : {
                                    // segue to summary and info view on this content
                                }){
                                    Text(data.Titolo)
                                    .font(Font(StateSingleton.share.FontType(5, CGFloat(20.0))))
                                    .foregroundColor(Color.white)
                                    
                                    
                                }// end of actio button fot titolo
                            Text("By: \(data.Artistas)")
                                    .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                                    .foregroundColor(Color(StateSingleton.share.SeventyFivePercentWhite))
                            }// V Stack : with titolo and artistas
                            
                        Spacer()// to distribute the objects out in the view
                    HStack(spacing : 5.0){// need to have an if conditional statement
                        Button(action : {
                            //segue to summary and info view on this content
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        
                        Button(action: {
                            // add to my list functionality which means that it will have to store the
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        }.padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack : holding info and add to my list buttons
                        
                        }.frame(width : self.MainImageWidth , alignment : .bottom).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)//Hstack in zstack:             holding the titolo, artistas, add to my list, and info button
                        
                            Text("Tags : \(data.Genres)")
                            .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                            .foregroundColor(Color(StateSingleton.share.FiftyPercentWhite))
                            .lineLimit(1)
                            .frame(width : CGFloat(self.MainImageWidth - StateSingleton.share.PaddingFromTheLeadingEdge), alignment : .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
                            
                            
                        }.padding(.bottom, StateSingleton.share.PaddingFromTheLeadingEdge)// VStack to push all objects down to the bottom of the frame that are in the artista, titolo, info, and add to my list
                    }.frame(width : CGFloat(self.MainImageWidth), height :CGFloat(self.MainImageHeight) , alignment : .bottom)//ZStack in Hstack
                }//.cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))/// final ZStack Braket for shadow under the entire set of buttons
                    
                }//HStack Bracket after the geometry reader and for each loop
                
                // }//             GEOMETRY READER
                }//                 FOR EACH LOOP
        }.padding([.leading , .trailing], StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack in scrollView
        }.shadow(color: Color(StateSingleton.share.TwentieFivePercentBlack), radius: CGFloat(20.0), x: CGFloat(3.0), y: CGFloat(15.0))// SCROLL VIEW
    }//                             BODY
}//                                  STRUCT













///Genre Four
struct GenreFourTitleViewAll : View {
    var TitoloText : String = "Great Stories"
    var ViewAllRef : String = "108"
    var ArrowRef : String =  "108"
    var ViewAllSizeWidth : CGFloat = CGFloat((CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))) * (16.0 / 9.0))
    var ArrowSize : CGFloat =  CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))
    
    var body : some View{
        HStack{
        Text(self.TitoloText)
            .font(Font(StateSingleton.share.FontType(5, 16)))
            .foregroundColor(Color(StateSingleton.share.SubtitleFontColor))
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
        //Font Color and type end here
            Spacer()
            ViewMoreArrow()

        }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)/// end of Hstack brackets
        
    }// end of body brackets
}
struct GenreFour : View{
    @State private var presentPreviewContent = false
    var AddToMyListWidth : CGFloat = CGFloat(UIScreen.main.bounds.width * CGFloat(0.055))
    var MainImageWidth = CGFloat(Constant.share.Width * (21 / 30))
    var MainImageHeight = CGFloat((Constant.share.Width * (21 / 30)) * (1.4444))
    var CornerRadiusForViewSet : CGFloat = CGFloat(28.0)
    var Data = [TopViewStructure(Titolo: "Boy At Sea", Immagine: "Boy", Artistas: "Rosso Leo", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Adventure, Existentialism, WaterColor, Man vs Nature" , CreatorsImage : "1")
    ,
                TopViewStructure(Titolo: "Mountain View", Immagine: "1", Artistas: "Lisa Lang", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Adventure, Existentialism, WaterColor, Man vs Nature", CreatorsImage : "2")
    ,
                TopViewStructure(Titolo: "Spider-Man", Immagine: "2", Artistas: "Steve Dicko", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Altruism, Moral Objectivism, Man vs Man" , CreatorsImage : "3")
    ,
                TopViewStructure(Titolo: "Home Sick", Immagine: "3", Artistas: "Jessie Sharp", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Slice Of Life, Loniness, Indivdualism, Graphic Gradients", CreatorsImage: "4")
    ,
                TopViewStructure(Titolo: "Old Days", Immagine: "108", Artistas: "Marydith Martin", InfoRefference: "", ContentReffernce: "", ThisRefference : "" ,   Genres: "Adventure, Family, Pastels, Man vs Nature",  CreatorsImage : "5")
        
    ]
var body : some View{
    ScrollView(.horizontal , showsIndicators: false){
        HStack(spacing : StateSingleton.share.PaddingFromTheLeadingEdge){
            ForEach(Data) {data in
              //  GeometryReader{ geom in
                HStack{
                    ZStack{
                       // SquareTab().fill(Color.black).frame(width : self.MainImageWidthAndHeight, height : self.MainImageWidthAndHeight , alignment : .top).cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                    ZStack{
                    /// IMAGE
                        HStack(alignment: .center){
                        Button(action : {
                       // PreviewContent(ImmageRefference: data.CopetinaImmagine , TitoloRefference: data.Titolo , ArtistaRefference: data.Artistas)
                            
                            
                            StateSingleton.share.PassingDataBetweenViews(Image: data.Immagine, Title: data.Titolo, Artists: data.Artistas, ArtistaImage: data.CreatorsImage)
                            self.presentPreviewContent.toggle()
                            //Home()
                        }){
                            
                            
                            Image(data.Immagine)// has the Id I have to loop through
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.top)
                            .frame(width : self.MainImageWidth, height : self.MainImageHeight , alignment : .top)
                            .clipped()
                            .cornerRadius(CGFloat(28.0))
                                //.shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                        }.sheet(isPresented: self.$presentPreviewContent ){
                           
                            PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                            }// end of buton modifier brakets
                        }.frame(width : CGFloat(self.MainImageWidth + StateSingleton.share.PaddingFromTheLeadingEdge), height :CGFloat(self.MainImageHeight + StateSingleton.share.PaddingFromTheLeadingEdge) , alignment : .bottom)//.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// end of zstack brackets
                    /// END OF IMAGE
                        
                        VStack(alignment : .leading){// to push everything down
                        Spacer()// the spacer pushes everything down
                        HStack(alignment: .bottom){
                        VStack(alignment : .leading , spacing : 3.0){
                                Button(action : {
                                    // segue to summary and info view on this content
                                }){
                                    Text(data.Titolo)
                                    .font(Font(StateSingleton.share.FontType(5, CGFloat(20.0))))
                                    .foregroundColor(Color.white)
                                    
                                    
                                }// end of actio button fot titolo
                            Text("By: \(data.Artistas)")
                                    .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                                    .foregroundColor(Color(StateSingleton.share.SeventyFivePercentWhite))
                            }// V Stack : with titolo and artistas
                            
                        Spacer()// to distribute the objects out in the view
                    HStack(spacing : 5.0){// need to have an if conditional statement
                        Button(action : {
                            //segue to summary and info view on this content
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        
                        Button(action: {
                            // add to my list functionality which means that it will have to store the
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        }.padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack : holding info and add to my list buttons
                        
                        }.frame(width : self.MainImageWidth , alignment : .bottom).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)//Hstack in zstack:             holding the titolo, artistas, add to my list, and info button
                        
                            Text("Tags : \(data.Genres)")
                            .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                            .foregroundColor(Color(StateSingleton.share.FiftyPercentWhite))
                            .lineLimit(1)
                            .frame(width : CGFloat(self.MainImageWidth - StateSingleton.share.PaddingFromTheLeadingEdge), alignment : .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
                            
                            
                        }.padding(.bottom, StateSingleton.share.PaddingFromTheLeadingEdge)// VStack to push all objects down to the bottom of the frame that are in the artista, titolo, info, and add to my list
                    }.frame(width : CGFloat(self.MainImageWidth), height :CGFloat(self.MainImageHeight) , alignment : .bottom)//ZStack in Hstack
                }//.cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))/// final ZStack Braket for shadow under the entire set of buttons
                    
                }//HStack Bracket after the geometry reader and for each loop
                
                // }//             GEOMETRY READER
                }//                 FOR EACH LOOP
        }.padding([.leading , .trailing], StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack in scrollView
        }.shadow(color: Color(StateSingleton.share.TwentieFivePercentBlack), radius: CGFloat(20.0), x: CGFloat(3.0), y: CGFloat(15.0))// SCROLL VIEW
    }//                             BODY
}//                                  STRUCT














///GenreFive
struct GenreFiveTitleViewAll : View {
    var TitoloText : String = "Great Stories"
    var ViewAllRef : String = "108"
    var ArrowRef : String =  "108"
    var ViewAllSizeWidth : CGFloat = CGFloat((CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))) * (16.0 / 9.0))
    var ArrowSize : CGFloat =  CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))
    
    var body : some View{
        HStack{
        Text(self.TitoloText)
            .font(Font(StateSingleton.share.FontType(5, 16)))
            .foregroundColor(Color(StateSingleton.share.SubtitleFontColor))
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
        //Font Color and type end here
            Spacer()
            ViewMoreArrow()

        }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)/// end of Hstack brackets
        
    }// end of body brackets
}
struct GenreFive : View{
    @State private var presentPreviewContent = false
    var AddToMyListWidth : CGFloat = CGFloat(UIScreen.main.bounds.width * CGFloat(0.055))
    var MainImageWidth = CGFloat(Constant.share.Width * (21 / 30))
    var MainImageHeight = CGFloat((Constant.share.Width * (21 / 30)) * (1.4444))
    var CornerRadiusForViewSet : CGFloat = CGFloat(28.0)
    var Data = [TopViewStructure(Titolo: "Boy At Sea", Immagine: "Boy", Artistas: "Rosso Leo", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Adventure, Existentialism, WaterColor, Man vs Nature" , CreatorsImage : "1")
    ,
                TopViewStructure(Titolo: "Mountain View", Immagine: "1", Artistas: "Lisa Lang", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Adventure, Existentialism, WaterColor, Man vs Nature", CreatorsImage : "2")
    ,
                TopViewStructure(Titolo: "Spider-Man", Immagine: "2", Artistas: "Steve Dicko", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Altruism, Moral Objectivism, Man vs Man" , CreatorsImage : "3")
    ,
                TopViewStructure(Titolo: "Home Sick", Immagine: "3", Artistas: "Jessie Sharp", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Slice Of Life, Loniness, Indivdualism, Graphic Gradients", CreatorsImage: "4")
    ,
                TopViewStructure(Titolo: "Old Days", Immagine: "108", Artistas: "Marydith Martin", InfoRefference: "", ContentReffernce: "", ThisRefference : "" ,   Genres: "Adventure, Family, Pastels, Man vs Nature",  CreatorsImage : "5")
        
    ]
var body : some View{
    ScrollView(.horizontal , showsIndicators: false){
        HStack(spacing : StateSingleton.share.PaddingFromTheLeadingEdge){
            ForEach(Data) {data in
              //  GeometryReader{ geom in
                HStack{
                    ZStack{
                       // SquareTab().fill(Color.black).frame(width : self.MainImageWidthAndHeight, height : self.MainImageWidthAndHeight , alignment : .top).cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                    ZStack{
                    /// IMAGE
                        HStack(alignment: .center){
                        Button(action : {
                       // PreviewContent(ImmageRefference: data.CopetinaImmagine , TitoloRefference: data.Titolo , ArtistaRefference: data.Artistas)
                            
                            
                            StateSingleton.share.PassingDataBetweenViews(Image: data.Immagine, Title: data.Titolo, Artists: data.Artistas, ArtistaImage: data.CreatorsImage)
                            self.presentPreviewContent.toggle()
                            //Home()
                        }){
                            
                            
                            Image(data.Immagine)// has the Id I have to loop through
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.top)
                            .frame(width : self.MainImageWidth, height : self.MainImageHeight , alignment : .top)
                            .clipped()
                            .cornerRadius(CGFloat(28.0))
                                //.shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                        }.sheet(isPresented: self.$presentPreviewContent ){
                           
                            PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                            }// end of buton modifier brakets
                        }.frame(width : CGFloat(self.MainImageWidth + StateSingleton.share.PaddingFromTheLeadingEdge), height :CGFloat(self.MainImageHeight + StateSingleton.share.PaddingFromTheLeadingEdge) , alignment : .bottom)//.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// end of zstack brackets
                    /// END OF IMAGE
                        
                        VStack(alignment : .leading){// to push everything down
                        Spacer()// the spacer pushes everything down
                        HStack(alignment: .bottom){
                        VStack(alignment : .leading , spacing : 3.0){
                                Button(action : {
                                    // segue to summary and info view on this content
                                }){
                                    Text(data.Titolo)
                                    .font(Font(StateSingleton.share.FontType(5, CGFloat(20.0))))
                                    .foregroundColor(Color.white)
                                    
                                    
                                }// end of actio button fot titolo
                            Text("By: \(data.Artistas)")
                                    .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                                    .foregroundColor(Color(StateSingleton.share.SeventyFivePercentWhite))
                            }// V Stack : with titolo and artistas
                            
                        Spacer()// to distribute the objects out in the view
                    HStack(spacing : 5.0){// need to have an if conditional statement
                        Button(action : {
                            //segue to summary and info view on this content
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        
                        Button(action: {
                            // add to my list functionality which means that it will have to store the
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        }.padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack : holding info and add to my list buttons
                        
                        }.frame(width : self.MainImageWidth , alignment : .bottom).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)//Hstack in zstack:             holding the titolo, artistas, add to my list, and info button
                        
                            Text("Tags : \(data.Genres)")
                            .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                            .foregroundColor(Color(StateSingleton.share.FiftyPercentWhite))
                            .lineLimit(1)
                            .frame(width : CGFloat(self.MainImageWidth - StateSingleton.share.PaddingFromTheLeadingEdge), alignment : .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
                            
                            
                        }.padding(.bottom, StateSingleton.share.PaddingFromTheLeadingEdge)// VStack to push all objects down to the bottom of the frame that are in the artista, titolo, info, and add to my list
                    }.frame(width : CGFloat(self.MainImageWidth), height :CGFloat(self.MainImageHeight) , alignment : .bottom)//ZStack in Hstack
                }//.cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))/// final ZStack Braket for shadow under the entire set of buttons
                    
                }//HStack Bracket after the geometry reader and for each loop
                
                // }//             GEOMETRY READER
                }//                 FOR EACH LOOP
        }.padding([.leading , .trailing], StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack in scrollView
        }.shadow(color: Color(StateSingleton.share.TwentieFivePercentBlack), radius: CGFloat(20.0), x: CGFloat(3.0), y: CGFloat(15.0))// SCROLL VIEW
    }//                             BODY
}//                                  STRUCT















///GenreSix
struct GenreSixTitleViewAll : View {
    var TitoloText : String = "Great Stories"
    var ViewAllRef : String = "108"
    var ArrowRef : String =  "108"
    var ViewAllSizeWidth : CGFloat = CGFloat((CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))) * (16.0 / 9.0))
    var ArrowSize : CGFloat =  CGFloat(UIScreen.main.bounds.width * CGFloat(0.06))
    
    var body : some View{
        HStack{
        Text(self.TitoloText)
            .font(Font(StateSingleton.share.FontType(5, 16)))
            .foregroundColor(Color(StateSingleton.share.SubtitleFontColor))
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
        //Font Color and type end here
            Spacer()
            ViewMoreArrow()

        }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)/// end of Hstack brackets
        
    }// end of body brackets
}
struct GenreSix : View{
    @State private var presentPreviewContent = false
    var AddToMyListWidth : CGFloat = CGFloat(UIScreen.main.bounds.width * CGFloat(0.055))
    var MainImageWidth = CGFloat(Constant.share.Width * (21 / 30))
    var MainImageHeight = CGFloat((Constant.share.Width * (21 / 30)) * (1.4444))
    var CornerRadiusForViewSet : CGFloat = CGFloat(28.0)
    var Data = [TopViewStructure(Titolo: "Boy At Sea", Immagine: "Boy", Artistas: "Rosso Leo", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Adventure, Existentialism, WaterColor, Man vs Nature" , CreatorsImage : "1")
    ,
                TopViewStructure(Titolo: "Mountain View", Immagine: "1", Artistas: "Lisa Lang", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Adventure, Existentialism, WaterColor, Man vs Nature", CreatorsImage : "2")
    ,
                TopViewStructure(Titolo: "Spider-Man", Immagine: "2", Artistas: "Steve Dicko", InfoRefference: "", ContentReffernce: "", ThisRefference : "", Genres : "Action, Altruism, Moral Objectivism, Man vs Man" , CreatorsImage : "3")
    ,
                TopViewStructure(Titolo: "Home Sick", Immagine: "3", Artistas: "Jessie Sharp", InfoRefference: "", ContentReffernce: "" , ThisRefference : "", Genres : "Slice Of Life, Loniness, Indivdualism, Graphic Gradients", CreatorsImage: "4")
    ,
                TopViewStructure(Titolo: "Old Days", Immagine: "108", Artistas: "Marydith Martin", InfoRefference: "", ContentReffernce: "", ThisRefference : "" ,   Genres: "Adventure, Family, Pastels, Man vs Nature",  CreatorsImage : "5")
        
    ]
var body : some View{
    ScrollView(.horizontal , showsIndicators: false){
        HStack(spacing : StateSingleton.share.PaddingFromTheLeadingEdge){
            ForEach(Data) {data in
              //  GeometryReader{ geom in
                HStack{
                    ZStack{
                       // SquareTab().fill(Color.black).frame(width : self.MainImageWidthAndHeight, height : self.MainImageWidthAndHeight , alignment : .top).cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                    ZStack{
                    /// IMAGE
                        HStack(alignment: .center){
                        Button(action : {
                       // PreviewContent(ImmageRefference: data.CopetinaImmagine , TitoloRefference: data.Titolo , ArtistaRefference: data.Artistas)
                            
                            
                            StateSingleton.share.PassingDataBetweenViews(Image: data.Immagine, Title: data.Titolo, Artists: data.Artistas, ArtistaImage: data.CreatorsImage)
                            self.presentPreviewContent.toggle()
                            //Home()
                        }){
                            
                            
                            Image(data.Immagine)// has the Id I have to loop through
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.top)
                            .frame(width : self.MainImageWidth, height : self.MainImageHeight , alignment : .top)
                            .clipped()
                            .cornerRadius(CGFloat(28.0))
                                //.shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))
                        }.sheet(isPresented: self.$presentPreviewContent ){
                           
                            PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                            }// end of buton modifier brakets
                        }.frame(width : CGFloat(self.MainImageWidth + StateSingleton.share.PaddingFromTheLeadingEdge), height :CGFloat(self.MainImageHeight + StateSingleton.share.PaddingFromTheLeadingEdge) , alignment : .bottom)//.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// end of zstack brackets
                    /// END OF IMAGE
                        
                        VStack(alignment : .leading){// to push everything down
                        Spacer()// the spacer pushes everything down
                        HStack(alignment: .bottom){
                        VStack(alignment : .leading , spacing : 3.0){
                                Button(action : {
                                    // segue to summary and info view on this content
                                }){
                                    Text(data.Titolo)
                                    .font(Font(StateSingleton.share.FontType(5, CGFloat(20.0))))
                                    .foregroundColor(Color.white)
                                    
                                    
                                }// end of actio button fot titolo
                            Text("By: \(data.Artistas)")
                                    .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                                    .foregroundColor(Color(StateSingleton.share.SeventyFivePercentWhite))
                            }// V Stack : with titolo and artistas
                            
                        Spacer()// to distribute the objects out in the view
                    HStack(spacing : 5.0){// need to have an if conditional statement
                        Button(action : {
                            //segue to summary and info view on this content
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        
                        Button(action: {
                            // add to my list functionality which means that it will have to store the
                            }){
                                Image("AddToMyList")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: self.AddToMyListWidth, height: self.AddToMyListWidth)
                            }
                        }.padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack : holding info and add to my list buttons
                        
                        }.frame(width : self.MainImageWidth , alignment : .bottom).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)//Hstack in zstack:             holding the titolo, artistas, add to my list, and info button
                        
                            Text("Tags : \(data.Genres)")
                            .font(Font(StateSingleton.share.FontType(4, CGFloat(14.0))))
                            .foregroundColor(Color(StateSingleton.share.FiftyPercentWhite))
                            .lineLimit(1)
                            .frame(width : CGFloat(self.MainImageWidth - StateSingleton.share.PaddingFromTheLeadingEdge), alignment : .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
                            
                            
                        }.padding(.bottom, StateSingleton.share.PaddingFromTheLeadingEdge)// VStack to push all objects down to the bottom of the frame that are in the artista, titolo, info, and add to my list
                    }.frame(width : CGFloat(self.MainImageWidth), height :CGFloat(self.MainImageHeight) , alignment : .bottom)//ZStack in Hstack
                }//.cornerRadius(self.CornerRadiusForViewSet).shadow(color: Color(StateSingleton.share.FiftyPercentBlack), radius: CGFloat(15.0), x: CGFloat(3.0), y: CGFloat(2.0))/// final ZStack Braket for shadow under the entire set of buttons
                    
                }//HStack Bracket after the geometry reader and for each loop
                
                // }//             GEOMETRY READER
                }//                 FOR EACH LOOP
        }.padding([.leading , .trailing], StateSingleton.share.PaddingFromTheLeadingEdge).buttonStyle(PlainButtonStyle())//HStack in scrollView
        }.shadow(color: Color(StateSingleton.share.TwentieFivePercentBlack), radius: CGFloat(20.0), x: CGFloat(3.0), y: CGFloat(15.0))// SCROLL VIEW
    }//                             BODY
}//                                  STRUCT

