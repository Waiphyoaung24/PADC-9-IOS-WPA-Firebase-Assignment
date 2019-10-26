//
//  FoodListModel.swift
//  PADC-9-WPA-IOS-Firebase-Assignment
//
//  Created by Waiphyoag on 10/24/19.
//  Copyright © 2019 Waiphyoag. All rights reserved.
//

import Foundation
protocol FoodListModel {
 
    func getFoodList(success: @escaping ([EntreeVO]) -> Void, fail: @escaping (String) -> Void)
    
    func addFoodList(foodType : String,foodName :String, rating : String, price : String,imageUrl : String,waitingTime :String)
    

}
