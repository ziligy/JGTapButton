//
//  ViewController.swift
//  JGTapButtonDemo
//
//  Created by Jeff on 9/11/15.
//
//

import UIKit

class ViewController: UIViewController {
    
    var emojiNotify: JGEmojiNotify!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiNotify = JGEmojiNotify()
        emojiNotify.paneHideYposition = 1000
        
        view.addSubview(emojiNotify)
    }

    @IBAction func flatClicked(sender: AnyObject) {
        emojiPopup("🙌")
    }
    
    @IBAction func raisedClicked(sender: AnyObject) {
        emojiPopup("😃")
    }
    
    @IBAction func photoClicked(sender: AnyObject) {
        emojiPopup("👍🏽")
    }
    
    @IBAction func multilineClicked(sender: AnyObject) {
        emojiPopup("㊗️")
    }
    
    @IBAction func rectangleClicked(sender: AnyObject) {
        emojiPopup("👽")
    }
    
    @IBAction func githubClicked(sender: AnyObject) {
        emojiPopup("1️⃣")
    }
    
    @IBAction func instagramClicked(sender: AnyObject) {
        emojiPopup("2️⃣")
    }
    
    @IBAction func linkedinClicked(sender: AnyObject) {
        emojiPopup("3️⃣")
    }
    
    @IBAction func pinterestClicked(sender: AnyObject) {
        emojiPopup("4️⃣")
    }
    
    @IBAction func twitterClicked(sender: AnyObject) {
        emojiPopup("5️⃣")
    }
    
    @IBAction func facebookClicked(sender: AnyObject) {
        emojiPopup("6️⃣")
    }
    
    @IBAction func googleplusClicked(sender: AnyObject) {
        emojiPopup("7️⃣")
    }
    
    @IBAction func infoClicked(sender: AnyObject) {
        infoPopup()
    }
    
    func emojiPopup(emoji: String) {
        emojiNotify.mainColor = UIColor.clearColor()
        emojiNotify.paneWidth = 100
        emojiNotify.paneHeight = 100
        emojiNotify.paneXcenterOffset = 100
        emojiNotify.paneShowYposition = 80
        
        emojiNotify.paneShowVisibleTime = 0.6
        
        emojiNotify.setMessage(emoji: emoji)
        emojiNotify.show()
    }
    
    func infoPopup() {
        emojiNotify.mainColor = UIColor.cyanColor()
        emojiNotify.paneWidth = 280
        emojiNotify.paneHeight = 280
        emojiNotify.paneXcenterOffset = 0
        emojiNotify.paneShowYposition = 20
        
        emojiNotify.paneShowVisibleTime = 2.0
        
        emojiNotify.setMessage(emoji: "", title: "JGTapButton", message: "copyright 2015 \rcreated by: Jeff Greenberg")
        emojiNotify.show()
    }

}

