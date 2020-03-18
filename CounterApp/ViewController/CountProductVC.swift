//
//  CountProductVC.swift
//  CounterApp
//
//  Created by Chanh Dat Ng on 10/18/19.
//  Copyright © 2019 Chanh Dat Ng. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseFirestore

class CountProductVC: UIViewController, BaseButtonDelegate {

    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var imvProduct : UIImageView!
    @IBOutlet weak var lblCount : UILabel!
    @IBOutlet weak var vContainer : UIView!
    @IBOutlet weak var btnDone : BaseButton!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    var new_product : Products?
    let db = Firestore.firestore()
    let ref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnDone.dele = self
        self.btnDone.btnButton.setTitle("DONE", for: .normal)
        self.btnDone.setColor(hexStringToUIColor(hex: "#E8FFE3"))
        self.btnDone.setCornerRadious(15)
        self.vContainer.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
        self.lblName.text = self.new_product?.name
        
        ref.child("demSanPham").observe(.value) { (snapshot) in
            let count = snapshot.value as? Int
            self.lblCount.text = "\(count!)";
        }
    }
    
    func clickButton(_ view: UIView, _ sender: UIButton) {
        if (view == self.btnDone) {
            // Save Data
            
            let id = self.new_product?.id
            let name = self.new_product?.name
            let company = self.new_product?.company
            let store = self.new_product?.store
            
            db.collection("Products").document(id!).setData([
                "Name": name!,
                "Company": company!,
                "Store": store!,
                "Count": Int(self.lblCount.text!) ?? 0
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
            self.new_product?.count = Int(self.lblCount.text!) ?? 0
            self.delegate.listProducts.append(new_product!)
            
            self.ref.updateChildValues(["demSanPham":0])
            print("clickDone")
            self.dismiss(animated: true, completion: nil)
            
            
        }
    }

}
