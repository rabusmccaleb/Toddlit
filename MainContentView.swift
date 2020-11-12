//
//  MainContentView.swift
//  TODD 1.0
//
//  Created by Rabus Mccaleb on 2/3/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import Foundation
import UIKit


class MainContentView: MainContentController {
    /// Created from the UI Design From left to right top to bottom:
    @IBOutlet weak var previousButton : UIButton!
    @IBOutlet weak var dimissMainContentView : UIButton!
    @IBOutlet weak var storeFavorite : UIButton!
    @IBOutlet weak var viewLocation : UILabel!
    @IBOutlet weak var moreControlButton : UIButton!
    @IBOutlet weak var nextButton : UIButton!
    /// Viewing Control
    @IBOutlet weak var ContentForViewing : UIView!
    @IBOutlet weak var ImmagineView : UIImageView!
    @IBOutlet weak var ContentViewLable : UILabel!//Optional For the User
    @IBOutlet weak var BackGroundView : UIView!// for background behind view... set for dark theme, and set for light mode... so either black because the content is mean to be black or black because currently in dark mode. About four times bigger than all views... such that animations can happen ins such away that views can shake an move and still look appropriate
    
    @IBOutlet weak var uiContentTitoloLabel : UILabel!
    @IBOutlet weak var uiArtistaLable : UILabel!
    @IBOutlet weak var uiAutoPlayButton : UIButton!
    @IBOutlet weak var uIProgresso : UIProgressView!
    
    var ImmagineArray : [UIImage] = [UIImage]()
    var discorsoArray : [String?] = [String?]()
    var MusicheArray : [String?] = [String?]()
    var CurrentProgress : Int?// incremental value that updates at the users whim
    var TotalProgress : Int?// Should be the number of objects in the array
    
    /// Order function calls for setup and exit:
    override func viewWillAppear(_ animated: Bool) {
        DisplayProgressoStlye()// display the progresso and it's stlye before the view loads
        callRequestFromSingleton()//Call this function to make request for the three major data needs
    }
    
    override func viewDidLoad() {
        //should check if server data did load to 25% before actively showing actual content data
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // check if this is true before presenting view conent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }
    
    func callRequestFromSingleton(){
        ///Discorso
        if let DiscorsoString =  StateSingleton.share.DiscorsoBucketString{
        DiscorsoRequest(StateSingleton.share.DataRequestDiscorsoContent(StateSingleton.share.DiscorsoBucketString!))
        }else{
            //call error function
        }
        
        ///Imaggine
        if let ImmagineString =  StateSingleton.share.ImmagineBucketString{
            ImmagineRequest(StateSingleton.share.DataRequestImmagineContent(StateSingleton.share.ImmagineBucketString!))
        }else{
            //call error function
        }
        
        ///Musiche
        if let MusicheString = StateSingleton.share.MusicheBucketString{
            MusicheRequest(StateSingleton.share.DataRequestMusicheContent(StateSingleton.share.MusicheBucketString!))
        }else{
            // call error function
        }
    }
    
    func DiscorsoRequest(_ DiscorsoRequest : [String?]){
        discorsoArray = DiscorsoRequest
    }
    func ImmagineRequest(_ ImmagineRequest : [UIImage]){
        ImmagineArray = ImmagineRequest// this is the data being requested from server to add into array for consumption
    }
    func MusicheRequest(_ MusicheRequest : [String?]){
        if MusicheRequest.isEmpty == false {
            MusicheArray = MusicheRequest
        }else{
            ErrorFuction(0)
        }// first checking if the array is empty otherwise throw up an error... there needs to be an error function to handle errors
    }
    
    func DisplayProgressoStlye(){
        uIProgresso.trackTintColor = StateSingleton.share.ProgressoTrackTint// setting the track tint for the progresso
        uIProgresso.layer.cornerRadius = 100.0 // setting the corner radius to be a full curve.. if ther are any problems they lie here
    }
    func UpdaterFunction(){
        if let max = TotalProgress {
            if let Current = CurrentProgress {// moving objects over
                if CurrentProgress! < max {
                    CurrentProgress! = CurrentProgress! + 1// if less than update value
                }else{
                     CurrentProgress = max - 1// if greater than the max make equal
                }
            }
        }
    }
    
    func DownDaterFunction(){
        if let Current = CurrentProgress{
            if Current > 0 {
                CurrentProgress! = CurrentProgress! - 1
            }else{
                CurrentProgress = 0// so if less than the obvious minvalue of one make it equal to one
            }
        }
    }
    
    var ImageObject : UIImage?
    func UpdatingTheSubView(){// this method is called often so it needs to be light weight
        var Max = ImmagineArray.count - 1
        if let Current = CurrentProgress{
            if CurrentProgress! < Max {
                ImageObject = StateSingleton.share.VLongResizeAllImageWithImage(ImmagineArray[CurrentProgress!], ImmagineView)// so this resizes the image and returns it to the view with the proper size
                ImmagineView.image = ImageObject
            }
        }
    }
    
    func ProgressUpadater(){
        if let current = CurrentProgress {
            var ProgressRatio = Float(CurrentProgress! / ImmagineArray.count - 1)
           uIProgresso.setProgress(ProgressRatio, animated: true)// setting the value to the current progress value and animatig it's transition
            
        }
    }
    
    func ErrorFuction(_ errorTypeValue : Int){
        switch errorTypeValue{
        case 0 :
            print("Musiche_Array_IsEmpty")
            
            break
        default :
            print("Of_Uknown_ErroType")
            break
        }
    }

    /// Animation option values to be passed from a jsonFile to the views and meant to be unwrapped if need be:
    var duration : TimeInterval?
    var delay : TimeInterval?
    var springDamping : CGFloat?
    var springVelocity : CGFloat?
    var viewOptions : UIView.AnimationOptions?
    
    
    func SwitchAnimation(_ animationInt : Int ){
        switch animationInt{
        case 0:
            Animation0()
            break
        case 1:
            
            break
        default:
            break
        }
    }
    
    func checkIfAnimationDataIsThere()-> Bool{
        if duration != nil && delay != nil && springDamping != nil && springVelocity != nil && viewOptions != nil{
            
                return true
            }else{
                return false
        }
    }
    func Animation0(){
        /// Simple Animation For moving an object up horizontally
        var animationFuncValue = 0
        if checkIfAnimationDataIsThere() == true{
        //Horizontal Animation of view object accross the screen
        self.ContentForViewing.transform = CGAffineTransform(translationX: 1000, y: 0)//ample amount of horizontal space to slide object accross the view.
        UIView.animate(withDuration: duration!, delay: delay!, usingSpringWithDamping: springDamping!, initialSpringVelocity: springVelocity!, options: viewOptions!, animations: {()-> Void in
            self.ContentForViewing.transform = CGAffineTransform(translationX: 0, y: 0)/// the object is slid smoothly or speedingly across the screen
            
        }, completion: nil)
            
        }else{
            print("All_The_Data_For_'AnimationStyle' \(animationFuncValue)--Not_Availbe")
        }//checking if the nessary data is there for performing the animation
    }// end of animatio 0 brackets
    
    func Animation1(){
        /// Simple Animation For moving an object up vertically
        var animationFuncValue = 1
        if checkIfAnimationDataIsThere() == true{
        //Horizontal Animation of view object accross the screen
        self.ContentForViewing.transform = CGAffineTransform(translationX: 0, y: 1000)//ample amount of horizontal space to slide object accross the view.
        UIView.animate(withDuration: duration!, delay: delay!, usingSpringWithDamping: springDamping!, initialSpringVelocity: springVelocity!, options: viewOptions!, animations: {()-> Void in
            self.ContentForViewing.transform = CGAffineTransform(translationX: 0, y: 0)/// the object is slid smoothly or speedingly across the screen
            
        }, completion: nil)
            
        }else{
            print("All_The_Data_For_'AnimationStyle' \(animationFuncValue)--Not_Availbe")
        }//checking if the nessary data is there for performing the animation
    }// end of animation 1 brackets
    
    func Animation2(){
                /// Simple Animation For moving an object for shaking the view horizontally in an occillar motion
        var animationFuncValue = 2
        var numberOfShakes = 10
        var x = 0
            if checkIfAnimationDataIsThere() == true || checkIfAnimationDataIsThere() == false{

                UIView.animate(withDuration: 0.1, animations: {()-> Void in
                self.ContentForViewing.transform = CGAffineTransform(translationX: -10, y: 0)
                }, completion: {(Boolean : Bool)-> Void in
                    //completion handler
                UIView.animate(withDuration: 0.1, animations: {()-> Void in
                self.ContentForViewing.transform = CGAffineTransform(translationX: 10, y: 0)
                       }, completion: {(Boolean : Bool)-> Void in
                    //completion handler
                UIView.animate(withDuration: 0.1, animations: {()-> Void in
                self.ContentForViewing.transform = CGAffineTransform(translationX: -10, y: 0)
                }, completion: {(Boolean : Bool)-> Void in
                    //completion handler
                UIView.animate(withDuration: 0.1, animations: {()-> Void in
                self.ContentForViewing.transform = CGAffineTransform(translationX: 10, y: 0)
                                           }, completion: {(Boolean : Bool)-> Void in
                    //completion handler
                UIView.animate(withDuration: 0.1, animations: {()-> Void in
                self.ContentForViewing.transform = CGAffineTransform(translationX: -10, y: 0)
                                                   }, completion: {(Boolean : Bool)-> Void in
                    //completion handler
                UIView.animate(withDuration: 0.1, animations: {()-> Void in
                self.ContentForViewing.transform = CGAffineTransform(translationX: 0, y: 0)
                                                    }, completion: nil) }) }) }) }) })
                
                }else{
                    print("All_The_Data_For_'AnimationStyle' \(animationFuncValue)--Not_Availbe")
                }//checking if the nessary data is there for performing the animation
        
        }// end of animation 2 brackets
    
    
}//end of class bracket
