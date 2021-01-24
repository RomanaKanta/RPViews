//
//  RPViewExtension.swift
//  RPViews
//
//  Created by Romana on 24/1/21.
//

import UIKit

@IBDesignable
public class DesignableView: UIView {
}
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


@IBDesignable public class CustomBorderView: UIView {
    
    //    var cornerradius : CGFloat = 8
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        layer.borderWidth = 2
        layer.borderColor =  UIColor(hexString: AppConstant.PRIMARY_COLOR)?.cgColor
        
    }
}

@IBDesignable public class ViewBackground: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //        if (AppConstant.BANK == "SIBL") {
        //            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        //            backgroundImage.image = UIImage(named: "background.png")
        //            backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        //            self.insertSubview(backgroundImage, at: 0)
        ////            self.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        //        }else{
        self.backgroundColor = UIColor.white
        //        }
    }
}


extension UIView{
    func setGradientBackground(startColor: UIColor, endColor: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}


