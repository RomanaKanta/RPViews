//
//  RPRefreshController.swift
//  RPViews
//
//  Created by Romana on 24/1/21.
//

import Foundation

public protocol CustomRefreshControllerDelegate{
    func onRefresh()
}

public class CustomRefreshController: UIRefreshControl {
    
    public var delegate:CustomRefreshControllerDelegate!
//    let circleSize: CGFloat = 30
    public var color: UIColor = UIColor.red { didSet{ self.tintColor = color } }
    
    override init() {
        super.init()
        self.viewSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewSetup()
    }

     func viewSetup() {
        
//        self.tintColor = UIColor.red
        
         self.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
//                let imageView: UIImageView = UIImageView(frame: CGRect(x: ((width/2)-(circleSize/2)), y: 10, width: circleSize, height: circleSize))
//                imageView.image = UIImage(named: "ic_refresh_white.png")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
//                imageView.tintColor = UIColor(hexString:  StorageUtils().getSecondaryColorPref())
//
//        self.insertSubview(imageView, at: 0)
    }
    
    @objc private func refreshData(_ sender: Any) {
        if (delegate != nil) {
            delegate.onRefresh()
        }
    }
    
    
    func setInTable(tableView: UITableView){
        if #available(iOS 10.0, *) {
            tableView.refreshControl = self
        } else {
            tableView.addSubview(self)
        }
        
    }
    
}
