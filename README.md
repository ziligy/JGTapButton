# JGTapButton

Custom @IBDesignable button for Interface Builder that doesn't require any coding.

## Screen Example
<img src="https://raw.githubusercontent.com/ziligy/JGTapButton/master/JGTapButton.gif" alt="JGTapButton"/>

## Custom Button
* uses Interface Builder
* wire up like standand button
* IBDesignable styles for: round or square, flat or raised
* IBDesignable elements for color, text, text-size
* glow feedback
* optional image

## Requirements
* Xcode 6.1
* iOS 8.0+

**NOTE: demo uses 7.0 & ios 9**

## Usage
1. Copy JGTapButton.swift class to your Xcode Project
2. Drag a UIView and assign JGTapButton as class for each button
3. For each JGTapButton use the Attributes Inspector to modify the default IBInspectable elements as desired:
    * Round On for round button or Off for square
	* Raised On for raised style or Off for flat
	* Title caption
    * Optional image
    * Button color
	* Font size
	* Font color
4. Use the Connections Inspector to wire the *Touch Up Inside* event in your Storyboard or to an @IBAction in your code

## Demo
Demo example is included.

## Attribution
Demo icons adapted from Shali Nguyen (http://shalinguyen.github.io/socialicious/)


