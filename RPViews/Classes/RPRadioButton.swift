//
//  RPRadioButton.swift
//  RPViews
//
//  Created by Romana on 24/1/21.
//

import Foundation

public protocol RadioButtonProtocol {
    func SelectedButton(value: String)
}

@IBDesignable
public class CustomRadioButton: UIButton {
    var alternateButton:Array<CustomRadioButton>?
    var delegate: RadioButtonProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    func initCustomView() {
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    override public func awakeFromNib() {
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    func unselectAlternateButtons() {
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:CustomRadioButton in alternateButton! {
                aButton.isSelected = false
            }
        } else {
            toggleButton()
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton() {
        self.isSelected = !isSelected
    }
    
    @IBInspectable public var customColor: UIColor = UIColor.red
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                self.tintColor = UIColor.clear
                self.setTitleColor(UIColor.white, for: .normal)
                self.layer.backgroundColor = customColor.cgColor
                self.layer.borderColor = customColor.cgColor
                
                delegate?.SelectedButton(value: titleLabel!.text!)
            } else {
                self.tintColor = UIColor.clear
                self.setTitleColor(UIColor.darkGray, for: .normal)
                self.layer.backgroundColor = UIColor.white.cgColor
                self.layer.borderColor = UIColor.darkGray.cgColor
            }
        }
    }
    
}
