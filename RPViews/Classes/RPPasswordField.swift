//
//  RPPasswordField.swift
//  RPViews
//
//  Created by Romana on 21/1/21.
//

import Foundation
import UIKit

public enum MaskSymbol: String {
    case dot = "•"
    case star = "★"
    case asterisk = "⁎"
}

@IBDesignable public class CustomPasswordField : UITextField {
    
    @IBInspectable var setClearButton: Bool = false { didSet{ updateUI() } }
    @IBInspectable var setHideShowButton: Bool = false { didSet{ updateUI() } }
    open var maskSign: MaskSymbol = MaskSymbol.dot { didSet{ updateUI() } }
    var userStoppedTypingHandler: (() -> Void)?
    var clearBtn: UIButton = UIButton(type: .custom)
    var hideShowBtn: UIButton = UIButton(type: .custom)
    var iconClick: Bool = false
    let rView = UIView()
    var errorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    func initCustomView() {
        
        self.addTarget(self, action: #selector(CustomPasswordField.textFieldDidChange), for: .editingChanged)
        //        self.addTarget(self, action: #selector(CustomPasswordField.textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(CustomPasswordField.textFieldDidEndEditing), for: .editingDidEnd)
        self.addTarget(self, action: #selector(CustomPasswordField.textFieldDidEndEditingOnExit), for: .editingDidEndOnExit)
        
        hideShowBtn.setImage(UIImage(named: "ic_eye_closed.png"), for: .normal)
        hideShowBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        hideShowBtn.frame = CGRect(x: CGFloat(30), y: 0, width: CGFloat(30), height: CGFloat(30))
        hideShowBtn.tintColor = UIColor.gray
        hideShowBtn.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        
        let image = UIImage(named: "ic_error_circle.png")?.withRenderingMode(.alwaysTemplate)
        clearBtn.setImage(image, for: .normal)
        clearBtn.tintColor = UIColor.gray
        clearBtn.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        clearBtn.frame = CGRect(x: 0, y: 0, width: CGFloat(30), height: CGFloat(30))
        clearBtn.addTarget(self, action: #selector(self.clearField), for: .touchUpInside)
        clearBtn.isHidden = true
        self.clearButtonMode = UITextField.ViewMode.never
        
        errorLabel.frame = self.frame
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
        errorLabel.backgroundColor = .white
        errorLabel.font = UIFont.systemFont(ofSize: 14)
        errorLabel.isHidden = true
    }
    
    @objc func clearField(){
        self.text = ""
        realText = ""
        clearBtn.isHidden = true
    }
    
    func updateUI(){
        if (setHideShowButton && setClearButton){
            rView.frame = CGRect(x: CGFloat(frame.size.width - 60), y: 0, width: CGFloat(60), height: CGFloat(30))
            rView.addSubview(clearBtn)
            rView.addSubview(hideShowBtn)
        }else if (setHideShowButton && !setClearButton){
            rView.frame = CGRect(x: CGFloat(frame.size.width - 30), y: 0, width: CGFloat(30), height: CGFloat(30))
            hideShowBtn.frame = CGRect(x: 0, y: 0, width: CGFloat(30), height: CGFloat(30))
            rView.addSubview(hideShowBtn)
        }else if (!setHideShowButton && setClearButton){
            rView.frame = CGRect(x: CGFloat(frame.size.width - 30), y: 0, width: CGFloat(30), height: CGFloat(30))
            rView.addSubview(clearBtn)
        }else{
            rView.frame = CGRect.zero
        }
        self.rightView = rView
        self.rightViewMode = .always
        
        setNeedsDisplay()
    }
    
    @objc func refresh(_ sender: Any) {
        iconClick = !iconClick
        text = ""
        if(iconClick == true) {
            text = getRealText()
            hideShowBtn.setImage(UIImage(named: "ic_eye_open.png"), for: .normal)
        } else {
            text = getMaskedText()
            hideShowBtn.setImage(UIImage(named: "ic_eye_closed.png"), for: .normal)
        }
    }
    
    @objc open func typingDidStop() {
        if userStoppedTypingHandler != nil {
            self.userStoppedTypingHandler!()
        }
    }
    
    var realText: String = ""
    
    func setRealText(replacementString: String){
        if (replacementString.isEmpty) {
            realText.remove(at: realText.index(before: realText.endIndex))
        }else{
            realText = realText + replacementString
        }
    }
    
    func getRealText() -> String {
        return realText
    }
    
    func getMaskedText() -> String{
        var maskedText: String = ""
        for _ in realText{
            maskedText = maskedText + maskSign.rawValue
        }
        return maskedText
    }
    
    // Handle text field changes
    @objc open func textFieldDidChange() {
        if !(inputLanguageValidation(text: getRealText())){
            realText = String(getRealText().dropLast())
            showError()
        }
        
        text = ""
        if(iconClick == true) {
            text = getRealText()
        }else{
            text = getMaskedText()
        }
        
        if(text!.isEmpty){
            clearBtn.isHidden = true
        }else{
            clearBtn.isHidden = false
        }
    }
    
    @objc open func textFieldDidEndEditing() {}
    
    @objc open func textFieldDidEndEditingOnExit() {}
    
    func inputLanguageValidation(text: String) -> Bool{
          var isValid: Bool = true
          for scalar in text.unicodeScalars {
              isValid = scalar.isASCII
              if !isValid{
                  break
              }
          }
          return isValid
      }
    
    func showError(){
        errorLabel.isHidden = false
        errorLabel.text = "Unsupported language"
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
                self.errorLabel.isHidden = true
            }
        }
}
