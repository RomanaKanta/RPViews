//
//  RPChecekBox.swift
//  RPViews
//
//  Created by Romana on 21/1/21.
//

import Foundation
import UIKit

@IBDesignable public class ChecekBoxView: UIButton {
    
    @IBInspectable public var iconTintColor: UIColor? = UIColor.gray { didSet{ updateUI() } }
    @IBInspectable public var iconSelect: String = "" { didSet{ updateUI() } }
    @IBInspectable public var iconUnselect: String = "" { didSet{ updateUI() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    func initCustomView() {
        self.setImage(UIImage(named:"check_box_unselect_white_48.png"), for: .normal)
        self.setImage(UIImage(named:"check_box_select_white_48.png"), for: .selected)
    }
    
    func updateUI(){
        self.tintColor = iconTintColor
        if(!iconUnselect.isEmpty){
            self.setImage(UIImage(named:iconUnselect), for: .normal)
        }
        if(!iconSelect.isEmpty){
        self.setImage(UIImage(named:iconSelect), for: .selected)
        }
        setNeedsDisplay()
    }
    
    public func changeCheckSelection(view: UIButton){
        UIView.animate(withDuration: 0.15, delay: 0.05, options: .curveLinear, animations: {
            view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.05, options: .curveLinear, animations: {
                view.isSelected = !view.isSelected
                view.transform = .identity
            }, completion: nil)
        }
    }
}
