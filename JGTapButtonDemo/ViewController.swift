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

    @IBAction func flatClicked(_ sender: AnyObject) {
        emojiPopup("🙌")
    }
    
    @IBAction func raisedClicked(_ sender: AnyObject) {
        emojiPopup("😃")
    }
    
    @IBAction func photoClicked(_ sender: AnyObject) {
        emojiPopup("👍🏽")
    }
    
    @IBAction func multilineClicked(_ sender: AnyObject) {
        emojiPopup("㊗️")
    }
    
    @IBAction func rectangleClicked(_ sender: AnyObject) {
        emojiPopup("👽")
    }
    
    @IBAction func githubClicked(_ sender: AnyObject) {
        emojiPopup("1️⃣")
    }
    
    @IBAction func instagramClicked(_ sender: AnyObject) {
        emojiPopup("2️⃣")
    }
    
    @IBAction func linkedinClicked(_ sender: AnyObject) {
        emojiPopup("3️⃣")
    }
    
    @IBAction func pinterestClicked(_ sender: AnyObject) {
        emojiPopup("4️⃣")
    }
    
    @IBAction func twitterClicked(_ sender: AnyObject) {
        emojiPopup("5️⃣")
    }
    
    @IBAction func facebookClicked(_ sender: AnyObject) {
        emojiPopup("6️⃣")
    }
    
    @IBAction func googleplusClicked(_ sender: AnyObject) {
        emojiPopup("7️⃣")
    }
    
    @IBAction func infoClicked(_ sender: AnyObject) {
        infoPopup()
    }
    
    func emojiPopup(_ emoji: String) {
        emojiNotify.mainColor = UIColor.clear
        emojiNotify.paneWidth = 100
        emojiNotify.paneHeight = 100
        emojiNotify.paneXcenterOffset = 100
        emojiNotify.paneShowYposition = 80
        
        emojiNotify.paneShowVisibleTime = 0.6
        
        emojiNotify.setMessage(emoji: emoji)
        emojiNotify.show()
    }
    
    func infoPopup() {
        emojiNotify.mainColor = UIColor.cyan
        emojiNotify.paneWidth = 280
        emojiNotify.paneHeight = 280
        emojiNotify.paneXcenterOffset = 0
        emojiNotify.paneShowYposition = 20
        
        emojiNotify.paneShowVisibleTime = 2.0
        
        emojiNotify.setMessage(emoji: "", title: "JGTapButton", message: "copyright 2015 \rcreated by: Jeff Greenberg")
        emojiNotify.show()
    }

}

