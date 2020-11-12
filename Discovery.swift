//
//  ContentView.swift
//  TODD 1.0
//
//  Created by Rabus Mccaleb on 1/30/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import SwiftUI

struct Discovery : View {
    var classCall = StateSingleton.share
    var body: some View {
        
        
   
HStack(){
    
    ZStack {
        ScrollView {
            
            VStack(alignment: .center){
                Image("108")
                    .resizable().scaledToFill()
                    .frame(width: 150, height: 25, alignment: .center).cornerRadius(100)
                }
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading){ Text("Discovery").foregroundColor(Color(self.classCall.MainUIColor))
                    .font(.largeTitle)
                    .font(.custom("Avenir-Next-Bold", size: 48))
                    .bold()
                    
                    Text("ARTIST")
                    
                    Button(action: {
                        self.classCall.PlayASong()

                    }) {
                        Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                    }
                }
                TopViewForHorizontalCircleRecommndations()
                
                Text("Our Picks")
                .offset(x: CGFloat(-155))
                
                ViewForMainRecommendation()// scroll view for MainImages
                ViewForBottomRecommendations()
                
            }.padding(.leading, 16.0)
        }// end of scroll view brackets
            
            HStack(){
            ViewForBottomTabControl()// second ZStack
            }.padding(.bottom , 32.0)
    }//zstack end bracket
    }// end of HStack Brackets
    
        
        
        

        
        
        
    }//end of body of main struct
    
    
}//end of struct view




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Discovery()
    }
}








//// extracted subviews
struct ViewForMainRecommendation: View {
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing : 40) {
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 450, alignment: .leading)
                    .cornerRadius(25.0)
                    .shadow(radius: 5.0)
                
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 285, height: 425, alignment: .leading)
                    
                    .cornerRadius(25.0)
                
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 285, height: 425, alignment: .leading)
                    
                    .cornerRadius(25.0)
                
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 285, height: 425, alignment: .leading)
                    
                    .cornerRadius(25.0)
                
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 285, height: 425, alignment: .leading)
                    
                    .cornerRadius(25.0)
            }
            
            
        }
    }
}

struct ViewForBottomRecommendations: View {
    var body: some View {
        VStack(){
            Text("Genre")
                .offset(x: CGFloat(-165))
            ScrollView(.horizontal){
                HStack(spacing: 20){
                    Image("108")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200, alignment: .leading)
                        .cornerRadius(25.0)
                    
                    Image("108")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200, alignment: .leading)
                        .cornerRadius(25.0)
                    Image("108")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200, alignment: .leading)
                        .cornerRadius(25.0)
                    
                    Image("108")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200, alignment: .leading)
                        .cornerRadius(25.0)
                    
                    Image("108")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200, alignment: .leading)
                        .cornerRadius(25.0)
                    
                    Image("108")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 200, alignment: .leading)
                        .cornerRadius(25.0)
                }// Genre brackets hstack
            }//Genre bracket scrollview
        }
    }
}



struct TopViewForHorizontalCircleRecommndations: View {
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing: 15){
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85, alignment: .topLeading)
                    .cornerRadius(100.0)
                
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85, alignment: .topLeading)
                    .cornerRadius(100.0)
                
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85, alignment: .topLeading)
                    .cornerRadius(100.0)
                
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85, alignment: .topLeading)
                    .cornerRadius(100.0)
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85, alignment: .topLeading)
                    .cornerRadius(100.0)
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85, alignment: .topLeading)
                    .cornerRadius(100.0)
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85, alignment: .topLeading)
                    .cornerRadius(100.0)
                Image("108")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85, alignment: .topLeading)
                    .cornerRadius(100.0)
                
            }
        }
    }
}

