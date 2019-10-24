//
//  FoodListTableViewCell.swift
//  PADC-9-WPA-IOS-Firebase-Assignment
//
//  Created by Waiphyoag on 10/24/19.
//  Copyright © 2019 Waiphyoag. All rights reserved.
//

import UIKit
import Cosmos

class FoodListTableViewCell: UITableViewCell {

    @IBOutlet weak var img_food: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var rating_star: CosmosView!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
