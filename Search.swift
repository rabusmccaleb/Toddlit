//
//  Search.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 2/16/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//
import Foundation
import SwiftUI
import InstantSearch

struct ContentLandscapeView: View {
    @Environment(\.verticalSizeClass) var horizontalSizeClass

    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                Text("landscape")
            } else {
                Text("Potrait")
            }
        }
    }
}

struct Search: View {
    @State var searchText = ""
    @State var isEditingSearch = false
    
    var body: some View {
        ZStack(alignment: .topLeading){
//            Image("6-1")
//                .resizable()
//                .scaledToFill()
//                .opacity(0.1)
//                .frame(width: Constant.share.Width, height: Constant.share.Height)
                VStack(){
                   //.offset(x: 0, y: CGFloat(Constant.share.SafeAreaTop * -1))
                    ScrollView(.vertical, showsIndicators : false){
                        VStack(){
                            SearchLogoAndUser()
                            SearchBar(text: self.$searchText).animation(.default).onTapGesture {
                                self.isEditingSearch = true
                            }
//                            CustomSearchBar(text: $searchText)
                            if isEditingSearch == false{
                                TopEightStories()//.animation(.linear)
                            }else{
                                List(){
                                    TopEightStories().hidden()
                                    SearchStoryImage()
                                    SearchArtistImage()
                                }
                            }
                        }.offset(x: 0, y: CGFloat(Constant.share.SafeAreaTop + (StateSingleton.share.PaddingFromTheLeadingEdge / 2)))
                    }
                }
        }.background(Color.black).edgesIgnoringSafeArea(.top)//.frame(width : Constant.share.Width , height : Constant.share.Height, alignment: .topLeading).background(Color.black)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}








struct SearchLogoAndUser : View {
    var width = CGFloat(Constant.share.Width)// complete width of recommended story image
    var height = CGFloat(Constant.share.Height * (0.6))//60% of the screens... hight of recommended story image
//    var TopContentHeight = CGFloat(Constant.share.Height * (1 / 14))
    var UserImageHeightAndWidth = CGFloat(Constant.share.Height * (10/300))
    var padding = CGFloat(StateSingleton.share.PaddingFromTheLeadingEdge * (0.5))
    var ToddLogoText = "Search"
    
    var body : some View{
        HStack(alignment : .bottom){
            ToddHomeLogo(FontColor: StateSingleton.share.white, ToddLogoText: self.ToddLogoText)
            Spacer()
            UserImageAndName(FontColor : StateSingleton.share.FiftyPercentWhite).padding([.trailing], StateSingleton.share.PaddingFromTheLeadingEdge)
            
        }.frame(width: Constant.share.Width, alignment: .bottom)//.padding([.bottom], StateSingleton.share.PaddingFromTheLeadingEdge)//Hstack
    }//body viuew
}// LogoUserTab brackets



struct SearchBar : View{
//    struct SearchBar: View {
        @Binding var text: String
     
        @State private var isEditing = false
    
//    init(){
//        UITextField.appearance().textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//
//    }
     
        var body: some View {
            HStack {
                //https://www.appcoda.com/swiftui-search-bar/
                CustomSearchBar(text: $text)
                    .cornerRadius(10)
                    .foregroundColor(.black)
//                TextField("Search...", text: $text)
//                    .padding(7)
//                    .padding(.horizontal, 25)
//                    .background(Color(.white))
//                    .cornerRadius(8)
//                    .padding(.horizontal, 10)
//                    .foregroundColor(Color.black)
                    .onTapGesture {
                        self.isEditing = true
                    }
     
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.text = ""
                        print(self.text)
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("Cancel").foregroundColor(Color.black)
                        
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
        }
//    }
}








struct CustomSearchBar : UIViewRepresentable {
    
    //https://www.youtube.com/watch?v=OIrO3Uj3Y4k
    //https://www.algolia.com/doc/api-reference/widgets/search-box/ios/
    
    @Binding var text : String
    
    func makeUIView(context: UIViewRepresentableContext<CustomSearchBar>) -> UISearchBar {
        
        let searchBar = UISearchBar(frame: .zero)
        
        let queryInputInteractor: QueryInputInteractor = .init()
        let searchBarController: SearchBarController = .init(searchBar: searchBar)
        let searcher: SingleIndexSearcher = SingleIndexSearcher(appID: "92M7RT1QNZ",
          apiKey: "27afb9d550d26d597f2e8324f5e97191",
          indexName: "Stories")

        queryInputInteractor.connectSearcher(searcher, searchTriggeringMode: .searchAsYouType)
        queryInputInteractor.connectController(searchBarController)

        searcher.search()
        
        searchBar.delegate = context.coordinator
        
        searchBar.placeholder = "Search Stories, Tags, and Artists..."
        searchBar.barStyle = .default
        searchBar.tintColor = .white
        searchBar.backgroundColor = .clear
        searchBar.barTintColor = .white
        searchBar.backgroundImage = UIImage()
        
//        searchBar.isTranslucent = true
        searchBar.sizeToFit()
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<CustomSearchBar>) {
        uiView.text = text
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    
    class Coordinator: NSObject , UISearchBarDelegate {
        
        @Binding var text : String

        
        init(text : Binding<String>){
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    
}













struct TagView : View {
    var TagText = "Existential"
    var TagUIImage = "13"
    var TagHeight = CGFloat(Constant.share.Height * (1/22.5) )
    var TagWidth = CGFloat(Constant.share.Width * (0.40 ))
    var cornerRadius = CGFloat(Constant.share.Width * (40 / 280) * (0.15))
    var body: some View{
        ZStack(alignment: .center){
            Image(self.TagUIImage)
                .resizable()
                .scaledToFill()
                .opacity(0.5)
                .frame(width: self.TagWidth, height: self.TagHeight, alignment: .center)
            Text(self.TagText)
                .foregroundColor(Color.black)
                .font(Font(StateSingleton.share.FontType(5, CGFloat(self.TagHeight / 2) )))
        }.frame(width: self.TagWidth, height: self.TagHeight)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: CGFloat(self.cornerRadius)))
        .overlay(RoundedRectangle(cornerRadius: CGFloat( cornerRadius ) ).stroke(Color.black, lineWidth: CGFloat((Constant.share.Height * (20 / 600)) * (1 / 30) )))
    }
}




struct StoryView : View {
    var StoryImage = ""
    var StoryTitle = ""
    var StoryArtist = ""
    var StoryType = ""
    
    var viewHeight = CGFloat(1)
    var viewWidth = CGFloat(Constant.share.Width)
    var imageWidthHeight = CGFloat()
    
    
    
    var body: some View{
        VStack(){
            HStack(){
                SearchStoryImage()
                VStack(){
                    Text(self.StoryTitle)
                    Text(self.StoryArtist)
                    Text(self.StoryType)
                    
                }
            }
        }
    }
}



struct SearchStoryImage : View{
    var widthAndHeight = CGFloat(Constant.share.Width * (80 / 280) )
    @State var presentPreviewContent = false
    // To pass in data for nextView
    var Title : String = ""
    var Artists : String = ""
    var CoverImage : String = "12"
    var ContentType : String = ""
    var Summary : String = ""
    var RefferenceToContent : String = ""// will be a Url to grab the tree such that all the data can be loaded
    var CreatorsImage : String = ""
    
    @State var OpacityVar : Double = Double(1.0)
    

    var body: some View{

            Image(self.CoverImage)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: self.widthAndHeight, height: self.widthAndHeight, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: CGFloat(widthAndHeight * 0.15)))
                .overlay(RoundedRectangle(cornerRadius: CGFloat(widthAndHeight * 0.15) ).stroke(Color.black, lineWidth: CGFloat((Constant.share.Height * (20 / 600)) * (1 / 30) )))
                .opacity(self.OpacityVar)
                .onTapGesture {
                    StateSingleton.share.PassingDataBetweenViews(Image: self.CoverImage, Title: self.Title, Artists: self.Artists, ArtistaImage: self.CreatorsImage)
                    self.OpacityVar = Double(0.5)
                    self.presentPreviewContent.toggle()
                }
                .sheet(isPresented: self.$presentPreviewContent ){
                    PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                 }
    }
}



struct SearchArtistImage : View{
    var widthAndHeight = CGFloat(Constant.share.Width * (80 / 280) )
    @State var presentPreviewContent = false
    // To pass in data for nextView
    var Title : String = ""
    var Artists : String = ""
    var CoverImage : String = "14"
    var ContentType : String = ""
    var Summary : String = ""
    var RefferenceToContent : String = ""// will be a Url to grab the tree such that all the data can be loaded
    var CreatorsImage : String = ""
    
    @State var OpacityVar : Double = Double(1.0)
    

    var body: some View{

            Image(self.CoverImage)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: self.widthAndHeight, height: self.widthAndHeight, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: CGFloat((Constant.share.Height * (20 / 600)) * (1 / 30) )))
                .opacity(self.OpacityVar)
                .onTapGesture {
                    StateSingleton.share.PassingDataBetweenViews(Image: self.CoverImage, Title: self.Title, Artists: self.Artists, ArtistaImage: self.CreatorsImage)
                    self.OpacityVar = Double(0.5)
                    self.presentPreviewContent.toggle()
                }
                .sheet(isPresented: self.$presentPreviewContent ){
                    PreviewContent()//////  THIS IS WHERE THE TOGGLE HAPPENS AND PRESENTATION HAPPENS
                 }
    }
}




















struct TopEightStories : View{
    var fontSize = CGFloat( Constant.share.Height * (1 / 25) )
    var body: some View{
        VStack(spacing: StateSingleton.share.PaddingFromTheLeadingEdge){
            HStack(){
                Text("Top Stories :")
                    .font(Font(StateSingleton.share.FontType(7, fontSize )))
                    .foregroundColor(.white)
                    .padding([.leading], StateSingleton.share.PaddingFromTheLeadingEdge)
                Spacer()
            }
            ForEach(0..<4){ number in
                TwoEightStoriesView(id: number)
            }
        }
    }
}

 
struct TwoEightStoriesView : View{
    var refData = [ "3" , "9" , "13" , "11"]
    var id : Int
    var body: some View{
        HStack(spacing: StateSingleton.share.PaddingFromTheLeadingEdge){
            EightStoriesView()
            EightStoriesView()
        }
    }
}


struct EightStoriesView : View{
    var widthHeight : CGFloat = CGFloat((Constant.share.Width / 2) - (StateSingleton.share.PaddingFromTheLeadingEdge * 1))
    var body: some View{
        ZStack(alignment: .center){
            Image("12")
                .resizable()
                .scaledToFill()
                .frame(width: self.widthHeight, height: self.widthHeight, alignment: .center)
                .cornerRadius(10)
            
        }.frame(width: self.widthHeight, height: self.widthHeight, alignment: .center)
    }
}
