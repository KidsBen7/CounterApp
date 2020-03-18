//
//  Ultilities.swift
//  CounterApp
//
//  Created by Chanh Dat Ng on 10/18/19.
//  Copyright © 2019 Chanh Dat Ng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class Ultilities: NSObject {

    static let share = Ultilities()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    
    
    func createVCwith(_ nameSB: String, _ nameVC: String) -> UIViewController {
        return UIStoryboard.init(name: nameSB, bundle: nil).instantiateViewController(withIdentifier: nameVC)
    }
    
    func alertMessageBox(_ title: String,_ message: String, _ button: String,_ view: UIViewController){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        view.present(alert, animated: true, completion: nil)
    }
    

}
