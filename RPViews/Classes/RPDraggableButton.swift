//
//  RPDraggableButton.swift
//  RPViews
//
//  Created by Romana on 21/1/21.
//

import Foundation
import UIKit

public enum CustomDraggableButtonType {
    case DraggableRect
    case DraggableRound
}

public  protocol CustomDraggableButtonProtocol {
    func onClick()
}

@IBDesignable public class CustomDraggableButton: UIButton {
    
    var customDraggableButtonProtocol:CustomDraggableButtonProtocol?
    
    @IBInspectable public var rectType: Bool = true { didSet{ updateUI() } }
    
    var btnHalfHt: CGFloat = 0
    var btnHalfWd: CGFloat = 0
    let minX: CGFloat = 1
    let minY: CGFloat = 1
    var maxX: CGFloat = 0
    var maxY: CGFloat = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    fileprivate func updateUI() {
        
        btnHalfHt = (frame.height/2)
        btnHalfWd = (frame.width/2)
        
        if rectType {
            self.layer.cornerRadius = 18.0
        }else{
            self.layer.cornerRadius = (frame.height/2)
            self.clipsToBounds = true
        }
        
        setNeedsDisplay()
    }
    
    fileprivate func initCustomView() {
        
        let color = UIColor.white
        self.setTitleColor(color, for: .normal)
        self.setTitle(self.titleLabel?.text?.capitalized, for: .normal)
        
        self.layer.backgroundColor = UIColor.gray.cgColor
        
        //        addTarget(self, action: #selector(touchDragEnter(control:event:)), for: UIControlEvents.touchDragEnter)
        //        addTarget(self, action: #selector(touchDragInside(control:event:)), for: UIControlEvents.touchDragInside)
        //        addTarget(self, action: #selector(touchDragOutside(control:event:)), for: UIControlEvents.touchDragOutside)
        //        addTarget(self, action: #selector(touchDragExit(control:event:)), for: UIControlEvents.touchDragExit)
        //        addTarget(self, action: #selector(touchUpOutside(control:event:)), for: UIControlEvents.touchUpOutside)
        //        addTarget(self, action: #selector(touchDown(control:event:)), for: UIControlEvents.touchDown)
        //        addTarget(self, action: #selector(touchCancel(control:event:)), for: UIControlEvents.touchCancel)
        //        addTarget(self, action: #selector(touchDownRepeat(control:event:)), for: UIControlEvents.touchDownRepeat)
        //        addTarget(self, action: #selector(editingDidBegin(control:event:)), for: UIControlEvents.editingDidBegin)
        //        addTarget(self, action: #selector(editingChanged(control:event:)), for: UIControlEvents.editingChanged)
        //        addTarget(self, action: #selector(editingDidEnd(control:event:)), for: UIControlEvents.editingDidEnd)
        //        addTarget(self, action: #selector(editingDidEndOnExit(control:event:)), for: UIControlEvents.editingDidEndOnExit)
        //        addTarget(self, action: #selector(valueChanged(control:event:)), for: UIControlEvents.valueChanged)
        
        addTarget(self, action: #selector(drag(control:event:)),
                  for: [UIControl.Event.touchDragInside,
                        UIControl.Event.touchDragExit,
                        UIControl.Event.touchDragOutside])
        
        addTarget(self, action: #selector(touchUpInside(control:event:)), for: UIControl.Event.touchUpInside)
        
    }
    
    var isDraged: Bool = false
    
    
    
    @objc func drag(control: UIControl, event: UIEvent) {
        
        isDraged = true
        
        if let center = event.allTouches?.first?.location(in: self.superview) {
            control.center = center
        }
        
        maxX = (self.superview?.frame.width)! - 1
        maxY = (self.superview?.frame.height)! - 1
        
        if ((self.frame.origin.x + btnHalfWd) > maxX) {
            control.center.x = (maxX - btnHalfWd)
        }
        if ((self.frame.origin.x - btnHalfWd) < minX) {
            control.center.x = (minX + btnHalfWd);
        }
        if ((self.frame.origin.y + btnHalfHt) > maxY) {
            control.center.y = (maxY - btnHalfHt)
        }
        if (self.frame.origin.y - btnHalfHt < minY) {
            control.center.y = (minY + btnHalfHt);
        }
    }
    
    @objc func touchUpInside(control: UIControl, event: UIEvent) {
        
        if isDraged {
            isDraged = false
        }else{
            customDraggableButtonProtocol?.onClick()
        }
    }
    
    //    func touchDragEnter(control: UIControl, event: UIEvent) { print("touchDragEnter") }
    //    func touchDragOutside(control: UIControl, event: UIEvent) { print("touchDragOutside") }
    //    func touchDragExit(control: UIControl, event: UIEvent) {  print("touchDragExit") }
    //    func touchUpOutside(control: UIControl, event: UIEvent) { print("touchUpOutside") }
    //    func touchDown(control: UIControl, event: UIEvent) { print("touchDown") }
    //    func touchCancel(control: UIControl, event: UIEvent) { print("touchCancel") }
    //    func touchDownRepeat(control: UIControl, event: UIEvent) { print("touchDownRepeat") }
    //    func editingDidBegin(control: UIControl, event: UIEvent) { print("editingDidBegin") }
    //    func editingChanged(control: UIControl, event: UIEvent) { print("editingChanged") }
    //    func editingDidEnd(control: UIControl, event: UIEvent) { print("editingDidEnd") }
    //    func editingDidEndOnExit(control: UIControl, event: UIEvent) { print("editingDidEndOnExit") }
    //    func valueChanged(control: UIControl, event: UIEvent) { print("valueChanged") }
    
}
