//
//  MainContentModel.swift
//  TODD 1.0
//
//  Created by Rabus Mccaleb on 2/4/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import Foundation

import UIKit

class MaintContentModelDataClass : UIViewController{
    
    
    var DelgateToDropInfo : String?/// for now string such that you don't forget

    var IntImmagine = [[Int : UIImage]]()
    var IntAnimation = [[Int : Int]]()// the animation controlls exist in the maincontent class in a set switch case values
    var IntMuse = [[Int: String? ]]()// will exist as a set of strings to be called when the user is ready for them
    var IntMuseTaper = [[Int : Int]]()// the muse tapering will exist as switch case set of ints to be called to use dependent
    var IntVoice = [[Int: String]]()// this exists for the likely 1:1 voice values
    
    func AppendImmagine(_ LocationIntAppend : Int,_ ImageAppend: UIImage){
        if LocationIntAppend != nil{
            if ImageAppend != nil{
                IntImmagine.append([LocationIntAppend : ImageAppend])// appends the location value to the int...
            }
        }

    }
    func AppendAnimation(_ LocationIntAppend : Int ,_  AnimationIntAppend: Int){
        if AnimationIntAppend != nil {
            if LocationIntAppend != nil {
                IntAnimation.append([LocationIntAppend : AnimationIntAppend])// appends the location value to the int...
            }
        }
    }
    func AppendMuse(_ LocationIntAppend : Int,_ MuseStringAppend : String?){
        if let Muse = MuseStringAppend {
            IntMuse.append([LocationIntAppend : MuseStringAppend])
        }
    }
    func AppendMuseTaper(_ LocationIntAppend : Int , MuseTaperIntAppend : Int){
        
    }
    
    
}
