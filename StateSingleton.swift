//
//  StateSingleton.swift
//  TODD 1.0
//
//  Created by Rabus Mccaleb on 2/7/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import Foundation
import UIKit

class StateSingleton {
    private init(){}
    static var share = StateSingleton()
    
    var HasUsedBefore : Bool?/// for making checking if the user has interacted with this specifc set of content before such that it can check if ther should be or not be function that run to detrmine if there was faved values the user set for this content. This way there won't be any execution of unncessary computing power for new content interaction beyond saving new conent


    /// Data Request functions that take in a stringed location wher to request data fromt the server which is passed from the main view to the major view: All of it's fundemental display needs
    var ImmagineBucketString : String?
    var DiscorsoBucketString : String?
    var MusicheBucketString : String?
    
    func DataRequestImmagineContent(_ URLStingRequest : String)->[UIImage]{
        let ImmagineArrayData : [UIImage] = [UIImage]()
        //RequestDataFromServer
        // Convert it to data
        //parse it via forLoop
        //needs an else case in the event that the data has not been pulled propperly
        return ImmagineArrayData
    }

    func DataRequestDiscorsoContent(_ URLStingRequest : String)->[String?]{
        let DiscorsoArrayData : [String?] = [String?]()
        //RequestDataFromServer
        // Convert it to data
        //parse it via forLoop
        //needs an else case in the event that the data has not been pulled propperly
        return DiscorsoArrayData
    }
    func DataRequestMusicheContent(_ URLStingRequest : String)->[String?]{
        let MusicheArrayData : [String?] = [String?]()
        //RequestDataFromServer
        // Convert it to data
        //parse it via forLoop
        //needs an else case in the event that the data has not been pulled propperly
        return MusicheArrayData
    }
    
    
    /// Image Resize To Optimize Memory Vertical long:
    func VLongResizeImageWithBundle(_ ImageBundle : String?,_ UIImageViewForSize: UIImageView)-> UIImage{
        let ImageResize = max(UIImageViewForSize.bounds.size.width , UIImageViewForSize.bounds.size.height)/// max size of the image to be set is here such that the image placed in the image view is the same size as the image view
        var ImageSize : CGSize = CGSize(width: UIImageViewForSize.bounds.size.width, height: UIImageViewForSize.bounds.size.height)
        let _ = UIImageViewForSize.bounds.size
        // var ImmaggineName : String = SourceFile
        var ContainerImmage : UIImage = #imageLiteral(resourceName: "errorImage-vector-image-PnG") // image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
        
        if let Imagefile = ImageBundle{
            guard let ImageView = UIImage(contentsOfFile: Imagefile) else{
                return #imageLiteral(resourceName: "errorImage-vector-image-PnG")// image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
            }
            
            
            // this is to set the image size and width to an appropriate size that gets clipped and scaled properly:
            var UnscaledImageHeight = ImageView.size.height
            var UnscaledImageWidth = ImageView.size.width
            var ImageViewHeight =  UIImageViewForSize.bounds.size.width
            var newHeight = UnscaledImageHeight * ( ImageViewHeight / UnscaledImageWidth )
            
            ImageSize = CGSize(width: ImageViewHeight , height: newHeight)
            
            
            
            let ImageRender = UIGraphicsImageRenderer(size: ImageSize)/// this is the cg size
            ContainerImmage = ImageRender.image{ _ in ImageView.draw(in : CGRect(origin: .zero , size: ImageSize))
                
            }
        }
        
        return ContainerImmage/// this image has a default set to error displaying uiimage becuase it unless changed by the fact that there is an actual uiimage passed into the container image to be displayed
    }
    
    
    
    
    
    
    
    func VLongResizeAllImageWithImage(_ ImageBundle : UIImage?,_ UIImageViewForSize: UIImageView)-> UIImage{
        let ImageResize = max(UIImageViewForSize.bounds.size.width , UIImageViewForSize.bounds.size.height)/// max size of the image to be set is here such that the image placed in the image view is the same size as the image view
        var ImageSize : CGSize = CGSize(width: UIImageViewForSize.bounds.size.width, height: UIImageViewForSize.bounds.size.height)
        let _ = UIImageViewForSize.bounds.size
        // var ImmaggineName : String = SourceFile
        var ContainerImmage : UIImage = #imageLiteral(resourceName: "errorImage-vector-image-PnG") // image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
        
        if let Imagefile = ImageBundle{
            guard let ImageView = ImageBundle else{
                return #imageLiteral(resourceName: "errorImage-vector-image-PnG")// image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
            }
            
            
            // this is to set the image size and width to an appropriate size that gets clipped and scaled properly:
            var UnscaledImageHeight = ImageView.size.height
            var UnscaledImageWidth = ImageView.size.width
            var ImageViewHeight =  UIImageViewForSize.bounds.size.width
            var newHeight = UnscaledImageHeight * ( ImageViewHeight / UnscaledImageWidth )
            
            ImageSize = CGSize(width: ImageViewHeight , height: newHeight)
            
            
            
            let ImageRender = UIGraphicsImageRenderer(size: ImageSize)/// this is the cg size
            ContainerImmage = ImageRender.image{ _ in ImageView.draw(in : CGRect(origin: .zero , size: ImageSize))
                
            }
        }
        
        return ContainerImmage/// this image has a default set to error displaying uiimage becuase it unless changed by the fact that there is an actual uiimage passed into the container image to be displayed
    }
    
    
    
    
    
    
    
    
    /// Image Resize To Optimize Memory Horizontal long:
    /// Image Resize To Optimize Memory Horizontal long:
    /// Image Resize To Optimize Memory Horizontal long:
    /// Image Resize To Optimize Memory Horizontal long:
    /// Image Resize To Optimize Memory Horizontal long:
    
    func HLongResizeImageWithBundle(_ ImageBundle : String?,_ UIImageViewForSize: UIImageView)-> UIImage{
        let ImageResize = max(UIImageViewForSize.bounds.size.width , UIImageViewForSize.bounds.size.height)/// max size of the image to be set is here such that the image placed in the image view is the same size as the image view
        var ImageSize : CGSize = CGSize(width: UIImageViewForSize.bounds.size.width, height: UIImageViewForSize.bounds.size.height)
        let _ = UIImageViewForSize.bounds.size
        // var ImmaggineName : String = SourceFile
        var ContainerImmage : UIImage = #imageLiteral(resourceName: "errorImage-vector-image-PnG") // image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
        
        if let Imagefile = ImageBundle{
            guard let ImageView = UIImage(contentsOfFile: Imagefile) else{
                return #imageLiteral(resourceName: "errorImage-vector-image-PnG")// image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
            }
            
            
            // this is to set the image size and width to an appropriate size that gets clipped and scaled properly:
            var UnscaledImageHeight = ImageView.size.height
            var UnscaledImageWidth = ImageView.size.width
            var ImageViewHeight =  UIImageViewForSize.bounds.size.height
            var newWidth = UnscaledImageWidth * ( ImageViewHeight / UnscaledImageHeight )
            
            ImageSize = CGSize(width: newWidth , height: ImageViewHeight)

            
            
            let ImageRender = UIGraphicsImageRenderer(size: ImageSize)/// this is the cg size
            ContainerImmage = ImageRender.image{ _ in ImageView.draw(in : CGRect(origin: .zero , size: ImageSize))
                
            }
        }
        
        return ContainerImmage/// this image has a default set to error displaying uiimage becuase it unless changed by the fact that there is an actual uiimage passed into the container image to be displayed
    }
    

    func HLongResizeAllImageWithImage(_ ImageBundle : UIImage?,_ UIImageViewForSize: UIImageView)-> UIImage{
        let ImageResize = max(UIImageViewForSize.bounds.size.width , UIImageViewForSize.bounds.size.height)/// max size of the image to be set is here such that the image placed in the image view is the same size as the image view
        var ImageSize : CGSize = CGSize(width: UIImageViewForSize.bounds.size.width, height: UIImageViewForSize.bounds.size.height)
        let _ = UIImageViewForSize.bounds.size
        // var ImmaggineName : String = SourceFile
        var ContainerImmage : UIImage = #imageLiteral(resourceName: "errorImage-vector-image-PnG") // image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
        
        if let Imagefile = ImageBundle{
            guard let ImageView = ImageBundle else{
                return #imageLiteral(resourceName: "errorImage-vector-image-PnG")// image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
            }
             
            
            // this is to set the image size and width to an appropriate size that gets clipped and scaled properly:
            var UnscaledImageHeight = ImageView.size.height
            var UnscaledImageWidth = ImageView.size.width
            var ImageViewHeight =  UIImageViewForSize.bounds.size.height
            var newWidth = UnscaledImageWidth * ( ImageViewHeight / UnscaledImageHeight )
            
            ImageSize = CGSize(width: newWidth , height: ImageViewHeight)
            
            
            
            let ImageRender = UIGraphicsImageRenderer(size: ImageSize)/// this is the cg size
            ContainerImmage = ImageRender.image{ _ in ImageView.draw(in : CGRect(origin: .zero , size: ImageSize))
                
            }
        }
        
        return ContainerImmage/// this image has a default set to error displaying uiimage becuase it unless changed by the fact that there is an actual uiimage passed into the container image to be displayed
    }
    
    
    var MainUIColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    var ProgressoTrackTint = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)

    func ReturnColor(_ colorValue : Int)-> UIColor{
        var MainUIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        return MainUIColor
    }
    
   
    
    
    
}
