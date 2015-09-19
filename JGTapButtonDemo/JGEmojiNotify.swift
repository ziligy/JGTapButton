//
//  JGEmojiNotify.swift
//
//  Created by Jeff on 9/14/15.
//  Copyright © 2015 Jeff Greenberg. All rights reserved.
//

import UIKit

public class JGEmojiNotify: UIView {
    
    // MARK: Public variables
    public var mainColor = UIColor.cyanColor() {
        didSet {
            backgroundColor = mainColor
        }
    }
    
    public var paneWidth: CGFloat = 240 {
        didSet {
            if let _ = anchorWidth {
                anchorWidth.constant = paneWidth
            }
        }
    }
    
    public var paneHeight: CGFloat  = 120 {
        didSet {
            if let _ = anchorHeight {
                anchorHeight.constant = paneHeight
            }
        }
    }
    
    public var paneXcenterOffset: CGFloat = 0 {
        didSet {
            if let _ = anchorCenter {
                anchorCenter.constant = paneXcenterOffset
            }
        }
    }
    
    public var paneShowYposition: CGFloat = 50
    
    public var paneHideYposition: CGFloat = -120 {
        didSet {
            if let _ = topBoxConstraint {
                topBoxConstraint.constant = paneHideYposition
            }
        }
    }
    
    public var paneShowVisibleTime: NSTimeInterval = 0.8
    public var paneSlideAnimationTime: NSTimeInterval = 0.2
    
    
    // MARK: Private variables
    
    private var anchorWidth: NSLayoutConstraint!
    private var anchorHeight: NSLayoutConstraint!
    private var anchorCenter: NSLayoutConstraint!
    
    private var topBoxConstraint: NSLayoutConstraint!
    
    private var emoji = UILabel()
    private var title = UILabel()
    private var message = UITextView()
    
    private var emojiFontSize: CGFloat!
    private var titleFontSize: CGFloat!
    private var messageFontSize: CGFloat!
    
    
    private let mainStackView = UIStackView()
    private let textStackView = UIStackView()
    
    
    // MARK: Public Functions
    public func setMessage(
        emoji emoji: String = "🙌",
        title: String = "",
        message: String = "",
        emojiFontSize: CGFloat = 68,
        titleFontSize: CGFloat = 18.0,
        messageFontSize: CGFloat = 12.0)
    {
        
        self.emoji.text = emoji
        self.title.text = title
        self.message.text = message
        
        self.emoji.font = UIFont.systemFontOfSize(emojiFontSize)
        self.title.font = UIFont.systemFontOfSize(titleFontSize)
        self.message.font = UIFont.systemFontOfSize(messageFontSize)
        
        self.emoji.hidden = self.emoji.text!.isEmpty
        self.title.hidden = self.title.text!.isEmpty
        self.message.hidden = self.message.text.isEmpty
        
        if self.message.text.isEmpty {
            mainStackView.distribution = UIStackViewDistribution.FillProportionally
            self.title.textAlignment = .Left
        } else {
            mainStackView.distribution = UIStackViewDistribution.Fill
            self.title.textAlignment = .Center
        }
        
    }
    
    public func show() {
        
        self.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(paneSlideAnimationTime,
            
            delay: 0.0,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 0.5,
            
            options: [UIViewAnimationOptions.CurveEaseInOut],
            
            animations: {
                self.topBoxConstraint.constant = self.paneShowYposition
                self.layoutIfNeeded()
                
            }, completion: { finished in
                
                UIView.animateWithDuration(0.85, delay: self.paneShowVisibleTime, options: [], animations: {
                    self.alpha = 0
                    }, completion: { finished in
                        self.topBoxConstraint.constant = self.paneHideYposition
                        self.alpha = 1
                })
        })
    }
    
    
    // MARK: Initialize
    private func initMaster() {
        
        backgroundColor = mainColor
        
        emoji.textAlignment = .Center
        emoji.backgroundColor = UIColor.clearColor()
        
        setMessage(title: "Congrats!")
        
        title.backgroundColor = UIColor.clearColor()
        
        message.scrollEnabled = false
        message.editable = false
        message.backgroundColor = UIColor.clearColor()
        
        mainStackView.alignment = UIStackViewAlignment.Center
        mainStackView.axis = UILayoutConstraintAxis.Horizontal
        
        textStackView.distribution = UIStackViewDistribution.Fill
        textStackView.alignment = UIStackViewAlignment.Center
        textStackView.axis = UILayoutConstraintAxis.Vertical
        
        mainStackView.addArrangedSubview(emoji)
        textStackView.addArrangedSubview(title)
        textStackView.addArrangedSubview(message)
        mainStackView.addArrangedSubview(textStackView)
        
        
        self.addSubview(mainStackView)
        
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initMaster()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initMaster()
    }
    
    override public func layoutSubviews() {
        
        if topBoxConstraint == nil {
            addConstraints()
        }
        
    }
    
    // Constraints
    override public class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    private func addConstraints(){
        if let topAnchorDrop = self.superview?.topAnchor {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            topBoxConstraint = self.topAnchor.constraintEqualToAnchor(topAnchorDrop, constant: paneHideYposition)
            topBoxConstraint.active = true
            
            anchorWidth = self.widthAnchor.constraintEqualToAnchor(nil, constant: paneWidth)
            anchorWidth.active = true
            
            anchorHeight = self.heightAnchor.constraintEqualToAnchor(nil, constant: paneHeight)
            anchorHeight.active = true
            
            anchorCenter = self.centerXAnchor.constraintEqualToAnchor(self.superview?.centerXAnchor, constant: self.paneXcenterOffset)
            anchorCenter.active = true
            
            mainStackView.translatesAutoresizingMaskIntoConstraints = false
            
            mainStackView.widthAnchor.constraintEqualToAnchor(self.widthAnchor).active = true
            mainStackView.heightAnchor.constraintEqualToAnchor(self.heightAnchor).active = true
            mainStackView.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor).active = true
            mainStackView.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
            
        }
    }
    
    
}
