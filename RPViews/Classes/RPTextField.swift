//
//  RPTextField.swift
//  RPViews
//
//  Created by Romana on 24/1/21.
//

import UIKit
import Material

@IBDesignable
public class CustomTextField: TextField {
    
    @IBInspectable public var leftIcon: UIImage? = nil { didSet{ updateUI() } }
    @IBInspectable public var rightIcon: UIImage? = nil { didSet{ updateUI() } }
    @IBInspectable public var iconTintColor: UIColor = UIColor.black { didSet{ updateUI() } }
    @IBInspectable public var textTintColor: UIColor = UIColor.black { didSet{ updateUI() } }
    
    let imageSize: CGFloat = 30
    let imagePadding: CGFloat = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    func initCustomView() {
        
        self.detailVerticalOffset = 1.0
        
        self.detailColor = UIColor.red
        
        self.isClearIconButtonEnabled = isUserInteractionEnabled
        
        self.textColor = textTintColor
        self.placeholderActiveColor = textTintColor
        self.placeholderNormalColor = textTintColor
        self.dividerNormalColor = textTintColor
        self.dividerActiveColor = iconTintColor
    }
    
    func updateUI(){
        if (leftIcon != nil){
            let leftImage: UIButton = UIButton(type: .custom)
            leftImage.setImage(leftIcon!.withRenderingMode(.alwaysTemplate), for: .normal)
            leftImage.tintColor = iconTintColor
            leftImage.imageEdgeInsets = UIEdgeInsets(top: imagePadding, left: imagePadding, bottom: imagePadding, right: imagePadding)
            leftImage.frame = CGRect(x: 0, y: 0, width: self.imageSize, height: self.imageSize)
            leftImage.contentMode = .center
            
            let lView = UIView(frame: CGRect(x: 0, y: 0, width: self.imageSize, height: self.imageSize))
            lView.addSubview(leftImage)
            lView.contentMode = .center
            
            self.leftView = lView
            self.leftView?.contentMode = .center
            self.leftViewOffset = 8
        }
        if (rightIcon != nil){
            self.isClearIconButtonEnabled = false
            let rightImage: UIButton = UIButton(type: .custom)
            rightImage.setImage(rightIcon!.withRenderingMode(.alwaysTemplate), for: .normal)
            rightImage.tintColor = iconTintColor
//            rightImage.imageEdgeInsets = UIEdgeInsets(top: imagePadding, left: imagePadding, bottom: imagePadding, right: imagePadding)
            rightImage.frame = CGRect(x: 0, y: 0, width: self.imageSize, height: self.imageSize)
            rightImage.contentMode = .center
            
            let rView = UIView(frame: CGRect(x: 0, y: 0, width: self.imageSize, height: self.imageSize))
            rView.addSubview(rightImage)
            rView.contentMode = .center
            
            self.rightView = rView
            self.rightView?.contentMode = .center
            self.rightViewMode = UITextField.ViewMode.always
            
        }
        setNeedsDisplay()
    }
    
    func clear(){
        self.text = ""
        self.detail = ""
    }
}

@IBDesignable public class NonEditableTextField : UIView {
    
    fileprivate var firstDraw: Bool = true
      
    @IBInspectable public var textFont: UIFont = UIFont.systemFont(ofSize: 15.0) { didSet{ updateUI() } }
    @IBInspectable public var textColor: UIColor = UIColor.black { didSet{ updateUI() } }
    @IBInspectable public var text: String = "" { didSet{ updateUI() } }
    @IBInspectable public var placeHolder: String = "" { didSet{ updateUI() } }
    @IBInspectable public var error: String = "" { didSet{ updateUI() } }
        
    fileprivate var labelValue: CustomTextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    override func prepareForInterfaceBuilder() {
        backgroundColor = UIColor.clear  // clear black background IB
    }
    
    fileprivate func initCustomView() {
        backgroundColor = UIColor.clear  // clear black background
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if firstDraw {
            var frame = bounds
            frame.origin = CGPoint(x: frame.origin.x, y: frame.origin.y)
            labelValue = CustomTextField(frame: frame)
            addSubview(labelValue)
            labelValue.isEnabled = false
            updateUI()
            firstDraw = false
        }
    }
    
    func clear(){
          self.text = ""
          self.error = ""
      }
    
    func getLabel() -> String{
        
        if ((labelValue.text == placeHolder) ||
            (labelValue.text == nil) ||
            (labelValue.text!.isEmpty)) {
            return ""
        }else{
            return labelValue.text!
        }
    }
    
    fileprivate func updateUI() {
        if (labelValue != nil) {
            labelValue.font = textFont
            labelValue.placeholder = placeHolder
            labelValue.text = text
            labelValue.textColor = textColor
            labelValue.detail = error
        }
        setNeedsDisplay()
    }
}
