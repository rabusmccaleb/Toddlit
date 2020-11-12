//
//  Content.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 11/8/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//
import Foundation
import WebKit
import SwiftUI

struct ContentWeb : UIViewRepresentable {
    //https://help.alchemer.com/help/url-variables
    @ObservedObject var checkingIfSignedIn = isSigned()// to insure that we get the propper id placed in the url
//    var url = "https://www.toddlit.com/ContentView/ContentView.html?userid=\(StateSingleton.share.userId)&\(StateSingleton.share.profileNumber)"
//    var url = "https://www.toddlit.com/ContentView/ContentView.html"
    
    var url : String = "https://www.toddlit.com/ContentView/ContentView.html?storyRef=\(StateSingleton.share.StoryRef)&userID=\(StateSingleton.share.userId)&profileNumber=\(StateSingleton.share.profileNumber)#"// this hastag is terribly important ... it demarks the end of the url search path
    
    func makeUIView(context: Context) -> some WKWebView {
        // clear the cache from previous webviews
        self.clearCache()
        // create the WKWebView Url
        guard let url = URL(string: self.url) else{
            return WKWebView()
        }
        print(url)
        // Set Up the Request
        let request = URLRequest(url: url)
        let wkWebview = WKWebView()
        wkWebview.load(request)
        return wkWebview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
    
    
    
    func clearCache(){
        // Thanks to people on stackoverflow : https://stackoverflow.com/questions/27105094/how-to-remove-cache-in-wkwebview
        
        if #available(iOS 9.0, *) {
          let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
          let date = NSDate(timeIntervalSince1970: 0)
            WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date as Date, completionHandler:{ })
        } else {
            var libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, false).first!
            libraryPath += "/Cookies"

            do {
                try FileManager.default.removeItem(atPath: libraryPath)//defaultManager().removeItemAtPath(libraryPath)
            } catch {
              print("error")
            }
            URLCache.shared.removeAllCachedResponses()
        }
    }
    
}










