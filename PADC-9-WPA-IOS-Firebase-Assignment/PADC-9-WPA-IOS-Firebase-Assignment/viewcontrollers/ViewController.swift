//
//  ViewController.swift
//  PADC-9-WPA-IOS-Firebase-Assignment
//
//  Created by Waiphyoag on 10/24/19.
//  Copyright © 2019 Waiphyoag. All rights reserved.
//

import UIKit
import MaterialComponents

class ViewController: UIViewController {

    @IBOutlet weak var tableViewFoodList: UITableView!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var FAButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
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
        }
    }
    


}


extension ViewController : UITableViewDelegate {
    
}
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodListTableViewCell.self), for: indexPath) as! FoodListTableViewCell
        return cell
    }
    
    
}
