//
//  JGTapButton.swift
//
//  Created by Jeff on 8/20/15.
//  Copyright © 2015 Jeff Greenberg. All rights reserved.
//
//  updated to swift 3 10/23/16

import UIKit

enum TapButtonShape {
    case round
    case rectangle
}

enum TapButtonStyle {
    case raised
    case flat
}

enum TapButtonCorners {
    case beveled
    case squared
    
}

@IBDesignable
public class JGTapButton: UIButton {
    
    // MARK: Inspectables
    
    // select round or rectangle button shape
    @IBInspectable public var round: Bool = true {
        didSet {
            buttonShape = (round ? .round : .rectangle)
        }
    }
    
    // select raised or flat style
    @IBInspectable public var raised: Bool = true {
        didSet {
            buttonStyle = (raised ? .raised : .flat)
        }
    }
    
    // select raised or flat style
    @IBInspectable public var squared: Bool = true {
        didSet {
            buttonCorners = (squared ? .squared : .beveled)
        }
    }
    
    // set title caption for button
    @IBInspectable public var title: String = "JGTapButton" {
        didSet {
            buttonTitle = title
        }
    }
    
    // optional button image
    @IBInspectable public var image: UIImage=UIImage() {
        didSet {
            setButtonImage()
        }
    }
    
    @IBInspectable public var imageInset: CGFloat = 0 {
        didSet {
            setButtonImage()
        }
    }
    
    // main background button color
    @IBInspectable public var mainColor: UIColor = UIColor.red {
        didSet {
            buttonColor = mainColor
        }
    }
    
    // title font size
    @IBInspectable public var fontsize: CGFloat = 22.0 {
        didSet {
            titleFontSize = fontsize
        }
    }
    
    @IBInspectable public var bevelSize: CGFloat = 7.0 {
        didSet {
            cornerRadius = bevelSize
        }
    }
    
    @IBInspectable public var fontColor: UIColor = UIColor.white
    
    // MARK: Private variables
    
    private var buttonShape = TapButtonShape.round
    
    private var buttonStyle = TapButtonStyle.flat
    
    private var buttonCorners = TapButtonCorners.squared
    
    private var buttonTitle = ""
    
    private var buttonColor = UIColor.red
    
    private var titleFontSize: CGFloat = 22.0
    
    private var cornerRadius: CGFloat = 7.0
    
    private var tapButtonFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    // outline shape of button from draw
    private var outlinePath = UIBezierPath()
    
    // variables for glow animation
    private let tapGlowView = UIView()
    private let tapGlowBackgroundView = UIView()
    
    private var tapGlowColor = UIColor(white: 0.9, alpha: 1)
    private var tapGlowBackgroundColor = UIColor(white: 0.95, alpha: 1)
    
    private var tapGlowMask: CAShapeLayer? {
        get {
            let maskLayer = CAShapeLayer()
            
            maskLayer.path = outlinePath.cgPath
            
            return maskLayer
        }
    }
    
    // optional image for
    private var iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    // MARK: Initialize
    func initMaster() {
        self.backgroundColor = UIColor.clear
        self.addSubview(iconImageView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initMaster()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initMaster()
    }
    
    convenience init(sideSize: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: sideSize, height: sideSize))
    }
    
    override public func prepareForInterfaceBuilder() {
        invalidateIntrinsicContentSize()
        self.backgroundColor = UIColor.clear
    }
    
    
    // MARK: Layout
    override public func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.layer.mask = tapGlowMask
        tapGlowBackgroundView.layer.mask = tapGlowMask
        
    }
    
    override public var intrinsicContentSize: CGSize {
        return bounds.size
    }
    
    // MARK: draw
    override public func draw(_ rect: CGRect) {
        outlinePath = drawTapButton(buttonShape, buttonTitle: buttonTitle, fontsize: titleFontSize)
        tapGlowSetup()
    }
    
    private func tapGlowSetup() {
        
        tapGlowBackgroundView.backgroundColor = tapGlowBackgroundColor
        tapGlowBackgroundView.frame = bounds
        layer.addSublayer(tapGlowBackgroundView.layer)
        tapGlowBackgroundView.layer.addSublayer(tapGlowView.layer)
        tapGlowBackgroundView.alpha = 0
    }
    
    private func drawTapButton(_ buttonShape: TapButtonShape, buttonTitle: String, fontsize: CGFloat) -> UIBezierPath {
        
        var bezierPath: UIBezierPath!
        
        if buttonStyle == .raised {
            tapButtonFrame = CGRect(x: 1, y: 1, width: self.bounds.width - 2, height: self.bounds.height - 2)
        } else {
            tapButtonFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        }
        
        let context = UIGraphicsGetCurrentContext()
        
        if buttonShape == .round {
            bezierPath = UIBezierPath(ovalIn: tapButtonFrame)
        } else {
            if buttonCorners == .squared {
                bezierPath = UIBezierPath(rect: tapButtonFrame)
            } else {
                bezierPath = UIBezierPath(roundedRect: tapButtonFrame, cornerRadius: cornerRadius)
            }
        }
        
        buttonColor.setFill()
        bezierPath.fill()
        
        let shadow = UIColor.black.cgColor
        let shadowOffset = CGSize(width: 3.1, height: 3.1)
        let shadowBlurRadius: CGFloat = 7
        
        if buttonStyle == .raised {
            context?.saveGState()
            context?.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color: shadow)
            fontColor.setStroke()
            bezierPath.lineWidth = 1
            bezierPath.stroke()
            context?.restoreGState()
        }
        
        // MARK: Title Text
        
        
        if let _ = iconImageView.image {
        } else {
            let buttonTitleTextContent = NSString(string: buttonTitle)
            context?.saveGState()
            
            if buttonStyle == .raised {
                context?.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color: shadow)
            }
            
            let buttonTitleStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            buttonTitleStyle.alignment = NSTextAlignment.center
            
            let buttonTitleFontAttributes = [NSFontAttributeName: UIFont(name: "AppleSDGothicNeo-Regular", size: fontsize)!, NSForegroundColorAttributeName: fontColor, NSParagraphStyleAttributeName: buttonTitleStyle] as [String : Any]
            
            let buttonTitleTextHeight: CGFloat = buttonTitleTextContent.boundingRect(with: CGSize(width: tapButtonFrame.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: buttonTitleFontAttributes, context: nil).size.height
            context?.saveGState()
            context?.clip(to: tapButtonFrame);
            buttonTitleTextContent.draw(in: CGRect(x: tapButtonFrame.minX, y: tapButtonFrame.minY + (tapButtonFrame.height - buttonTitleTextHeight) / 2, width: tapButtonFrame.width, height: buttonTitleTextHeight), withAttributes: buttonTitleFontAttributes)
            context?.restoreGState()
            context?.restoreGState()
        }
        
        return bezierPath
    }
    
    private func setButtonImage() {
        iconImageView.frame = CGRect(x: imageInset, y: imageInset, width: self.frame.width - imageInset*2, height: self.frame.height - imageInset*2)
        iconImageView.image = self.image
    }
    
    // MARK: Tap events
    override public func beginTracking(_ touch: UITouch,
        with event: UIEvent?) -> Bool {
            
            UIView.animate(withDuration: 0.1, animations: {
                self.tapGlowBackgroundView.alpha = 1
                }, completion: nil)
            
            return super.beginTracking(touch, with: event)
    }
    
    override public func endTracking(_ touch: UITouch?,
        with event: UIEvent?) {
            super.endTracking(touch, with: event)
            
            UIView.animate(withDuration: 0.1, animations: {
                self.tapGlowBackgroundView.alpha = 1
                }, completion: {(success: Bool) -> () in
                    UIView.animate(withDuration: 0.6 , animations: {
                        self.tapGlowBackgroundView.alpha = 0
                        }, completion: nil)
            })
    }
}
