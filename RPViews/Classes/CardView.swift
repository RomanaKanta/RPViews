//
//  CardView.swift
//  RPViews
//
//  Created by Romana on 21/1/21.
//

import Foundation
import UIKit

@IBDesignable public class CardView: UIView {
    
    @IBInspectable public var cornerradius: CGFloat = 5.0 { didSet{ updateUI() } }
    @IBInspectable public var setPrimColorBg: Bool = false { didSet{ updateUI() } }
    @IBInspectable public var bgColor: UIColor? = UIColor.white { didSet{ updateUI() } }
    @IBInspectable public var isGradient: Bool = false { didSet{ updateUI() } }
    @IBInspectable public var startColor: UIColor? = nil { didSet{ updateUI() } }
    @IBInspectable public var endColor: UIColor? = nil { didSet{ updateUI() } }
    
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 4 { didSet{ updateUI() } }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    func initCustomView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        startColor = UIColor(hexString: RPConstants.GRADIENT_LIGHT)!
        endColor = UIColor(hexString: RPConstants.GRADIENT_DARK)!
    }
    
    public override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        layer.shadowPath = shadowPath.cgPath
        updateUI()
    }
    
    func updateUI() {
        layer.cornerRadius = cornerradius
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        
        if (isGradient){
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = bounds
            gradientLayer.colors = [startColor!.cgColor, endColor!.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            gradientLayer.shadowPath = shadowPath.cgPath
            layer.insertSublayer(gradientLayer, at: 0)
        }else{
            if (setPrimColorBg) {
                self.backgroundColor = UIColor(hexString: RPConstants.APP_COLOR)!
            }else{
                self.backgroundColor = bgColor
            }
            layer.shadowPath = shadowPath.cgPath
        }
        setNeedsDisplay()
    }
    
}
