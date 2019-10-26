//
//  FoodListTableViewCell.swift
//  PADC-9-WPA-IOS-Firebase-Assignment
//
//  Created by Waiphyoag on 10/24/19.
//  Copyright © 2019 Waiphyoag. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage

class FoodListTableViewCell: UITableViewCell {

    @IBOutlet weak var img_food: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var rating_star: CosmosView!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var mData : EntreeVO? {
        didSet {
            if let data = mData {
                lblFoodName.text = data.food_name
                img_food.sd_setImage(with: URL(string: data.imageUrl), completed: nil)
                lblDuration.text = "Prep in \(data.waiting_time) "
                lblPrice.text = " $\(data.amount)"
                let rating = Double(data.rating)
                rating_star.rating = rating ?? 5
                
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
