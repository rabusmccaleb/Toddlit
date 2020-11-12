//
//  UserSettings.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 2/16/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import SwiftUI

struct UserSettings: View {
    var UserIdImageWidthAndHeight = CGFloat(Constant.share.Width * (80 / 300))
    var AddUserEditWidthAndHeight = CGFloat((Constant.share.Width * (80 / 300)) * (1 / 4))
    var UserIdImage : String  = "4"// refference
    var UserName : String = "Clarke"
    var body: some View {
        ZStack(){
            SquareTab()
                .fill(Color.white)
                .frame(width: Constant.share.Width, height: Constant.share.Height , alignment: .center)
                .edgesIgnoringSafeArea(.all)// to dissallow the darkmode
            VStack{
            Image(self.UserIdImage)
            .resizable()
            .scaledToFill()
            .blur(radius: 4.0)
//                .frame(width: CGFloat(Constant.share.Width + (StateSingleton.share.PaddingFromTheLeadingEdge * 2)), height: Constant.share.Width , alignment: .top)
            .edgesIgnoringSafeArea(.all)
            Spacer()
            }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .top)//VStack all to push the background image up
            ZStack{
                VStack{
                    Spacer()
                    SquareTab()
                        .fill(Color.white)
                        .frame(width: Constant.share
                            .Width, height: CGFloat(Constant.share.Height * (0.45)), alignment: .bottom)
                }.frame(width: Constant.share
                    .Width, height: Constant.share.Height, alignment: .bottom)// vstack for square tab view that insure upon scroll no eror occursx
                
                ScrollView(.vertical){
                VStack{
                    Spacer().frame(width: Constant.share.Width, height: CGFloat(Constant.share.Height * (1 / 20)), alignment: .top)
                    HStack(spacing : StateSingleton.share.PaddingFromTheLeadingEdge){
                    Spacer()
                    Button(action : {
                        /// action add another user functionality
                        
                        /*   //// Medium Complexity :
                                (The process of adding a user in ther first place is repeated except the sign up part,
                         but with one specific difference )
                           1. 
                           2. An array of image are availble to choose from... they cary their url also
                           3. when the user selects the image the prefer then then their Url refference is replaced on the database with a new reffrerence
                         
                         
                        */
                        
                    }){
                        Image("EditButton")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: self.AddUserEditWidthAndHeight, height: self.AddUserEditWidthAndHeight, alignment: .center)
                    }//add another user... not account but user
                    

                        
                        
                        
                        Image(self.UserIdImage)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: self.UserIdImageWidthAndHeight, height: self.UserIdImageWidthAndHeight, alignment: .center)
                        .clipShape(Circle())

                    
                    
                    Button(action : {
                        // Add Profile: Basic profile data: Image, Create a collection under the main user doc, with maps and documents that contain important profile data like continue watching etc.
                        /// action                                                          ////Low Complexty
                    }){
                        Image(Constant.share.AddToMyListRef)
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: self.AddUserEditWidthAndHeight, height: self.AddUserEditWidthAndHeight, alignment: .center)
                    }//edit user info
                    Spacer()
                }//Hstack with user id image, add new user, and edit user data
                    Text(self.UserName)
                        .foregroundColor(Color.black)
                        .font(Font(StateSingleton.share.FontType(7 , 28)))
                        .frame(width : Constant.share.Width , alignment: .center)
                    
                    //// other content view for this data
                    ContentTab()
                    
                    
                    
                    
                }//VStack
                }// in the even that the view needs to scroll upward because the data is to larage in comparison to the availble view size
            }//ZStack
        }//ZStack
    }//Body
}//Struct

struct UserSettings_Previews: PreviewProvider {
    static var previews: some View {
        UserSettings()
    }
    
}


struct ContentTab : View{
    var body : some View{
        ZStack{
            Color.white
                .frame(width: Constant.share.Width)
            VStack{
                HStack{
                Text("Stories You Follow :")
                .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                .font(Font(StateSingleton.share.FontType(7 , 14)))
                .frame(width : Constant.share.Width , alignment: .leading)
                    .padding([.leading , .top], StateSingleton.share.PaddingFromTheLeadingEdge)
                    
                Spacer()// mover the entire object over to the left
                }.frame(width: Constant.share.Width, alignment: .leading)
                StoryArches()
                MyListView()
                SettingslistItems()
                Spacer().frame(width: Constant.share.Width, height: CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * 4), alignment: .center)
                
            }
        }
    }
}



struct StoryArches : View {
    var UnfinishedContent = [
        ContinueDataType(Title: "Space Race", Artists: "Richard Branch", Image: "12", ContentType: "Solo", Summary: "Summary", RefferenceToContent: "www.google.com", CreatorsImage: "/ref/fireB/127/User-Richard_Branch", Progress : CGFloat(15)),
        
        ContinueDataType(Title: "Proper Placement", Artists: "Rosso Leo", Image: "7", ContentType: "Episode 2", Summary: "Summary", RefferenceToContent: "www.google.com", CreatorsImage: "/ref/fireB/127/User-Richard_Branch", Progress : CGFloat(75)),
        
        ContinueDataType(Title: "Archie Goodwin", Artists: "Richard Branch", Image: "10", ContentType: "Solo", Summary: "Summary", RefferenceToContent: "www.google.com", CreatorsImage: "/ref/fireB/127/User-Richard_Branch", Progress: CGFloat(35))
    ]
    var TitleFontSize = CGFloat(Constant.share.Height * (1.9 / 100))

    var body: some View{
        VStack(alignment: .leading, spacing: CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (0.5))){
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack(spacing : CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge)){
                
                ForEach(self.UnfinishedContent){data in
                    StoryArchesView(Title: data.Title, Artists: data.Artists, Image: data.Image, ContentType: data.ContentType , Summary: data.Summary , RefferenceToContent: data.RefferenceToContent , CreatorsImage: data.CreatorsImage, Progress: data.Progress)
                    
                }//ForEach
            }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)//HStack
        }//ScrollView
        }//VStack
    }//Body
}//View



struct StoryArchesView : View{
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
            HomeTextData(Title: self.Title, Artist: self.Artists, ContentType: self.ContentType)
        }
    }
}






struct MyListView : View {
    var ViewHeader : String = "My List"
    var Data = Constant.share.MyListData
    var body : some View {
        VStack{
            Text(self.ViewHeader)
            .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
            .font(Font(StateSingleton.share.FontType(7 , 14)))
            .frame(width : Constant.share.Width , alignment: .leading)
                .padding([.leading , .top], StateSingleton.share.PaddingFromTheLeadingEdge)
            HStack{
                UserSettings_MyListView()
            }
        }
    }
}


struct UserSettings_MyListView : View {

    var MyListData = [
        HomeDiscoverDataType(Title: "Space Race", Artists: "Richard Branch", Image: "12", ContentType: "Solo", Summary: "Summary", RefferenceToContent: "www.google.com", CreatorsImage: "/ref/fireB/127/User-Richard_Branch"),
        
        HomeDiscoverDataType(Title: "Proper Placement", Artists: "Rosso Leo", Image: "7", ContentType: "Episode 2", Summary: "Summary", RefferenceToContent: "www.google.com", CreatorsImage: "/ref/fireB/127/User-Richard_Branch"),
        
        HomeDiscoverDataType(Title: "Archie Goodwin", Artists: "Richard Branch", Image: "10", ContentType: "Solo", Summary: "Summary", RefferenceToContent: "www.google.com", CreatorsImage: "/ref/fireB/127/User-Richard_Branch")
    ]
    
    var TitleFontSize = CGFloat(Constant.share.Height * (1.9 / 100))
    
    var body: some View{
        VStack(alignment: .leading){
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: StateSingleton.share.PaddingFromTheLeadingEdge){
                            ForEach(self.MyListData){data in
                                VStack(alignment : .leading){
                                    HomeImage(Title: data.Title, Artists: data.Artists, CoverImage: data.Image, ContentType: data.ContentType, Summary: data.Summary , RefferenceToContent: data.RefferenceToContent, CreatorsImage: data.CreatorsImage)
                                    
                                        HomeTextData(Title: data.Title, Artist: data.Artists, ContentType: data.ContentType)
                                    }//VStack
                            }//ForEach
                    }.padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)//HStack
                }//Scrollview
        }//.padding(.top, CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge))//VStack
    }// Body
}


















struct SettingslistItems : View {
    var AddUserEditWidthAndHeight = CGFloat((Constant.share.Width * (80 / 300)) * (1 / 5))
    @State var ToggleHelpUsServeYou = false
    var body : some View{
        VStack( spacing: CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge / 4 ) ){
            
    Divider()
            
            HStack{
                    Button(action : {
                        //action
                            }){
                            HStack{
                                Image("profiles")
                                .resizable()
                                .scaledToFit()
                                .frame(width: self.AddUserEditWidthAndHeight, height: self.AddUserEditWidthAndHeight, alignment: .bottom)
                                Text("Accounts")
                                   .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                                    .font(Font(StateSingleton.share.FontType(7, 13.0)))
                                .frame(width: Constant.share.Width, alignment: .leading)
                                Spacer()
                                }//HStack
                            }//Button Modifier
            }.frame(width: Constant.share.Width, alignment: .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// HStack
            
            
            
            Divider()
            
            
            HStack{
                    Button(action : {
                    //action
                        }){
                        HStack{
                            Image("parentalControl")
                            .resizable()
                            .scaledToFit()
                            .frame(width: self.AddUserEditWidthAndHeight, height: self.AddUserEditWidthAndHeight, alignment: .bottom)
                            Text("Parental Controls")
                           .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                            .font(Font(StateSingleton.share.FontType(7, 13.0)))
                            .frame(width: Constant.share.Width, alignment: .leading)
                            Spacer()
                            }//HStack
                        }//Button Modifier
        }.frame(width: Constant.share.Width, alignment: .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// HStack
            
            
        Divider()
            
            
    HStack{
            Button(action : {
            //action
                }){
                HStack{
                    Image("Security")
                    .resizable()
                    .scaledToFit()
                    .frame(width: self.AddUserEditWidthAndHeight, height: self.AddUserEditWidthAndHeight, alignment: .bottom)
                    Text("Sign In & Security")
                        .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                        .font(Font(StateSingleton.share.FontType(7, 13.0)))
                    .frame(width: Constant.share.Width, alignment: .leading)
                    Spacer()
                    }//HStack
                }//Button Modifier
    }.frame(width: Constant.share.Width, alignment: .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// HStack
            
            
        Divider()
            
            
        HStack{
            Button(action : {
            //action
                self.ToggleHelpUsServeYou.toggle()
                }){
                HStack{
                    Image("HelpUSY")
                    .resizable()
                    .scaledToFit()
                    .frame(width: self.AddUserEditWidthAndHeight, height: self.AddUserEditWidthAndHeight, alignment: .bottom)
                    
                    
                    
                    if #available(iOS 14.0, *) {
                        Text("Help Us Serve You")
                            .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                            .font(Font(StateSingleton.share.FontType(7, 13.0)))
                            .frame(width: Constant.share.Width, alignment: .leading)
                            .sheet(isPresented: self.$ToggleHelpUsServeYou, content: {
                                                userWebQuestionaire(url: "https://toddlit.com/userTags/tagSignIn.html")})
//                            .fullScreenCover(isPresented: self.$ToggleHelpUsServeYou, content: {
//                                                userWebQuestionaire(url: "https://toddlit.com/userTags/tagSignIn.html")})
                    } else {
                        // Fallback on earlier versions
                        Text("Help Us Serve You")
                            .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
                            .font(Font(StateSingleton.share.FontType(7, 13.0)))
                            .frame(width: Constant.share.Width, alignment: .leading)
                            .sheet(isPresented: self.$ToggleHelpUsServeYou, content: {
                                                userWebQuestionaire(url: "https://toddlit.com")})
                    }
                    
                    
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                    }//HStack
                }//Button Modifier
    }.frame(width: Constant.share.Width, alignment: .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// HStack
     
            
    Divider()
            
            
            
    HStack{
            Button(action : {
                // sign out actions which seems complicated but using firestore and firebase might will make things easier
                isSigned().signoutAuth()
            }){
                
                Text("Sign Out").foregroundColor(Color(StateSingleton.share.ToddBlue)).font(Font(StateSingleton.share.FontType(7, 16))).frame(width: Constant.share.Width, alignment: .center)
            }// end of button modifier
    }.frame(width: Constant.share.Width, alignment: .leading).padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)// HStack
            
        }.frame(width: Constant.share.Width, alignment: .bottom)//VStack
    }//body
}//struct

