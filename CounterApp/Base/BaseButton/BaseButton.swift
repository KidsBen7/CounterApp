//
//  BaseButton.swift
//  CounterApp
//
//  Created by Chanh Dat Ng on 10/17/19.
//  Copyright © 2019 Chanh Dat Ng. All rights reserved.
//

import UIKit
protocol BaseButtonDelegate {
    func clickButton(_ view:UIView, _ sender: UIButton)
}
class BaseButton: UIView {

    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var btnButton: UIButton!
    var dele: BaseButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    func defaultInit() {
        let bundle = Bundle(for: BaseButton.self)
        bundle.loadNibNamed("BaseButton", owner: self, options: nil)
        self.vContainer.fixInView(self)
    }
    
    func setCornerRadious(_ cr: CGFloat){
        self.vContainer.layer.cornerRadius = cr
    }
    
    func setColor(_ color: UIColor){
        self.vContainer.backgroundColor = color
    }
    
    @IBAction func onBtn(_ sender: Any) {
        self.dele?.clickButton(self,btnButton)
    }

}

extension UIView {
    func fixInView(_ container: UIView!) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        
        NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
