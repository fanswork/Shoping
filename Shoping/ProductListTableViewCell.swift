//
//  ProductListTableViewCell.swift
//  Shoping
//
//  Created by Admin on 2018/5/23.
//  Copyright © 2018年 Peter He. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell{
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productQuantity: UILabel!
    @IBOutlet var productDescription: UILabel!
    @IBOutlet var purchasedState: UISwitch!
    @IBOutlet var payTopaid: UISwitch!
    @IBOutlet var changeText: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

    
}
