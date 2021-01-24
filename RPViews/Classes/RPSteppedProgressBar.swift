//
//  RPSteppedProgressBar.swift
//  RPViews
//
//  Created by Romana on 24/1/21.
//

import Foundation
import UIKit

//class CustomSteppedProgressBar: FlexibleSteppedProgressBar, FlexibleSteppedProgressBarDelegate {
//    
//    var stepTitles: [String] = [""]{ didSet{ updateUI() } }
//    
//    override init(frame: CGRect) {
//          super.init(frame: frame)
//          self.initCustomView()
//      }
//      
//      required init?(coder aDecoder: NSCoder) {
//          super.init(coder: aDecoder)
//          self.initCustomView()
//      }
//      
//     func initCustomView() {
//                  self.numberOfPoints = 3
//                  self.lineHeight = 5
//                  self.radius = 12
//                  self.progressRadius = 12
//                  self.progressLineHeight = 5
//                  self.lastStateCenterColor = UIColor(hexString: AppConstant.SECONDARY_COLOR)!
//                  self.selectedBackgoundColor = UIColor(hexString: AppConstant.SECONDARY_COLOR)!
//                  self.selectedOuterCircleStrokeColor = UIColor.clear
//                  self.lastStateOuterCircleStrokeColor = UIColor.clear
//                  self.currentSelectedCenterColor = UIColor(hexString: AppConstant.SECONDARY_COLOR)!
//                  self.currentSelectedTextColor = UIColor(hexString: AppConstant.SECONDARY_COLOR)!
//                  self.currentIndex = 0
//    }
//    
//      func updateUI() {
//        self.numberOfPoints = stepTitles.count
//        self.delegate = self
//    }
//    
//   func progressBar(_ progressBar: FlexibleSteppedProgressBar,
//                        canSelectItemAtIndex index: Int) -> Bool {
//           return false
//       }
//       
//       func progressBar(_ progressBar: FlexibleSteppedProgressBar,
//                        textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
//           if position == FlexibleSteppedProgressBarTextLocation.bottom {
//               return stepTitles[index]
//           }
//           if position == FlexibleSteppedProgressBarTextLocation.center {
//               return "\(index+1)"
//           }
//           return ""
//       }
//    
//}
