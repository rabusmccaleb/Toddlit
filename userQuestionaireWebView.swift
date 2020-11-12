//
//  userQuestionaireWebView.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 11/3/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import Foundation
import WebKit
import SwiftUI
//The User will have to sign in again in on WKWebView that pulls up for them to take the questionaire. Don't lie to them
// Let them know that the sign up is for keeping a clear connection between their data. There is a low probability that they
// will care it's not perfect as far as user experiecne is concerned but the requirements of adding highly complex code around
// user tokens and authorization data to passed through a url and HTTP Reqests using type script, angularJS, and cloud
// functions for a simple and nondenominational behavior is foolish. Just Build the page in html, css, and JS and have the
// User sign in. The let them do the questionaire. Also it allows for a easier work flow and more dynamic ideas for that
//particular feature. Rather tha building thing it native in ios and android. That may change in the future. But for now that
// that will be a web based interaction.
struct userWebQuestionaire : UIViewRepresentable {
    var url = "google.com"
    func makeUIView(context: Context) -> some WKWebView {
        guard let url = URL(string: self.url) else{
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let wkWebview = WKWebView()
        wkWebview.load(request)
        return wkWebview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
    
}




