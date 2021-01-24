//
//  RPButtonView.swift
//  RPViews
//
//  Created by Romana on 21/1/21.
//

import Foundation
import UIKit

@IBDesignable public class CustomButtonView: UIButton {
    
    @IBInspectable public var isOvalShape: Bool = true { didSet{ updateUI() } }
    @IBInspectable public var radious: CGFloat = 18 { didSet{ updateUI() } }
    @IBInspectable public var bgColor: UIColor? = UIColor.gray { didSet{ updateUI() } }
    @IBInspectable public var invert: Bool = false { didSet{ updateUI() } }
    @IBInspectable public var haveBorder: Bool = false { didSet{ updateUI() } }
    @IBInspectable public var isGradient: Bool = false { didSet{ updateUI() } }
    @IBInspectable public var startColor: UIColor? = UIColor.white { didSet{ updateUI() } }
    @IBInspectable public var endColor: UIColor? = UIColor.black { didSet{ updateUI() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    func initCustomView() {
        self.setTitle(self.titleLabel?.text?.capitalized, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func updateUI(){
        
        if(isOvalShape){
            self.layer.cornerRadius = radious
        }else{
            self.layer.cornerRadius = 0
        }
        
        if(haveBorder){
            self.layer.borderWidth = 2
            self.layer.borderColor = bgColor!.cgColor
        }
        
        if (isGradient){
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = bounds
            gradientLayer.colors = [startColor!.cgColor, endColor!.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            layer.insertSublayer(gradientLayer, at: 0)
            self.bringSubview(toFront: self.imageView!)
            self.tintColor = UIColor.white
            self.setTitleColor(UIColor.white, for: .normal)
        }else{
            if (invert){
                self.tintColor = bgColor
                self.setTitleColor(bgColor, for: .normal)
                self.layer.backgroundColor = UIColor.white.cgColor
            }else{
                self.tintColor = UIColor.white
                self.setTitleColor(UIColor.white, for: .normal)
                self.layer.backgroundColor = bgColor!.cgColor
            }
        }
        setNeedsDisplay()
    }
}

@IBDesignable public class CircluerButton: UIButton {
    var margin: CGFloat = 20
    @IBInspectable public var size: CGFloat = 50 { didSet{ updateUI() } }
    @IBInspectable public var bgColor: UIColor? = UIColor.gray { didSet{ updateUI() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    func initCustomView() {
        self.frame = CGRect(x: 0, y: 0, width: size, height: size)
        self.setTitle(self.titleLabel?.text?.capitalized, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.tintColor = .white
        titleLabel?.font =  UIFont.boldSystemFont(ofSize: 14)
        self.layer.backgroundColor = bgColor?.cgColor
        self.layer.cornerRadius = (size/2)
    }
    
    func updateUI(){
        self.layer.backgroundColor = bgColor?.cgColor
        self.layer.cornerRadius = (size/2)
        setNeedsDisplay()
    }
}
