//
//  ViewController.swift
//  PADC-9-WPA-IOS-Firebase-Assignment
//
//  Created by Waiphyoag on 10/24/19.
//  Copyright © 2019 Waiphyoag. All rights reserved.
//

import UIKit
import MaterialComponents
import FirebaseFirestore

class ViewController: UIViewController {

    @IBOutlet weak var tableViewFoodList: UITableView!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var FAButton: UIButton!
    @IBOutlet weak var viewEntrees: CardView!
    @IBOutlet weak var viewDesserts: CardView!
    @IBOutlet weak var viewDrinks: CardView!
    @IBOutlet weak var viewMains: CardView!
    
    @IBOutlet weak var btnEntrees: UIButton!
    @IBOutlet weak var btnMains: UIButton!
    @IBOutlet weak var btnDrinks: UIButton!
    
    @IBOutlet weak var btnDesserts: UIButton!
    
    var entrees : [EntreeVO] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()


        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        getEntreeFoodList()
        viewMains.backgroundColor = .none
        viewDrinks.backgroundColor = .none
        viewDesserts.backgroundColor = .none
        viewEntrees.backgroundColor = UIColor.black
        btnEntrees.setTitleColor(.white, for: .normal)
        
       

    }
    
    @IBAction func onTapDrinkList(_ sender: Any) {
        getDrinkList()
        viewMains.backgroundColor = .none
        viewDrinks.backgroundColor = UIColor.black
        viewDesserts.backgroundColor = .none
        viewEntrees.backgroundColor = .none
        btnDrinks.setTitleColor(.white, for: .normal)
        btnEntrees.setTitleColor(.black, for: .normal)
        btnMains.setTitleColor(.black, for: .normal)
        btnDesserts.setTitleColor(.black, for: .normal)




        
        
    }
    @IBAction func onTapMainList(_ sender: Any) {
        getMainList()
        viewMains.backgroundColor = UIColor.black
        viewDrinks.backgroundColor = .none
        viewDesserts.backgroundColor = .none
        viewEntrees.backgroundColor = .none
        btnDrinks.setTitleColor(.black, for: .normal)
        btnEntrees.setTitleColor(.black, for: .normal)
        btnMains.setTitleColor(.white, for: .normal)
        btnDesserts.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func onTapEntreeList(_ sender: Any) {
        getEntreeFoodList()
        viewMains.backgroundColor = .none
        viewDrinks.backgroundColor = .none
        viewDesserts.backgroundColor = .none
        viewEntrees.backgroundColor = UIColor.black
        btnDrinks.setTitleColor(.black, for: .normal)
        btnEntrees.setTitleColor(.white, for: .normal)
        btnMains.setTitleColor(.black, for: .normal)
        btnDesserts.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func onTapDessert(_ sender: Any) {
        getDessertFoodList()
        viewMains.backgroundColor = .none
        viewDrinks.backgroundColor = .none
        viewDesserts.backgroundColor = UIColor.black
        viewEntrees.backgroundColor = .none
        btnDrinks.setTitleColor(.black, for: .normal)
        btnEntrees.setTitleColor(.black, for: .normal)
        btnMains.setTitleColor(.black, for: .normal)
        btnDesserts.setTitleColor(.white, for: .normal)

    }
    override func viewWillDisappear(_ animated: Bool) {
        FoodListModelImpl.shared.listener?.remove()
    }
    
    func initView() {
        
        viewRating.layer.cornerRadius =
        viewRating.frame.height/2
        viewRating.layer.masksToBounds = true
        
        tableViewFoodList.delegate = self
        tableViewFoodList.dataSource = self
        tableViewFoodList.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        let nib = UINib(nibName: String(describing: FoodListTableViewCell.self), bundle: nil)
        tableViewFoodList.register(nib, forCellReuseIdentifier: String(describing: FoodListTableViewCell.self))
        
        let floatingButton = MDCFloatingButton()
        floatingButton.setImage( UIImage(named: "icons8-plus_math_filled"), for: .normal)
        floatingButton.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        floatingButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        floatingButton.frame = CGRect(x: self.view.frame.width-80, y: self.view.frame.height-80, width: 48, height: 48)
        floatingButton.addTarget(self, action: #selector(btnFloatingButtonTapped(floatingButton:)), for: .touchUpInside)
        self.view.addSubview(floatingButton)
        
    }
    @objc func btnFloatingButtonTapped(floatingButton: MDCFloatingButton){
        floatingButton.collapse(true) {
            floatingButton.expand(true, completion: nil)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: String(describing: AddToFoodListViewController.self)) as? AddToFoodListViewController
            if let viewController = vc {
                self.present(viewController, animated: true, completion: nil)
            }
            
        }
    }
    
    func getMainList() {
        FoodListModelImpl.shared.query = FoodListModelImpl.shared.baseQuery3()
        FoodListModelImpl.shared.getFoodList(success: { (data) in
            self.entrees = data
            self.tableViewFoodList.reloadData()
        }) { (err) in
            print(err)
        }
    }
    
    func getDessertFoodList(){
        FoodListModelImpl.shared.query = FoodListModelImpl.shared.baseQuery1()
        FoodListModelImpl.shared.getFoodList(success: { (data) in
            self.entrees = data
            self.tableViewFoodList.reloadData()
        }) { (err) in
            print(err)
        }
    }
        
    
    func getDrinkList(){
        
        FoodListModelImpl.shared.query = FoodListModelImpl.shared.baseQuery2()
        FoodListModelImpl.shared.getFoodList(success: { (data) in
            self.entrees = data
            self.tableViewFoodList.reloadData()
        }) { (err) in
            print(err)
        }
        
    }

    func getEntreeFoodList() {
        
        FoodListModelImpl.shared.query = FoodListModelImpl.shared.baseQuery()
        FoodListModelImpl.shared.getFoodList(success: { (data) in
            self.entrees = data
            self.tableViewFoodList.reloadData()
        }) { (err) in
            print(err)
        }
    }

}


extension ViewController : UITableViewDelegate {
    
}
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entrees.count ?? 0
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodListTableViewCell.self), for: indexPath) as! FoodListTableViewCell
        cell.mData = entrees[indexPath.row]
        return cell
    }
    
    
}
