//
//  ProductCell.swift
//  CounterApp
//
//  Created by Chanh Dat Ng on 10/18/19.
//  Copyright © 2019 Chanh Dat Ng. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var vContainer : UIView!
    @IBOutlet weak var imvProduct : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    @IBOutlet weak var lblAmount : UILabel!
    
    @IBOutlet weak var vAmount : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.vAmount.layer.cornerRadius = self.vAmount.frame.width/2
        self.vContainer.layer.cornerRadius = 10
        self.imvProduct.layer.cornerRadius = 15
        self.imvProduct?.image = UIImage(named: "arduino")
        self.imvProduct?.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
