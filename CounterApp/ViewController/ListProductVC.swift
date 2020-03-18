//
//  ListProductVC.swift
//  CounterApp
//
//  Created by Chanh Dat Ng on 10/18/19.
//  Copyright © 2019 Chanh Dat Ng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ListProductVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tbvProducts : UITableView!
    var listProducts : [Products] = []
    let db = Firestore.firestore()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbvProducts.backgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "LIST PRODUCTS"
        self.tbvProducts.delegate = self
        self.tbvProducts.dataSource = self
        self.tbvProducts.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        self.tbvProducts.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        //Ultilities.share.updateProducts()
       // self.listProducts = self.delegate.listProducts
        self.listProducts = self.delegate.listProducts
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tbvProducts.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listProducts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        cell.lblAmount.text = "\(self.listProducts[indexPath.section].count)"
        cell.lblName.text = self.listProducts[indexPath.section].name
        cell.lblDescription.text = "Store " + self.listProducts[indexPath.section].store + ", " + self.listProducts[indexPath.section].company
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(5)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = .clear
        return headerView
    }
}

