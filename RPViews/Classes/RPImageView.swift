//
//  RPImageView.swift
//  RPViews
//
//  Created by Romana on 21/1/21.
//

import Foundation
import UIKit

@IBDesignable public class CustomImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    func initCustomView() {
        self.image = self.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    }
    
    public override func awakeFromNib() {
           super.awakeFromNib()
           self.image = self.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
       }
}

public class PaddedImageView: UIImageView {
    public override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
    }
}
