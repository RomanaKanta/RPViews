//
//  RPPullToRefreshView.swift
//  RPViews
//
//  Created by Romana on 24/1/21.
//

import Foundation

public protocol PullToRefreshDelegate{
    func onRefresh()
}

public class PullToRefreshView: UIView {
    
    public var delegate:PullToRefreshDelegate!
    var isRefreshing: Bool = false
    public var circleView: UIView!
    let circleSize: CGFloat = 30
    public var imageView: UIImageView!
    let imageSize: CGFloat = 25
    
    func setRefreshController(){
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.down:
                
                if !isRefreshing {
                    setView()
                }
                
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    func setView(){
        // Create a new CircleView
        
        circleView = UIView(frame: CGRect(x: ((frame.width/2)-(circleSize/2)), y: 10, width: circleSize, height: circleSize))
        circleView.backgroundColor = UIColor.white
        circleView.layer.cornerRadius = (circleSize/2)
        
        let imageView: UIImageView = UIImageView(frame: CGRect(x: ((circleView.frame.width/2)-(imageSize/2)), y: ((circleView.frame.height/2)-(imageSize/2)), width: imageSize, height: imageSize))
        imageView.image = UIImage(named: "ic_refresh_white.png")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imageView.tintColor = UIColor(hexString: AppConstant.SECONDARY_COLOR)
        
        let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
        rotationAnimation.duration = 0.8;
        rotationAnimation.isCumulative = true;
        rotationAnimation.repeatCount = .infinity;
        imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        circleView.addSubview(imageView)
        
        addSubview(circleView)
        
        isRefreshing = true
        
        if (delegate != nil) {
            delegate.onRefresh()
        }
    }
    
    func dismiss() {
        if isRefreshing {
            let delayInSeconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.circleView.removeFromSuperview()
                self.isRefreshing = false
            }
        }
    }
    
}
