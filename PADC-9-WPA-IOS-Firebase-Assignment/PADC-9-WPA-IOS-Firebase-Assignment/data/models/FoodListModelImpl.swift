//
//  FoodListModelImpl.swift
//  PADC-9-WPA-IOS-Firebase-Assignment
//
//  Created by Waiphyoag on 10/24/19.
//  Copyright © 2019 Waiphyoag. All rights reserved.
//

import Foundation
import FirebaseFirestore
class FoodListModelImpl : BaseModel {
    
    static let shared = FoodListModelImpl()
    private override init() {}
    
    static let DB_COLLECTION_PATH_ENTREE = "Entrees"
    static let DB_COLLECTION_PATH_DESSERT = "Desserts"
    static let DB_COLLECTION_PATH_DRINK = "Drinks"
    static let DB_COLLECTION_PATH_MAIN = "Mains"
    
    let db = Firestore.firestore()
    

    var entrees : [EntreeVO] = []
    

    var listener : ListenerRegistration!

    func baseQuery()-> Query {
        return Firestore.firestore().collection(FoodListModelImpl.DB_COLLECTION_PATH_ENTREE)
       
    }
    func baseQuery1()-> Query {
        return Firestore.firestore().collection(FoodListModelImpl.DB_COLLECTION_PATH_DESSERT)

    }
    func baseQuery2()-> Query {
        return Firestore.firestore().collection(FoodListModelImpl.DB_COLLECTION_PATH_DRINK)
        
    }
    func baseQuery3()-> Query {
        return Firestore.firestore().collection(FoodListModelImpl.DB_COLLECTION_PATH_MAIN)
        
    }
    
    var query : Query? {
        didSet {
            if let listener = listener {
                listener.remove() // query koh viewdidload mhr htae ya mel
            }
        }
    }

    
    
}
extension FoodListModelImpl : FoodListModel {
    
    func addFoodList(foodType: String, foodName: String, rating: String, price: String, imageUrl: String, waitingTime: String) {
        
        switch foodType {
        case "Entrees":
            db.collection(FoodListModelImpl.DB_COLLECTION_PATH_ENTREE).addDocument(data:
                [
                    "amount": price,
                    "food_name" :foodName,
                    "imageUrl" : imageUrl,
                    "rating" :rating,
                    "waiting_time": waitingTime
                ])
            break
        case "Drinks":
            db.collection(FoodListModelImpl.DB_COLLECTION_PATH_DRINK).addDocument(data:
                [
                    "amount": price,
                    "food_name" :foodName,
                    "imageUrl" : imageUrl,
                    "rating" :rating,
                    "waiting_time": waitingTime
                ])
            
            break
        case "Mains":
            
            db.collection(FoodListModelImpl.DB_COLLECTION_PATH_MAIN).addDocument(data:
                [
                    "amount": price,
                    "food_name" :foodName,
                    "imageUrl" : imageUrl,
                    "rating" :rating,
                    "waiting_time": waitingTime
                ])
            
            break
        case "Desserts":
            db.collection(FoodListModelImpl.DB_COLLECTION_PATH_DESSERT).addDocument(data:
                [
                    "amount": price,
                    "food_name" :foodName,
                    "imageUrl" : imageUrl,
                    "rating" :rating,
                    "waiting_time": waitingTime
                ])
                
            break
            
        default:
            break
        }
        
    }
    
    
   
    
   
    func getFoodList(success: @escaping ([EntreeVO]) -> Void, fail: @escaping (String) -> Void) {
        
        query?.addSnapshotListener({ (querySnapShot, err) in
            
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
            
            
                let result = querySnapShot?.documents.map({ (document) -> EntreeVO in
                    if let foodEntreeData = EntreeVO(dictionary: document.data(), id: document.documentID){
                        return foodEntreeData
                    } else {
                        fatalError()
                    }
                    
            
                })
            if let data = result {
                success(data)
            }
            
            
    })
}
    
    
}
        

    
   
    
    
