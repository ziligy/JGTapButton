//
//  JGEmojiNotify.swift
//
//  Created by Jeff on 9/14/15.
//  Copyright © 2015 Jeff Greenberg. All rights reserved.
//
//  updated to swift 3 10/23/16

import UIKit

public class JGEmojiNotify: UIView {
    
    // MARK: Public variables
    public var mainColor = UIColor.cyan {
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
    
    public var paneShowVisibleTime: TimeInterval = 0.8
    public var paneSlideAnimationTime: TimeInterval = 0.2
    
    
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
        emoji: String = "🙌",
        title: String = "",
        message: String = "",
        emojiFontSize: CGFloat = 68,
        titleFontSize: CGFloat = 18.0,
        messageFontSize: CGFloat = 12.0)
    {
        
        self.emoji.text = emoji
        self.title.text = title
        self.message.text = message
        
        self.emoji.font = UIFont.systemFont(ofSize: emojiFontSize)
        self.title.font = UIFont.systemFont(ofSize: titleFontSize)
        self.message.font = UIFont.systemFont(ofSize: messageFontSize)
        
        self.emoji.isHidden = self.emoji.text!.isEmpty
        self.title.isHidden = self.title.text!.isEmpty
        self.message.isHidden = self.message.text.isEmpty
        
        if self.message.text.isEmpty {
            mainStackView.distribution = UIStackViewDistribution.fillProportionally
            self.title.textAlignment = .left
        } else {
            mainStackView.distribution = UIStackViewDistribution.fill
            self.title.textAlignment = .center
        }
        
    }
    
    public func show() {
        
        self.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: paneSlideAnimationTime,
            
            delay: 0.0,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 0.5,
            
            options: [UIViewAnimationOptions.curveEaseInOut],
            
            animations: {
                self.topBoxConstraint.constant = self.paneShowYposition
                self.layoutIfNeeded()
                
            }, completion: { finished in
                
                UIView.animate(withDuration: 0.85, delay: self.paneShowVisibleTime, options: [], animations: {
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
        
        emoji.textAlignment = .center
        emoji.backgroundColor = UIColor.clear
        
        setMessage(title: "Congrats!")
        
        title.backgroundColor = UIColor.clear
        
        message.isScrollEnabled = false
        message.isEditable = false
        message.backgroundColor = UIColor.clear
        
        mainStackView.alignment = UIStackViewAlignment.center
        mainStackView.axis = UILayoutConstraintAxis.horizontal
        
        textStackView.distribution = UIStackViewDistribution.fill
        textStackView.alignment = UIStackViewAlignment.center
        textStackView.axis = UILayoutConstraintAxis.vertical
        
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
    
    private func addConstraints(){
        if let topAnchorDrop = self.superview?.topAnchor {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            topBoxConstraint = self.topAnchor.constraint(equalTo: topAnchorDrop, constant: paneHideYposition)
            topBoxConstraint.isActive = true
            
            anchorWidth = widthAnchor.constraint(equalToConstant: paneWidth)
            anchorWidth.isActive = true
            anchorHeight = heightAnchor.constraint(equalToConstant: paneHeight)
            anchorHeight.isActive = true
            
            anchorCenter = self.centerXAnchor.constraint(equalTo: (self.superview?.centerXAnchor)!, constant: self.paneXcenterOffset)
            anchorCenter.isActive = true
            
            mainStackView.translatesAutoresizingMaskIntoConstraints = false
            
            mainStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            mainStackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
        }
    }
    
    
}
