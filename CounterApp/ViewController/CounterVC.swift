//
//  CounterVC.swift
//  CounterApp
//
//  Created by Chanh Dat Ng on 10/17/19.
//  Copyright © 2019 Chanh Dat Ng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class CounterVC: UIViewController, BaseButtonDelegate {

    @IBOutlet weak var btnStart : BaseButton!
    @IBOutlet weak var btnShow : BaseButton!
    @IBOutlet weak var vCounting: UIView!
    @IBOutlet weak var vProducts: UIView!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.navigationController?.navigationBar.topItem?.title = "COUNTER"
        //self.title = "COUNTER"
        self.btnStart.dele = self
        self.btnShow.dele = self
        
        // UI Button
        self.btnShow.btnButton.setTitle("SHOW", for: .normal)
        self.btnShow.setColor(hexStringToUIColor(hex: "#E8FFE3"))
        self.btnShow.setCornerRadious(15)
        self.btnStart.btnButton.setTitle("START", for: .normal)
        self.btnStart.setColor(hexStringToUIColor(hex: "#E8FFE3"))
        self.btnStart.setCornerRadious(15)
        
        // UI View
        self.vCounting.layer.cornerRadius = 15
        self.vProducts.layer.cornerRadius = 15
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "COUNTER"
        self.ref.child("chucNang").setValue("dem san pham")
    }
    

    func clickButton(_ view: UIView, _ sender: UIButton) {
        if (view == self.btnStart){
            print("clickStart")
            let vc = Ultilities.share.createVCwith("Main", "AddVC") as! AddVC
           // self.navigationController?.pushViewController(vc, animated: true)
            
            UIView.transition(with: self.view, duration: 1, options: [.transitionCrossDissolve], animations: {
              self.view.addSubview(vc.view)
            }, completion: nil)
            //self.view.addSubview(vc.view)
            
        }
        
        if (view == self.btnShow){
            print("clickShow")
            let vc = Ultilities.share.createVCwith("Main", "ListProductVC") as! ListProductVC
            //self.navigationController?.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            //Ultilities.share.getProducts()
        }
    }

}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
