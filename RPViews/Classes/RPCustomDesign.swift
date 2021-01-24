//
//  RPCustomDesign.swift
//  RPViews
//
//  Created by Romana on 21/1/21.
//

import Foundation
import UIKit

public protocol CustomDesignViewDelegate{
    func onClick(_ sender:CustomDesignView)
}

@IBDesignable public class CustomDesignView : UIView {
    
    public var delegate:CustomDesignViewDelegate!
    
    @IBInspectable public var textFont: UIFont = UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.semibold) { didSet{ updateUI() } }
    @IBInspectable public var textColor: UIColor = UIColor.black { didSet{ updateUI() } }
    @IBInspectable public var iconTint: UIColor = .white { didSet{ updateUI() } }
    @IBInspectable public var text: String = "label" { didSet{ updateUI() } }
    @IBInspectable public var labelHeight: CGFloat = 20.0 { didSet{ updateUI() } }
    @IBInspectable public var image: UIImage? {didSet{ updateUI() } }
    @IBInspectable public var imageHeight: CGFloat = 40.0 { didSet{ updateUI() } }
    @IBInspectable public var imageWidth: CGFloat = 40.0 { didSet{ updateUI() } }
    @IBInspectable public var paddingTop: CGFloat = 0.0 { didSet{ updateUI() } }
    @IBInspectable public var paddingBottom: CGFloat = 0.0 { didSet{ updateUI() } }
    
    fileprivate var labelValue: UILabel!
    fileprivate var imageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    fileprivate func initCustomView() {
        backgroundColor = UIColor.clear
        
        imageView = UIImageView()
        addSubview(imageView)
        labelValue = UILabel()
        addSubview(labelValue)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapGestureRecognizer:)))
        addGestureRecognizer(gesture)
        
    }
    
    @objc func viewTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if (delegate != nil) {
            delegate.onClick(self)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(origin: CGPoint(x: (bounds.size.width - imageWidth)/2,y :paddingTop), size: CGSize(width: imageWidth, height: imageHeight))
        labelValue.frame = CGRect(origin: CGPoint(x: 0,y :bounds.size.height - (labelHeight + paddingBottom)), size: CGSize(width: bounds.size.width, height: labelHeight))
        labelValue.textAlignment = .center
    }
    
    fileprivate func updateUI() {
        // label setup
        if (labelValue != nil) {            
            labelValue.frame = CGRect(origin: CGPoint(x: 0,y :bounds.size.height - (labelHeight + paddingBottom)), size: CGSize(width: bounds.size.width, height: labelHeight))
            labelValue.textAlignment = .center
            labelValue.font = textFont
            labelValue.text = text
            labelValue.textColor = textColor
        }
        // image setup
        if (imageView != nil) {
            imageView.frame = CGRect(origin: CGPoint(x: (bounds.size.width - imageWidth)/2,y :paddingTop), size: CGSize(width: imageWidth, height: imageHeight))
            imageView.image = image
            imageView.tintColor = iconTint
        }
        setNeedsDisplay()
    }
}
