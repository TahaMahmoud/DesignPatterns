// Chain of Responsibility Pattern
// Download Video App.

import Foundation

protocol Handler: class {
    
    var nextHandler: Handler? { get set }

    func setNext(handler: Handler) -> Handler
    func handleLink(url: String)
}

extension Handler {
    
    func setNext(handler: Handler) -> Handler {
        self.nextHandler = handler

        return handler
    }

    func handleLink(url: String) {
        nextHandler?.handleLink(url: url)
    }

}

class YoutubeHandler: Handler {
    
    var nextHandler: Handler?
    
    func handleLink(url: String) {
        if url.lowercased().contains("youtube") {
            print("Video Downloaded From Youtube Successfully")
        }
        else {
            print("Youtube Failed To Download Link, Trying Another Website ...")
            nextHandler?.handleLink(url: url)
        }
    }
    
}

class FacebookHandler: Handler {
    
    var nextHandler: Handler?

    func handleLink(url: String) {
        if url.lowercased().contains("facebook") {
            print("Video Downloaded From Facebook Successfully")
        }
        else {
            print("Facebook Failed To Download Link, Trying Another Website ...")
            nextHandler?.handleLink(url: url)
        }
    }
    
}

class InstagramHandler: Handler {
    
    var nextHandler: Handler?
    
    func handleLink(url: String) {
        if url.lowercased().contains("instagram") {
            print("Video Downloaded From Instagram Successfully")
        }
        else {
            print("Instagram Failed To Download Link, Trying Another Website ...")
            nextHandler?.handleLink(url: url)
        }
    }
    
}

// Client

let youtubeVideoLink = "https://www.youtube.com/watch?v=fHd999MsBGo"
let facebookVideoLink = "https://www.facebook.com"
let instagramVideoLink = "https://www.instagram.com"

var youtubeHandler: Handler = YoutubeHandler()
var facebookHandler: Handler = FacebookHandler()
var instagramHandler: Handler = InstagramHandler()

youtubeHandler.setNext(handler: facebookHandler)
facebookHandler.setNext(handler: instagramHandler)

youtubeHandler.handleLink(url: youtubeVideoLink)
// facebookHandler.handleLink(url: facebookVideoLink)
// instagramHandler.handleLink(url: instagramVideoLink)
