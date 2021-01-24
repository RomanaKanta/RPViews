//
//  RPLabel.swift
//  RPViews
//
//  Created by Romana on 21/1/21.
//

import Foundation
import UIKit

@IBDesignable
public class CustomLabel: UILabel {
    
    var insets = UIEdgeInsets.zero
    
    func padding(_ top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width + left + right, height: self.frame.height + top + bottom)
        insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    public override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += insets.top + insets.bottom
            contentSize.width += insets.left + insets.right
            return contentSize
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = UIColor.black
    }
}

@IBDesignable
public class LabelwithIcon: UIView {
    
   @IBInspectable var textFont: UIFont = UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.semibold) { didSet{ updateUI() } }
    @IBInspectable var textColor: UIColor = UIColor.black { didSet{ updateUI() } }
    @IBInspectable var iconTint: UIColor = .white { didSet{ updateUI() } }
    @IBInspectable var text: String? { didSet{ updateUI() } }
    @IBInspectable var leftImage: UIImage? {didSet{ updateUI() } }
    @IBInspectable var rightImage: UIImage? {didSet{ updateUI() } }
    @IBInspectable var topImage: UIImage? {didSet{ updateUI() } }
    @IBInspectable var bottomImage: UIImage? {didSet{ updateUI() } }
    @IBInspectable var imageSize: CGFloat = 20.0 { didSet{ updateUI() } }
    @IBInspectable var padding: CGFloat = 5.0 { didSet{ updateUI() } }
    
    fileprivate var labelValue = UILabel()
    fileprivate var leftImageView = UIImageView()
    fileprivate var rightImageView = UIImageView()
    fileprivate var topImageView = UIImageView()
    fileprivate var bottomImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    fileprivate func initCustomView() {
        addSubview(leftImageView)
        addSubview(rightImageView)
        addSubview(topImageView)
        addSubview(bottomImageView)
        addSubview(labelValue)
    }
    
    fileprivate func updateUI() {
        
        if(leftImage != nil){
            leftImageView.frame = CGRect(x: padding , y: ((bounds.size.height - imageSize) / 2), width: imageSize, height: imageSize)
            leftImageView.image = leftImage
            leftImageView.tintColor = iconTint
        }
        if(rightImage != nil){
            rightImageView.frame = CGRect(x: (bounds.size.width - imageSize - padding),y: ((bounds.size.height - imageSize) / 2), width: imageSize, height: imageSize)
            rightImageView.image = rightImage
            rightImageView.tintColor = iconTint
        }
        if(topImage != nil){
            topImageView.frame = CGRect(x: ((bounds.size.width - imageSize)/2),y: padding, width: imageSize, height: imageSize)
            topImageView.image = topImage
            topImageView.tintColor = iconTint
        }
        if(bottomImage != nil){
            bottomImageView.frame = CGRect(x: ((bounds.size.width - imageSize)/2), y: (bounds.size.height - imageSize - padding), width: imageSize, height: imageSize)
            bottomImageView.image = bottomImage
            bottomImageView.tintColor = iconTint
        }
        
        if (text != nil){
            // label setup
            let labelHt = bounds.size.height - topImageView.frame.height - bottomImageView.frame.height - (2 * padding)
            let labelWd = bounds.size.width - leftImageView.frame.width - rightImageView.frame.width - (2 * padding)
            let labelAxis_x = leftImageView.frame.width + padding
            let labelAxis_y = topImageView.frame.height + padding
            
            labelValue.frame = CGRect(x: labelAxis_x, y: labelAxis_y, width: labelWd, height: labelHt)
            labelValue.textAlignment = .center
            labelValue.font = textFont
            labelValue.text = text
            labelValue.textColor = textColor
        }
        setNeedsDisplay()
    }
}

@IBDesignable
public class CustomLabelwithDirection : UIView{
    
    fileprivate var firstDraw: Bool = true
    
    @IBInspectable var textFont: UIFont = UIFont.boldSystemFont(ofSize: 13.0) { didSet{ updateUI() } }
    @IBInspectable var textColor: UIColor = .white { didSet{ updateUI() } }
    @IBInspectable var lineColor: UIColor = UIColor.gray{ didSet{ updateUI() } }
    @IBInspectable var text: String = "" { didSet{ updateUI() } }
    
    fileprivate var labelValue: CustomLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    public override func prepareForInterfaceBuilder() {
        backgroundColor = UIColor.clear  // clear black background IB
    }
    
    fileprivate func initCustomView() {
        backgroundColor = UIColor.clear  // clear black background
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if firstDraw {
            //create spinner label
            var frame = bounds
            frame.origin = CGPoint(x: frame.origin.x - 5, y: frame.origin.y)
            
            labelValue = CustomLabel(frame: frame)
            labelValue.textAlignment = .center
            addSubview(labelValue)
            
            //labelValue.backgroundColor = UIColor.gray
            
            updateUI()
            firstDraw = false
        }
        
        drawCanvas(frame: rect)
    }
        
    fileprivate func updateUI() {
        if (labelValue != nil) {
            labelValue.font = textFont
            
            labelValue.text = text
            labelValue.textColor = textColor
            
        }
        setNeedsDisplay()
    }
        
    //draw background spinner
    fileprivate func drawCanvas(frame: CGRect = CGRect(x: 0, y: 0, width: 86, height: 11)) {
        
        let bezierPath = UIBezierPath()
        
        let hMargin:CGFloat = 8.0
        let vMargin:CGFloat = frame.height/3
        
        let tWidth = frame.height - 2*vMargin
        
        bezierPath.move(to: frame.origin)
        bezierPath.addLine(to: CGPoint(x: frame.minX, y: frame.maxY))
        bezierPath.addLine(to: CGPoint(x: (frame.maxX - vMargin), y: frame.maxY))
        bezierPath.addLine(to: CGPoint(x: (frame.maxX - vMargin), y: frame.minY))
        bezierPath.addLine(to: frame.origin)
        
        lineColor.setFill()
        bezierPath.fill()
        
        let traingle = UIBezierPath()
        
        let firstPoint = CGPoint(x: frame.width - vMargin, y: hMargin)
        let secondPoint = CGPoint(x: frame.width - vMargin, y: (frame.height - hMargin))
        let thirdPoint = CGPoint(x: frame.width + tWidth - vMargin, y: (frame.height/2))
        
        traingle.move(to: firstPoint)
        traingle.addLine(to: secondPoint)
        traingle.addLine(to: thirdPoint)
        traingle.close()
        lineColor.setFill()
        traingle.fill()
    }
    
}
