//
//  AddVC.swift
//  CounterApp
//
//  Created by Chanh Dat Ng on 10/18/19.
//  Copyright © 2019 Chanh Dat Ng. All rights reserved.
//

import UIKit

class AddVC: UIViewController, BaseButtonDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var txtID : UITextField!
    @IBOutlet weak var txtName : UITextField!
    @IBOutlet weak var txtCompany : UITextField!
    @IBOutlet weak var txtStore : UITextField!
    @IBOutlet weak var vContainer : UIView!
    
    @IBOutlet weak var vID : UIView!
    @IBOutlet weak var vName : UIView!
    @IBOutlet weak var vCompany : UIView!
    @IBOutlet weak var vStore : UIView!
    
    @IBOutlet weak var btnAdd : BaseButton!
    @IBOutlet weak var btnExit : BaseButton!
    var activateTxf : UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnAdd.dele = self
        self.btnExit.dele = self
        
        // UI Button
        self.btnAdd.btnButton.setTitle("ADD", for: .normal)
        self.btnAdd.setColor(hexStringToUIColor(hex: "#E8FFE3"))
        self.btnAdd.setCornerRadious(15)
        
        self.btnExit.btnButton.setTitle("EXIT", for: .normal)
        self.btnExit.setColor(hexStringToUIColor(hex: "#E8FFE3"))
        self.btnExit.setCornerRadious(15)
        
        self.vContainer.layer.cornerRadius = 15
        // UI View
        self.vID.borderColor = .clear
        self.vName.borderColor = .clear
        self.vCompany.borderColor = .clear
        self.vStore.borderColor = .clear
        
        self.txtID.layer.cornerRadius = 5
        self.txtName.layer.cornerRadius = 5
        self.txtCompany.layer.cornerRadius = 5
        self.txtStore.layer.cornerRadius = 5
        
        self.txtID.delegate = self
        self.txtName.delegate = self
        self.txtCompany.delegate = self
        self.txtStore.delegate = self
//        self.scvScroll.keyboardDismissMode = .interactive
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(noti:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activateTxf = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillHide(noti: Notification){
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    @objc func keyboardDidShow(noti: Notification){
        print("keyboard :\(noti.name.rawValue)")
        let info:NSDictionary = noti.userInfo! as NSDictionary
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        let editingTextFieldY : CGFloat! = self.activateTxf.superview!.frame.origin.y
        
        
        if (self.view.frame.origin.y >= 0){
            if editingTextFieldY > keyboardY - 130 {
                UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY! - (keyboardY - 170)), width: self.view.bounds.width, height: self.view.bounds.height)
                }, completion: nil)
            }
        }
    }
    
    func clickButton(_ view: UIView, _ sender: UIButton) {
        
        if (view == self.btnExit){
            print("clickExit")
            UIView.transition(with: self.view, duration: 1, options: [.transitionCurlUp], animations: {
                self.view.removeFromSuperview()
            }, completion: nil)
            
        }
        if (view == self.btnAdd){
            print("clickAdd")
            
            if (txtID.text == ""){
                Ultilities.share.alertMessageBox("WARNING!", "Please enter ID - PRODUCT!", "OK", self)
            } else if (txtName.text == ""){
                Ultilities.share.alertMessageBox("WARNING!", "Please enter name of product!", "OK", self)
            } else if (txtCompany.text == ""){
                Ultilities.share.alertMessageBox("WARNING!", "Please enter company of product!", "OK", self)
            } else if (txtStore.text == ""){
                Ultilities.share.alertMessageBox("WARNING!", "Please enter where to store!", "OK", self)
            } else {
//                self.newProduct?.id = self.txtID.text!
//                self.newProduct?.name = self.txtName.text!
//                self.newProduct?.company = self.txtCompany.text!
//                self.newProduct?.store = self.txtStore.text!
                let newProduct = Products.init(self.txtID.text!, self.txtName.text!, 0, self.txtCompany.text!, self.txtStore.text!)
                let vc = Ultilities.share.createVCwith("Main", "CountProductVC") as! CountProductVC
                vc.new_product = newProduct
                print(newProduct)
                
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.nvc.present(vc, animated: true, completion: nil)
            }

        }
    }
}
