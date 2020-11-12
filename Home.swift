//
//  Home.swift
//  
//
//  Created by Rabus Mccaleb on 8/11/20.
//
import Foundation
import SwiftUI
import FirebaseAuth
import Firebase
//import KingfisherSwiftUI
import struct Kingfisher.KFImage



struct Home: View {
    @State var ThereIsUnfinishedContent = BackendSingleton.share.ContinueContent()
    @ObservedObject var Home_StoryRepo = Home_StoryModelList()
//    @ObservedObject var Top_Three = topThreeRequest()
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    HomeStoryContent(ThereIsUnfinishedContent: self.ThereIsUnfinishedContent).edgesIgnoringSafeArea(.top)
                }

            }//ScrollView
        }.background(Color.white).edgesIgnoringSafeArea(.all)//ZStack
    }//body
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}





// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :
// Logo User Recommended : Logo User Recommended : Logo User Recommended :

struct HomeStoryContent : View {
    var ThereIsUnfinishedContent : Bool
    var body: some View{
        VStack(spacing : 0){
                LogoUserRecommended()
                ArtistContentInfoPlay()
                if(ThereIsUnfinishedContent == true){
                    ContinueWatching()
                }else{
                    HomeDiscoverView()
                }
            
            
                
                topThreeContent()
            
                HomeDiscoverView()
            
                HomeStory(CoverImage: "4", ArtistaProfileImage: "16", Title: "Fairy Fairy Beautiful", Artist: "Richard Dawson, Chirs Stiff", Tags: "Existential, Friendship, Creativity", StoryType: "Episode 2")
            
                HomeStory(CoverImage: "3", ArtistaProfileImage: "5", Title: "Girs Want To Have Fun", Artist: "Archie Goodwin", Tags: "Existential, Friendship, Creativity", StoryType: "Episode 9")

            }
    }
}

struct LogoUserRecommended: View {
    var CoverImageSrc = "6-1"
    var height = CGFloat(Constant.share.Height * (0.6))//60% of the screens height
    var OffsetTop = CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (-0.5))

    var body: some View{
//        GeometryReader{ Geom in
            ZStack{
                VStack{
                    RecomendedStory(CoverImageSrc: self.CoverImageSrc)
                    }.frame(width: Constant.share.Width, height: CGFloat( self.height), alignment: .top)//Vstack
                
                VStack{
                    LogoAndUser()
                }.frame(width: Constant.share.Width, height: self.height, alignment: .top)//Vstack

            }.frame(width: Constant.share.Width, height: self.height, alignment: .top).offset(x: 0, y: OffsetTop)//Zstack
      //  }//Geometry Reader
    }
}

struct topThreeContent : View {
    @ObservedObject private var TopThreeData = topThreeRequest()
    var body: some View{
        if TopThreeData.requestedDocData.count >= 3{
            VStack(){
                HomeStory(
                          CoverImage: "5", ArtistaProfileImage: "14",
                          Title: TopThreeData.requestedDocData[0].Title ,
                          Artist: TopThreeData.requestedDocData[0].Artists.description ,
                          Tags: TopThreeData.requestedDocData[0].Tags.description,
                          StoryType: TopThreeData.requestedDocData[0].StoryType,
                    Summary: TopThreeData.requestedDocData[0].Summary
                    
                )
            
                HomeStory(
                          CoverImage: "11",
                          ArtistaProfileImage: "3",
                          Title: TopThreeData.requestedDocData[1].Title ,
                          Artist: TopThreeData.requestedDocData[1].Artists.description ,
                          Tags: TopThreeData.requestedDocData[1].Tags.description,
                          StoryType: TopThreeData.requestedDocData[1].StoryType,
                    Summary: TopThreeData.requestedDocData[1].Summary
                )
            
                HomeStory(
                          CoverImage: "13",
                          ArtistaProfileImage: "1",
                          Title: TopThreeData.requestedDocData[2].Title ,
                          Artist: TopThreeData.requestedDocData[2].Artists.description ,
                          Tags: TopThreeData.requestedDocData[2].Tags.description,
                          StoryType: TopThreeData.requestedDocData[2].StoryType,
                    Summary: TopThreeData.requestedDocData[2].Summary
                )
            }
        }else{
            VStack(){
                HomeStory(CoverImage: "5", ArtistaProfileImage: "14", Title: "Scary Monster House", Artist: "Richard Dawson, Chirs Stiff", Tags: "Existential, Friendship, Creativity", StoryType: "Episode 2")
            
                HomeStory(CoverImage: "11", ArtistaProfileImage: "3", Title: "Old Lovers", Artist: "Archie Goodwin", Tags: "Existential, Friendship, Creativity", StoryType: "Episode 9")
            
                HomeStory(CoverImage: "13", ArtistaProfileImage: "1", Title: "Oh What A Wonderful World" , Artist: "Timothy Tyson, Charels Dickson", Tags: "Existential, Friendship, Creativity", StoryType: "Solo")
            }
        }
    }
}



//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
//Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User //Top Logo and User
struct LogoAndUser : View {
    var width = CGFloat(Constant.share.Width)// complete width of recommended story image
    var height = CGFloat(Constant.share.Height * (0.6))//60% of the screens... hight of recommended story image
    var TopContentHeight = CGFloat(Constant.share.Height * (1 / 14))
    var UserImageHeightAndWidth = CGFloat(Constant.share.Height * (10/300))
    var padding = CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (0.5))
    var ToddLogoText = "TODDLIT"
    
    var body : some View{
        ZStack{
            VStack{
                TranslucentUnderlay()
                Spacer()
            }.frame(width: self.width, height: self.height, alignment: .topLeading)// VStack
            VStack{
                HStack(alignment : .bottom){
                    ToddHomeLogo(ToddLogoText: self.ToddLogoText)
                    Spacer()
                    UserImageAndName().padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge)
                    
                }.offset(x: 0 , y: self.padding).frame(width: Constant.share.Width, height: self.TopContentHeight, alignment: .bottom)//Hstack
                Spacer()
            }.frame(width: self.width, height: self.height, alignment: .topLeading)// VStack
        }.frame(width: CGFloat(Constant.share.Width), height: CGFloat((Constant.share.Height * (1 / 14) + (StateSingleton.share.PaddingFromTheLeadingEdge))), alignment: .topLeading)//ZStack
    }//body viuew
}// LogoUserTab brackets



struct TranslucentUnderlay : View {
    var TopContentHeight = CGFloat(Constant.share.Height * (1 / 14))
    var padding = CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (1))
    var oppacity = 0.125
    var body: some View{
        Color
            .white
            .opacity(self.oppacity)
            .offset(x: 0 , y: CGFloat(Constant.share.SafeAreaTop * -1))
            .frame(width: Constant.share.Width, height: CGFloat(TopContentHeight + padding + CGFloat(Constant.share.SafeAreaTop) ), alignment: .topLeading)
    }
}// Translucent Underlay


struct ToddHomeLogo : View {
    var TopContentHeight = CGFloat(Constant.share.Height * (1 / 14))
    var UserImageHeightAndWidth = CGFloat(Constant.share.Height * (10/300))
    var FontColor = StateSingleton.share.Black
    var ToddLogoText = "TODDLIT"
    var body: some View{
        HStack{
            Image("ToddLogo")
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .frame(width: self.UserImageHeightAndWidth, height: self.UserImageHeightAndWidth, alignment: .bottom)
            
            Text(self.ToddLogoText)
                .font(Font(StateSingleton.share.FontType(2, CGFloat(UserImageHeightAndWidth * (0.61834)))))
                .foregroundColor(Color(self.FontColor))
        }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// hstack in hstak end brackets
    }
}// ToddHomeLogo




class GetUserNameAndProfileImg : ObservableObject{
    @Published var UserName : String = ""
    @Published var UserProfileImag : UIImage = UIImage(imageLiteralResourceName: "1")
    init() {
        getUserProfileData()
    }
    
    func getUserProfileData(){
        FirebaseAuth.Auth.auth().addStateDidChangeListener({ auth , user in
            if user!.displayName != nil{
                self.UserName = user!.displayName ?? "Default"

                if user!.photoURL != nil{
                    var url = user!.photoURL
//                    let image = UIImage()
//                    self.UserProfileImag = image
                }
            }
        })
    }
}





struct UserImageAndName : View {
    var UserImageHeightAndWidth = CGFloat(Constant.share.Height * (10/300))
    @State var UserSettingPage = false
    var UserName = "Clarke"
    var UserImage = "108"
    var FontColor = StateSingleton.share.FiftyPercentBlack
    var body : some View{
        HStack{
            Button(action : {
                self.UserSettingPage.toggle()
                // should segue user to his profile image for a change and to change his usernam if wanted
            }){
                Image(self.UserImage)
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
                .foregroundColor(Color(self.FontColor))
            }.sheet(isPresented: self.$UserSettingPage ){
               UserSettings()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
            }
        }// hstack end bracket
    }//body bracket
}// struct end bracket

//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story
//Recommended Story//Recommended Story//Recommended Story//Recommended Story//Recommended Story

struct RecomendedStory : View {
    var CoverImageSrc = ""
    var body: some View{
        RecommendedCoverImage(CoverImageSrc: self.CoverImageSrc)
    }
}

struct RecommendedCoverImage: View {
    @ObservedObject private var StoryData = dbRequests()
    @State var isShowingContent = false
    var CoverImageSrc = ""
    var width = CGFloat(Constant.share.Width)// complete width
    var height = CGFloat(Constant.share.Height * (0.6))//60% of the screens height
    var body: some View{
        
//        Button(action : {
//            // onclick take to view content
//        }){
            VStack{
                if #available(iOS 14.0, *) {
                    Image(uiImage: StoryData.ContentImage)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: self.width, height: self.height, alignment: .topLeading)
                        .background(Color.gray)
                        .clipShape(RecommendedShape())
                        .edgesIgnoringSafeArea(.top)
                        .onTapGesture {
                            self.isShowingContent.toggle()
                        }.fullScreenCover(isPresented: self.$isShowingContent, content:{
                            ContentView()
                        })
                } else {
                    Image(uiImage: StoryData.ContentImage)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: self.width, height: self.height, alignment: .topLeading)
                        .background(Color.gray)
                        .clipShape(RecommendedShape())
                        .edgesIgnoringSafeArea(.top)
                        .onTapGesture {
//                            self.isShowingContent.toggle()
                        }
                }
                    //.shadow(color: Color(StateSingleton.share.TwentieFivePercentBlack), radius: 2, x: 0, y: 1)
                Spacer()
            }.frame(width: self.width, height: self.height, alignment: .topLeading)
//        }.frame(width: self.width, height: self.height, alignment: .topLeading)//.edgesIgnoringSafeArea(.top)
        
    }
}

struct RecommendedShape : Shape{
    func path(in rect: CGRect) -> Path {
        Path{ path in
            /// min x and min y is in the right top corner
            let AllRight = rect.minX
            let AllLeft = rect.maxX
            
            let AllTop = rect.minY
            let AllBottom = rect.maxY
            
            let AlmostBottom = CGFloat( rect.maxY * (15.1 / 16))
            let AlmostRight = CGFloat( rect.maxX * (1.2 / 16))
            let AlmostLeft = CGFloat(rect.maxX * (14.8 / 16))

//            let rigtBottom = CGFloat(1 / 16)
            path.move(to: CGPoint(x: AllRight , y: AllTop))
            path.addLine(to: CGPoint(x: AllRight, y: AlmostBottom))
            path.addQuadCurve(to: CGPoint(x: AlmostRight, y: AllBottom), control: CGPoint(x: AllRight, y: AllBottom))
            path.addLine(to: CGPoint(x: AlmostLeft, y: AllBottom))
            path.addQuadCurve(to: CGPoint(x: AllLeft, y: AlmostBottom), control: CGPoint(x: AllLeft, y: AllBottom))
            path.addLine(to: CGPoint(x: AllLeft, y: AllTop))
        }// path
    }// path func
}


// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play
// Artist Content Info Play // Artist Content Info Play // Artist Content Info Play

struct ArtistContentInfoPlay : View {
    @ObservedObject private var StoryData = dbRequests()
    //Artista ImageSrc :
    @State var isShowingContent = false
    var ArtistSrc = ""
    //Story Data
    var Title = ""
    var Artist = ""
    var Tags = ""
    var StoryType = ""
    var PlayButtonSize : CGFloat = CGFloat(Constant.share.Width * (45 / 300))
    var padding = CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (-0.5))
    var body: some View{
        VStack(spacing : 0){
                HStack(alignment:.top){
                    ArtistHome().padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
                    Spacer()
                    Title_Artists_Tags_SType(Title : StoryData.StoryTitle ?? "" , Artist: "" ?? "" , Tags: StoryData.Tags.description ?? "" ,  StoryType: "" ?? "")
                    Spacer()
                    if #available(iOS 14.0, *) {
                        PlayInfoAddMyList()
                            .offset(x: 0, y: CGFloat((PlayButtonSize * (-0.5)) + padding ))
                            .padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge)
                            .onTapGesture {
                                self.isShowingContent.toggle()
                            }.fullScreenCover(isPresented: self.$isShowingContent, content:{
                                ContentView()
                            })
                        
                    } else {
                        PlayInfoAddMyList()
                            .offset(x: 0, y: CGFloat((PlayButtonSize * (-0.5)) + padding ))
                            .padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge)
                    }
                }.frame(width: Constant.share.Width , alignment: .topLeading)
            //ToddDivider().offset(x: 0, y: padding)
            }.frame(width: Constant.share.Width, alignment: .topLeading)//VStack
    }// body
}

struct ToddDivider : View{
    var body: some View{
        Color(StateSingleton.share.FiftyPercentBlack)
            .frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (0.05 / 100)) , alignment: .top)
    }
}

struct ArtistHome : View {
    var ArtistSrc = "12"
    var WidthandHeight = CGFloat(Constant.share.Height * (20 / 600))
    var body: some View{
        VStack{
            Button(action : {
                // take to the artista view
            }){
                Image(ArtistSrc)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width: self.WidthandHeight, height: self.WidthandHeight, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: CGFloat(WidthandHeight * (1 / 30)) ))
//                    .border(Color.black, width: CGFloat(WidthandHeight * (1 / 20)))
            }
        }
    }
}
var tim = 9// you can have global varibles look!!!!! and use them!!! <------OMG

struct Title_Artists_Tags_SType : View {
    var Title = "Cold River Canyon"
    var TitleFontSize = CGFloat( Constant.share.Height * (14 / 600) )
    
    var Artist = "By: Arch Timber  &  RICHARD SMITH"
    var ArtistFontSize = CGFloat( Constant.share.Height * (6 / 600) )
    
    var Tags = "Tags : Action, Adventure, Existentialism, Family"
    var TagsFontSize = CGFloat( Constant.share.Height * (8 / 600) )
    
    var StoryType = "Story 7"
    var STypeFontSize = CGFloat( Constant.share.Height * (7 / 600) )
    
    var body: some View{
        VStack(alignment : .leading){
            Text(self.Title)
                .foregroundColor(Color.black)
                .font((Font(StateSingleton.share.FontType(7, self.TitleFontSize))))
            
            Text(self.Artist)
                .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                .font((Font(StateSingleton.share.FontType(5, self.ArtistFontSize))))
            
            Text(self.Tags)
                .foregroundColor(Color(StateSingleton.share.SeventyFivePercentBlack))
                .font((Font(StateSingleton.share.FontType(5, self.TagsFontSize))))
            
            Text(self.StoryType)
                .foregroundColor(Color(StateSingleton.share.TwentieFivePercentBlack))
                .font((Font(StateSingleton.share.FontType(5, self.STypeFontSize))))
            
        }
    }
}


struct PlayInfoAddMyList : View {
    var InfoAddWidth = CGFloat(Constant.share.Height * (14 / 600))
    var PlayButtonSize : CGFloat = CGFloat(Constant.share.Width * (45 / 300))
    var padding = CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (0.5))
    var body: some View{
        VStack{
            PlayButton()
            HStack{
                ContentInfo()
                AddToMyList()
            }.offset(x: 0, y: padding)//Hastack
        }//VStack
    }
}



struct PlayButton : View {
    var PlayButtonSize : CGFloat = CGFloat(Constant.share.Width * (45 / 300))
    var body: some View{
                    Button(action : {
                        /// This is one of the most crucial button in the whole application it has to be done correctly
//                        dbRequests()
//                        isContentView().isContentView = true
                        }){
                        ZStack{
                            Circle()
                                .fill(Color.black)
                                .shadow(color: Color(StateSingleton.share.SeventyFivePercentBlack), radius: 5.0, x: 3.0, y: 10.0)
                                .frame(width: self.PlayButtonSize, height: self.PlayButtonSize, alignment: .trailing)
                            HStack{
                                Image("Play")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .offset(x: CGFloat(self.PlayButtonSize * (0.03)) , y: 0)
                                    .frame(width: CGFloat(self.PlayButtonSize * (0.5) ), height: CGFloat(self.PlayButtonSize * (0.5) ) , alignment: .center)
                            }.frame(width: self.PlayButtonSize, height: self.PlayButtonSize, alignment: .center)
                            }//.offset(x: 0.0, y: CGFloat( -1 * ((self.PlayButtonSize / 3 ) + StateSingleton.share.PaddingFromTheLeadingEdge )))
                        
                    }.frame(width: self.PlayButtonSize, height: self.PlayButtonSize, alignment: .center)//.padding(.top, StateSingleton.share.PaddingFromTheLeadingEdge)
    }
}

struct ContentInfo : View {
    var InfoAddWidth = CGFloat(Constant.share.Height * (14 / 600))
    var coverImageRef = "12"
    var Title = ""
    var Artists = ""
    var CreatorsImage = ""
    var Summary = ""
    @State var presentPreviewContent = false
    var body: some View{
                            Image("ContentInfo")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFill()
                                .frame(width: self.InfoAddWidth, height: self.InfoAddWidth, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(StateSingleton.share.FiftyPercentBlack), lineWidth:  CGFloat((Constant.share.Height * (20 / 600)) * (1 / 30) )))
        //                            .border(Color.black, width: CGFloat((Constant.share.Height * (20 / 600)) * (1 / 20) ))
                        .onTapGesture {
                            StateSingleton.share.PassingDataBetweenViews(Image: self.coverImageRef, Title: self.Title, Artists: self.Artists, ArtistaImage: self.CreatorsImage)
                            StateSingleton.share.Summary = self.Summary
                            
                            self.presentPreviewContent.toggle()
//                            self.opacity(0.75)
                        }
                        .sheet(isPresented: self.$presentPreviewContent ){
                            PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                         }
    }
}


struct AddToMyList : View {
    var InfoAddWidth = CGFloat(Constant.share.Height * (14 / 600))
    var body: some View{
                        Button(action : {
                           // stores in the database the my list
                        }){
                            Image("AddToMyList")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFill()
                                .frame(width: self.InfoAddWidth, height: self.InfoAddWidth, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(StateSingleton.share.FiftyPercentBlack), lineWidth:  CGFloat((Constant.share.Height * (20 / 600)) * (1 / 30) )))
        //                            .border(Color.black, width: CGFloat((Constant.share.Height * (20 / 600)) * (1 / 20) ))
                        }
    }
}





//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:
//Regular Content://Regular Content://Regular Content://Regular Content://Regular Content:



struct ContinueDataType : Identifiable{
    var id = UUID()// to generate a random ID
    var Title : String
    var Artists : String
    var Image : String
    var ContentType : String
    var Summary : String // will be a Url in th future
    var RefferenceToContent : String // will be a Url to grab the tree such that all the data can be loaded
    var CreatorsImage : String
    var Progress : CGFloat
}


struct ContinueWatching : View {
    var UnfinishedContent = [
        ContinueDataType(Title: "Space Race", Artists: "Richard Branch", Image: "12", ContentType: "Solo", Summary: "Summary", RefferenceToContent: "www.google.com", CreatorsImage: "/ref/fireB/127/User-Richard_Branch", Progress : CGFloat(15)),
        
        ContinueDataType(Title: "Proper Placement", Artists: "Rosso Leo", Image: "7", ContentType: "Episode 2", Summary: "Summary", RefferenceToContent: "www.google.com", CreatorsImage: "/ref/fireB/127/User-Richard_Branch", Progress : CGFloat(75)),
        
        ContinueDataType(Title: "Archie Goodwin", Artists: "Richard Branch", Image: "10", ContentType: "Solo", Summary: "Summary", RefferenceToContent: "www.google.com", CreatorsImage: "/ref/fireB/127/User-Richard_Branch", Progress: CGFloat(35))
    ]
    var TitleFontSize = CGFloat(Constant.share.Height * (1.9 / 100))

    var body: some View{
        VStack(alignment: .leading, spacing: CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (0.5))){
            ToddDivider() 
            Text("Continue : ")
                .foregroundColor( Color(StateSingleton.share.SeventyFivePercentBlack) )
                .font(Font(StateSingleton.share.FontType(7, self.TitleFontSize)))
                .padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack(spacing : CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge)){
                
                ForEach(self.UnfinishedContent){data in
                    ContinueView(Title: data.Title, Artists: data.Artists, Image: data.Image, ContentType: data.ContentType , Summary: data.Summary , RefferenceToContent: data.RefferenceToContent , CreatorsImage: data.CreatorsImage, Progress: data.Progress)
                    
                }//ForEach
            }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)//HStack
        }//ScrollView
        }//VStack
    }//Body
}//View



struct ContinueView : View{
    var Title : String
    var Artists : String
    var Image : String
    var ContentType : String
    var Summary : String // will be a Url in th future
    var RefferenceToContent : String // will be a Url to grab the tree such that all the data can be loaded
    var CreatorsImage : String
    var Progress : CGFloat
    var body: some View{
        VStack(alignment: .leading){
            ContinueContentCover(image: self.Image)
            HomeProgressBar(PercentOfProgress: self.Progress)
            HomeTextData(Title: self.Title, Artist: self.Artists, ContentType: self.ContentType)
        }
    }
}


struct ContinueContentCover : View {
    var widthAndHeight = CGFloat(Constant.share.Width * (80 / 280) )
    var image = ""
    var body: some View{

        Image(self.image)
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: CGFloat((Constant.share.Height * (20 / 600)) * (1 / 30) )))
            .frame(width: self.widthAndHeight, height: self.widthAndHeight, alignment: .center)
            .onTapGesture {
                //
            }
        
    }//button modifier
}

struct HomeProgressBar : View{
    var HeightOfProgress = CGFloat(Constant.share.Height * (0.35 / 100))// a percent of the view height
    var widthOfFrame = CGFloat(Constant.share.Width * (80 / 280) )// a percent relative to the view width
    var widthOfProgressBar = CGFloat(Constant.share.Width * (70 / 280) )// a percent relative to the view width
    var PercentOfProgress = CGFloat(0 );// default to zero
    var body: some View{
        ZStack(alignment: .leading){// needs to be leading because the progress bars need to allign up on the left
            Capsule().fill(Color(StateSingleton.share.FiftyPercentBlack)).frame(width: self.widthOfProgressBar, height: self.HeightOfProgress, alignment: .leading)
            Capsule().fill(Color(StateSingleton.share.ToddBlue)).frame(width: CGFloat(self.widthOfProgressBar * (self.PercentOfProgress / 100)), height: self.HeightOfProgress, alignment: .leading)
        }.frame(width: self.widthOfFrame, alignment: .center)
    }
    
}



struct HomeTextData : View {
    var Title = ""
    var Artist = ""
    var ContentType = ""
    var TitleFontSize = CGFloat(Constant.share.Height * (8.5 / 600))
    var ArtistFontSize = CGFloat(Constant.share.Height * (7 / 600) )
    var ContentTypeFontSize = CGFloat(Constant.share.Height * (5.5 / 600))
    var FrameWidth = CGFloat(Constant.share.Width * (70 / 280) )
    var PaddingToEvenoutProgress = CGFloat(Constant.share.Width * (5 / 280) )

    var body: some View{
        VStack(alignment: .leading){
        Text(self.Title)
            .foregroundColor(.black)
            .font(Font(StateSingleton.share.FontType(5, self.TitleFontSize)))
        Text(self.Artist)
            .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
            .font(Font(StateSingleton.share.FontType(5, self.ArtistFontSize)))
        Text(self.ContentType)
                .foregroundColor(Color(StateSingleton.share.TwentieFivePercentBlack))
            .font(Font(StateSingleton.share.FontType(5, self.ContentTypeFontSize)))
        }.frame(width: self.FrameWidth, alignment: .leading).padding(.leading, self.PaddingToEvenoutProgress)
    }
}


//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views
//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views//Discover Views

struct HomeDiscoverDataType : Identifiable{
    var id = UUID()// to generate a random ID
    var Title : String
    var Artists : String
    var Image : String
    var ContentType : String
    var Summary : String // will be a Url in th future
    var RefferenceToContent : String // will be a Url to grab the tree such that all the data can be loaded
    var CreatorsImage : String
}

struct HomeDiscoverView : View{

    var DiscoverContent = [
        HomeDiscoverDataType(Title: "Space Race", Artists: "Richard Branch", Image: "12", ContentType: "Solo", Summary: "Summary", RefferenceToContent: "www.google.com", CreatorsImage: "/ref/fireB/127/User-Richard_Branch"),
        
        HomeDiscoverDataType(Title: "Proper Placement", Artists: "Rosso Leo", Image: "7", ContentType: "Episode 2", Summary: "Summary", RefferenceToContent: "www.google.com", CreatorsImage: "/ref/fireB/127/User-Richard_Branch"),
        
        HomeDiscoverDataType(Title: "Archie Goodwin", Artists: "Richard Branch", Image: "10", ContentType: "Solo", Summary: "Summary", RefferenceToContent: "www.google.com", CreatorsImage: "/ref/fireB/127/User-Richard_Branch")
    ]
    
    var TitleFontSize = CGFloat(Constant.share.Height * (1.9 / 100))
    
    var body: some View{
        VStack(alignment: .leading){
            ToddDivider()
            Text("Discover : ")
                .foregroundColor( Color(StateSingleton.share.SeventyFivePercentBlack) )
                .font(Font(StateSingleton.share.FontType(7, self.TitleFontSize)))
                .padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: StateSingleton.share.PaddingFromTheLeadingEdge){
                            ForEach(self.DiscoverContent){data in
                                VStack(alignment : .leading){
                                    HomeImage(Title: data.Title, Artists: data.Artists, CoverImage: data.Image, ContentType: data.ContentType, Summary: data.Summary , RefferenceToContent: data.RefferenceToContent, CreatorsImage: data.CreatorsImage)
                                    
                                        HomeTextData(Title: data.Title, Artist: data.Artists, ContentType: data.ContentType)
                                    }//VStack
                            }//ForEach
                    }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)//HStack
                }//Scrollview
        }.padding(.top, CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge))//VStack
    }// Body
}

struct HomeImage : View{
    var widthAndHeight = CGFloat(Constant.share.Width * (80 / 280) )
    @State var presentPreviewContent = false
    // To pass in data for nextView
    var Title : String = ""
    var Artists : String = ""
    var CoverImage : String = ""
    var ContentType : String = ""
    var Summary : String = ""
    var RefferenceToContent : String = ""// will be a Url to grab the tree such that all the data can be loaded
    var CreatorsImage : String = ""
    

    var body: some View{

            Image(self.CoverImage)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: self.widthAndHeight, height: self.widthAndHeight, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: CGFloat(widthAndHeight * 0.15)))
                .overlay(RoundedRectangle(cornerRadius: CGFloat(widthAndHeight * 0.15) ).stroke(Color.black, lineWidth: CGFloat((Constant.share.Height * (20 / 600)) * (1 / 30) )))
                .onTapGesture {
                    StateSingleton.share.PassingDataBetweenViews(Image: self.CoverImage, Title: self.Title, Artists: self.Artists, ArtistaImage: self.CreatorsImage)
                    
                    self.presentPreviewContent.toggle()
                    self.opacity(0.75)
                }
                .sheet(isPresented: self.$presentPreviewContent ){
                    PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                 }
    }
}






//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories
//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories//Stories

struct StoryDataData : Codable , Identifiable, Equatable{
    var id = UUID()
    var CoverImage : String
    var ArtistaProfileImage : String
    var Title : String
    var Artist : String
    var Tags : String
    var StoryType : String
}

struct HomeStory : View{
    var CoverImage : String
    var ArtistaProfileImage : String
    var Title : String
    var Artist : String
    var Tags : String
    var StoryType : String
    
    var Summary = ""

    
    var body : some View{
        VStack(alignment: .leading){
            HomeStoryCover(CoverImage: self.CoverImage)
            HomeStoryContentData(ArtistaProfileImage : self.ArtistaProfileImage, Title: self.Title, Artist: self.Artist, Tags: self.Tags, StoryType: self.StoryType, coverImageRef: self.CoverImage, Summary: self.Summary)
        }.padding(.top , StateSingleton.share.PaddingFromTheLeadingEdge)
    }
}

struct HomeStoryCover : View {
    var CoverImage : String
    var ThisWidth = CGFloat(Constant.share.Width)
    var body : some View{

            Image(self.CoverImage)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: self.ThisWidth, height: self.ThisWidth, alignment: .center)
                .clipped()
//                .cornerRadius(20)
//                .shadow(color: Color(StateSingleton.share.ShadowColor) , radius: 2.0, x: 0, y: 0)
//                .padding([.leading], CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge / 2))
                .onTapGesture {
                    //
                }
    }
}

struct HomeStoryContentData : View{
    var ArtistaProfileImage : String
    var Title : String
    var Artist : String
    var Tags : String
    var StoryType : String
    
    var coverImageRef = "12"
    var Summary = ""


    var body: some View{
        HStack(alignment: .top){
            ArtistHome( ArtistSrc: self.ArtistaProfileImage).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
            Spacer()
            Title_Artists_Tags_SType(Title: self.Title, Artist: self.Artist, Tags: self.Tags, StoryType: self.StoryType)
            Spacer()
            HomeStoryPlayInfoAddMyList(coverImageRef: self.coverImageRef, Title: self.Title, Artists: self.Artist, CreatorsImage: self.ArtistaProfileImage, Summary: self.Summary).padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge)
        }
    }
}


struct HomeStoryPlayInfoAddMyList : View {
    var coverImageRef = "12"
    var Title = ""
    var Artists = ""
    var CreatorsImage = ""
    var Summary = ""
    var body: some View{
        VStack{
            HomeStoryPlayButton()
            HStack{
                ContentInfo(coverImageRef: self.coverImageRef, Title: self.Title, Artists: self.Artists, CreatorsImage: self.CreatorsImage, Summary: self.Summary)
                AddToMyList()
            }//Hastack
        }//VStack
    }
}

var InfoAddWidth = CGFloat(Constant.share.Height * (14 / 600))

struct HomeStoryPlayButton : View {
    var ButtonHeight = CGFloat( Constant.share.Height * (22 / 600) )
    var ButtonWidth = CGFloat( Constant.share.Width * (60 / 280) )
    var PlayUI = "Play"
    var PlayUISize = CGFloat(Constant.share.Height * (10 / 600))
    var PlayButtonFont = CGFloat(Constant.share.Height * (10 / 600))
    var body: some View{
        Button(action : {
            // takes you directly to the content
        }){
            HStack(alignment: .center){
                Text("P L A Y")
                    .foregroundColor(Color.white)
                    .font( Font( StateSingleton.share.FontType(7, self.PlayButtonFont)  ) )
                Image(self.PlayUI)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width: self.PlayUISize , height: self.PlayUISize, alignment: .center)
            }.frame(width: self.ButtonWidth, height: self.ButtonHeight, alignment: .center).background(Color.black).clipShape(RoundedRectangle(cornerRadius: CGFloat(self.ButtonHeight * ( 0.20 ) ) ))
        }
    }
}



