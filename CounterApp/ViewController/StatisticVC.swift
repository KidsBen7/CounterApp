//
//  StatisticVC.swift
//  CounterApp
//
//  Created by Chanh Dat Ng on 10/12/19.
//  Copyright © 2019 Chanh Dat Ng. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseFirestore


class StatisticVC: UIViewController, BaseButtonDelegate {
    
    @IBOutlet weak var vContainer : UIView!
    @IBOutlet weak var lblDay : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblCustomer : UILabel!
    @IBOutlet weak var btnSave : BaseButton!
    @IBOutlet weak var btnStatistic : BaseButton!
    
    var id : String?
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    let ref = Database.database().reference()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "STATISTIC"
        self.btnSave.dele = self
        self.btnStatistic.dele = self
        
        self.vContainer.layer.cornerRadius = 20
        self.btnSave.btnButton.setTitle("SAVE", for: .normal)
        self.btnSave.setColor(hexStringToUIColor(hex: "#E8FFE3"))
        self.btnSave.setCornerRadious(15)
        
        self.btnStatistic.btnButton.setTitle("STATISTIC", for: .normal)
        self.btnStatistic.setColor(hexStringToUIColor(hex: "#E8FFE3"))
        self.btnStatistic.setCornerRadious(15)
        //var demNguoi : Int?
        // Do any additional setup after loading the view.
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMMM-yyyy"
        let dateString = dateFormatter.string(from: currentDate)
        self.lblDate.text = dateString
        self.lblCustomer.text = "0"
        
        let id_date = "\(currentDate.getDay())"
        let id_month = "\(currentDate.getMonth())"
        let id_year = "\(currentDate.getYear())"
        id = id_date+id_month+id_year
        self.lblDay.text = currentDate.dayOfWeek()
        
//        ref.child("thongKe/ngayThang").setValue("12/10/2019")
        ref.child("thongKe/demNguoi").observe(.value) { (snapshot) in
            let demNguoi = snapshot.value as? Int
            self.lblCustomer.text = "\(demNguoi!/2)";
        }
        }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "STATISTIC"
        self.ref.child("chucNang").setValue("dem nguoi")
    }
    
        func clickButton(_ view: UIView, _ sender: UIButton) {
            if (view == self.btnSave){
                //
                db.collection("Customers").document(self.id!).setData([
                    "Day": self.lblDay.text!,
                    "Count": Int(self.lblCustomer.text!)!/2
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                Ultilities.share.alertMessageBox("UPDATED!", "Your data has just been updated!", "OK", self)
                print("clickSave")
            }
            if (view == self.btnStatistic){
                let vc = Ultilities.share.createVCwith("Main", "ChartsVC") as! ChartsVC
                self.navigationController?.present(vc, animated: true, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true)
            }
    }

}
