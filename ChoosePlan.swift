//
//  ChoosePlan.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 3/11/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//
import Foundation
import UIKit
import SwiftUI
import Combine

struct ChoosePlan: View {
    var body: some View {
        ZStack(alignment: .bottom){
            choosePlanBackground().alignmentGuide(.top, computeValue: {d in d[.top]}).edgesIgnoringSafeArea(.top)
            LogoChoosePlan().alignmentGuide(.top, computeValue: {d in d[.top]})
            VStack{
                WhiteTab().alignmentGuide(.bottom, computeValue: {d in d[.bottom]})
            }
            ChoosePlanUIOnTabView().alignmentGuide(.leading, computeValue: {d in d[.leading]})
        }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .center)
    }
}

struct ChoosePlan_Previews: PreviewProvider {
    static var previews: some View {
        ChoosePlan()
    }
}




struct leftImageChoosePlan : View{
    var leftImageRefference = "2"
    var Width = CGFloat(Constant.share.Width * CGFloat(0.5))
    var body : some View{
        HStack(alignment : .center){
        Image(self.leftImageRefference)
        .resizable()
        .scaledToFill()
            .frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .bottom)
            .clipped()
            
        }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .bottom)
    }
}


struct rightImageChoosePlan : View{
    var rightImageRefference = "108"
    var Width = CGFloat(Constant.share.Width * CGFloat(0.5))
    var body : some View{
        Image(self.rightImageRefference)
        .resizable()
        .scaledToFill()
        .frame(width: self.Width, height: Constant.share.Height, alignment: .center)
        .clipped()
    }
}


struct choosePlanBackground : View {
    var Width = CGFloat(Constant.share.Width * CGFloat(0.5))
    var body : some View{
        ZStack(alignment : .top){
            HStack(spacing : 5.0){
                leftImageChoosePlan().frame(width: self.Width, height: Constant.share.Height, alignment: .bottom).clipped()
                rightImageChoosePlan().frame(width: self.Width, height: Constant.share.Height, alignment: .bottom).clipped()
            }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .top).edgesIgnoringSafeArea(.all)
                WhiteBackGround()
        }
    }
}

// BackGroundCover :
struct WhiteTranslucentBackgroundCover : Shape {
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
        }
    }
}

struct WhiteBackGround : View {
    
    var body : some View {
        WhiteTranslucentBackgroundCover().fill(Color(StateSingleton.share.LoginBackgroundColor))
            //.fill(style: Color(StateSingleton.share.LoginBackgroundColor))
        
    }
}

struct WhiteTab : View {
    var CRadius : CGFloat = 25.0
    var Height = CGFloat(Constant.share.Height * (5 / 6))
    var body : some View{
        HStack{
            SquareTab()
                .fill(Color.white)
                .frame(width: Constant.share.Width, height: self.Height, alignment: .bottom)
                .cornerRadius(self.CRadius)
                .alignmentGuide(.bottom, computeValue: {d in d[.bottom]})
                .shadow(color: .black, radius: 6.0, x: 0.0, y: 4.0)
        }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .bottom)
    }
}

struct LogoChoosePlan : View{
    var widthAndHeight = CGFloat(Constant.share.Width / (5))
    var body : some View{
        HStack(alignment : .top){
        Image("ToddLogo")
        .resizable()
        .scaledToFit()
        .frame(width: widthAndHeight, height: widthAndHeight, alignment: .top)
        }.frame(width: Constant.share.Width, height: Constant.share.Height, alignment: .top)
    }
    
}
struct SquareTab : Shape{
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }//Path
    }//path func
}// struct

struct OverlaySquareTab : Shape{
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }//Path
    }//path func
}// struct

struct ChoosePlanUIOnTabView : View {
    var body : some View{
        VStack(spacing : 20.0){
            WelcomeTitolo().padding([.top , .leading], StateSingleton.share.PaddingFromTheLeadingEdge)
            WelcomePageSummary()
            MakeSelection()
            selectionButtons()
            OkayButton()
        }.frame(width: Constant.share.Width, height: WhiteTab().Height, alignment: .top)
    }
}


struct WelcomeTitolo : View {
    var body : some View {
        VStack(alignment : .leading){
                    Text("""
                        Welcome
                        To Toddlit
                        """).font(Font(StateSingleton.share.FontType(7, Constant.share.IphoneTitleFontSize))).multilineTextAlignment(.leading)
        }.frame(width: Constant.share.Width, alignment: .leading)
                     
    }// body
}//struct

struct WelcomePageSummary : View {
    var body : some View {
        Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.")
            .font(Font(StateSingleton.share.FontType(5, CGFloat(18.0))))
            .foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
            .multilineTextAlignment(.leading)
            .padding([.leading , .trailing], StateSingleton.share.PaddingFromTheLeadingEdge)
    }
}

struct MakeSelection : View {
    var body: some View {
        Text("Make a selection:")
        .font(Font(StateSingleton.share.FontType(5, CGFloat(22.0))))
        .foregroundColor(Color.black)
    }
}

struct OkayButton : View {
    /// By making this VariableBased I can reuse it
    var SelectionButtonText = "Okay"
    var ButtonWidth : CGFloat = CGFloat(Constant.share.Width * (180 / 300))
    var ButtonHeight : CGFloat = CGFloat(Constant.share.Height * (46 / 600))
    var ButtonRadius : CGFloat = CGFloat(8.0)
    var ShadowXPostion : CGFloat = CGFloat(0.0)
    var ShadowYPostion : CGFloat = CGFloat(8.0)
    var body : some View{
    Button(action : {
    // action for selection here
    }){
        ZStack{
            Capsule()
                .fill(Color(StateSingleton.share.ToddMainUIColor))
                .frame(width: self.ButtonWidth, height: self.ButtonHeight, alignment: .center)
                .shadow(color: Color(StateSingleton.share.ToddMainUIColorShadow), radius: self.ButtonRadius, x: self.ShadowXPostion, y: self.ShadowYPostion)
            Text(self.SelectionButtonText)
            .font(Font(StateSingleton.share.FontType(5, CGFloat(22.0))))
            .foregroundColor(Color.white)
            .frame(width: self.ButtonWidth, height: self.ButtonHeight, alignment: .center)
            
            
        }//zstack
        
    }//Button Modifer
    }// Body
}// Struct


struct LeftSelectionShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: CGFloat(rect.maxX * (0.80))  , y: rect.minY))
            path.addLine(to: CGPoint(x: CGFloat(rect.maxX * (0.80)), y : rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
          }
    }
}


struct RightSelectionShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        Path{ path in
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX , y : rect.maxY))
            path.addLine(to: CGPoint(x: CGFloat(rect.minX + (rect.maxX * (0.20))) , y: rect.maxY))
            path.addLine(to: CGPoint(x: CGFloat(rect.minX + (rect.maxX * (0.20))) , y:  rect.minY))
          }
    }
}

struct selectionButtons : View{
    var body : some View{
        HStack{
            LeftSelectionButton().padding(.leading, StateSingleton.share.PaddingFromTheLeadingEdge)
            
            RightSelectionButton().padding(.trailing, StateSingleton.share.PaddingFromTheLeadingEdge)
        }// HStack
        }
}

 
struct RightSelectionButton : View {
    var Width = CGFloat(Constant.share.Width * (125 / 300))/// set to 25 because the objects them selves stop at 25/% of the fram so increasing the size by 25 percent means the views will be less tiny. In esscence I'm offsetting my math done from drawing the path to avoid corner radius issues
    var Height = CGFloat(Constant.share.Height * (180 / 600))
    @State var Selection = FreeTierSubscriptionTier(ID: StateSingleton.share.IDStringForTierSelection, TierWasSelected: StateSingleton.share.TierWasSelected, FreeTier: StateSingleton.share.FreeTierBooleanSelected, SubscriptionTier: StateSingleton.share.SubsciptionTierSelected)
    var body : some View {
    Button(action : {
        self.Selection.TierWasSelected = true
        self.Selection.FreeTierBoolean = false
        self.Selection.SubsciptionTier = true
        
        if self.Selection.TierWasSelected == true && self.Selection.FreeTierBoolean == true && self.Selection.SubsciptionTier == false{
            StateSingleton.share.FreeSubColorTabShadowColor = StateSingleton.share.FreeSubColorTabColor
            
            print(self.Selection.TierWasSelected)
            print(self.Selection.FreeTierBoolean)
            print(self.Selection.SubsciptionTier)
        }else{
            StateSingleton.share.FreeSubColorTabShadowColor = StateSingleton.share.NoTierSelectionColor
        }// bracket
        
    }){
        ZStack{
            RightSelectionShape().fill(Color.white).frame(width: self.Width, height: self.Height, alignment: .trailing).cornerRadius(25.0).shadow(color: Color(StateSingleton.share.FreeSubColorTabShadowColor), radius: 5.0, x: 0.0, y: 4.0)
        VStack{
            Text("Subscription").font(Font(StateSingleton.share.FontType(5, 18.0))).foregroundColor(Color.black)
            Text("- Unlimited Downloads").font(Font(StateSingleton.share.FontType(5, 10.0))).foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
            Text("- With Ads").font(Font(StateSingleton.share.FontType(5, 10.0))).foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
            Text("- Unlimited Views").font(Font(StateSingleton.share.FontType(5, 10.0))).foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
            }//VStack
        }.frame(width: self.Width, height: self.Height, alignment: .trailing)//Zstack
        }//button
    }//view
}//struct

struct LeftSelectionButton : View {
    @State var Selection = FreeTierSubscriptionTier(ID: StateSingleton.share.IDStringForTierSelection, TierWasSelected: StateSingleton.share.TierWasSelected, FreeTier: StateSingleton.share.FreeTierBooleanSelected, SubscriptionTier: StateSingleton.share.SubsciptionTierSelected)
    var ShadowColor : UIColor = StateSingleton.share.ShadowColor
    var Width = CGFloat(Constant.share.Width * (125 / 300))/// set to 25 because the objects them selves stop at 25/% of the fram so increasing the size by 25 percent means the views will be less tiny. In esscence I'm offsetting my math done from drawing the path to avoid corner radius issues
    var Height = CGFloat(Constant.share.Height * (180 / 600))
    var body : some View {
        
        Button(action : {
            self.Selection.TierWasSelected = true
            self.Selection.FreeTierBoolean = true
            self.Selection.SubsciptionTier = false
            
            if self.Selection.TierWasSelected == true && self.Selection.FreeTierBoolean == true && self.Selection.SubsciptionTier == false{
                StateSingleton.share.FreeSubColorTabShadowColor = StateSingleton.share.FreeSubColorTabColor
                print(self.Selection.TierWasSelected)
                print(self.Selection.FreeTierBoolean)
                print(self.Selection.SubsciptionTier)
            }else{
                StateSingleton.share.FreeSubColorTabShadowColor = StateSingleton.share.NoTierSelectionColor
            }// bracket
            
        }){
        ZStack{
                    LeftSelectionShape().fill(Color.white).frame(width: self.Width, height: self.Height, alignment: .trailing).cornerRadius(25.0).shadow(color: Color(StateSingleton.share.FreeSubColorTabShadowColor), radius: 5.0, x: 0.0, y: 4.0)
        VStack{
            Text("Free").font(Font(StateSingleton.share.FontType(5, 18.0))).foregroundColor(Color.black)
            Text("- Unlimited Views").font(Font(StateSingleton.share.FontType(5, 10.0))).foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
            Text("- With Ads").font(Font(StateSingleton.share.FontType(5, 10.0))).foregroundColor(Color(StateSingleton.share.FiftyPercentBlack))
            }//VStack
        }.frame(width: self.Width, height: self.Height, alignment: .trailing)//Zstack
        }
    }
}

class ChoosePlanObserverObjects : ObservableObject {
    let FreeTier = PassthroughSubject<ChoosePlanObserverObjects,Never>()
    let SubscriptionTier = PassthroughSubject<ChoosePlanObserverObjects,Never>()
    var FreeTierSelected : Bool = false {
        didSet {
            FreeTier.send(self)
        }
    }
    var SubscriptionTierSelected : Bool = false {
        didSet{
            SubscriptionTier.send(self)
        }
    }
}

struct FreeTierSubscriptionTier : Identifiable{
    var id : String
    var TierWasSelected : Bool //defalted to false
    var SubsciptionTier : Bool
    var FreeTierBoolean : Bool
    init(ID : String, TierWasSelected : Bool, FreeTier : Bool , SubscriptionTier : Bool ) {
        self.id = ID
        self.SubsciptionTier = SubscriptionTier
        self.FreeTierBoolean = FreeTier
        self.TierWasSelected = TierWasSelected
        
    }
}
