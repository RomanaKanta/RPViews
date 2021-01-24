//
//  RPFaceView.swift
//  RPViews
//
//  Created by Romana on 24/1/21.
//

import Foundation
import UIKit

@IBDesignable public class DrawFace: UIView {
    
    var circleLayer: CAShapeLayer!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCustomView()
    }
    
    fileprivate func initCustomView() {
        self.backgroundColor = UIColor.clear
     
        circleLayer = CAShapeLayer()        
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(circleLayer)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        let center = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
        let radius = (frame.width - 10)/2
        
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        let smilePath = UIBezierPath(arcCenter: center, radius: (radius - 10), startAngle: 0.0, endAngle: CGFloat(Double.pi), clockwise: true)
        
        let leftEyePath = UIBezierPath(arcCenter: CGPoint(x: ((frame.width / 4.0) + 10), y: ((frame.height / 4.0) + 10)), radius: 5, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        let rightEyePath = UIBezierPath(arcCenter: CGPoint(x: (frame.width - ((frame.width / 4.0) + 10)), y: ((frame.height / 4.0) + 10)), radius: 5, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        let shapeLayerPath = UIBezierPath()
        shapeLayerPath.append(circlePath)
        shapeLayerPath.append(leftEyePath)
        shapeLayerPath.append(rightEyePath)
        shapeLayerPath.append(smilePath)
        
        // Setup the CAShapeLayer with the path, colors, and line width
//        circleLayer = CAShapeLayer()
        circleLayer.path = shapeLayerPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.black.cgColor
        circleLayer.lineWidth = 2.0;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
    }
    
    func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = 1.0
        
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
    }
}
