//
//  AddToFoodListViewController.swift
//  PADC-9-WPA-IOS-Firebase-Assignment
//
//  Created by Waiphyoag on 10/24/19.
//  Copyright © 2019 Waiphyoag. All rights reserved.
//

import UIKit
import FirebaseStorage
import SDWebImage


class AddToFoodListViewController: UIViewController {

    @IBOutlet weak var ivFoodImage: UIImageView!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tfFoodName: UITextField!
    @IBOutlet weak var tfFoodType: UITextField!
    @IBOutlet weak var tfWaitingTime: UITextField!
    @IBOutlet weak var tfRating: UITextField!
    
    @IBOutlet weak var tfImageUrl: UITextField!
    
    let myPickerData = [String](arrayLiteral: "Mains", "Drinks", "Desserts","Entrees")
    
    var imageReference : StorageReference!
 var imageUrl : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        

    }
    @IBAction func onTapCancel(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
        if let viewController = vc {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onTapGetImageUrl(_ sender: Any) {
        imageReference.downloadURL { (data, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            self.tfImageUrl.text = data?.absoluteString
            
        }
    }
    
    
    @IBAction func onTapCreateNewFood(_ sender: Any) {
        
        
        FoodListModelImpl.shared.addFoodList(foodType: tfFoodType.text ?? "", foodName: tfFoodName.text ?? "", rating: tfRating.text ?? "", price: tfAmount.text ?? "", imageUrl: tfImageUrl.text ?? "", waitingTime: tfWaitingTime.text ?? "")
        self.showAlertdialogForCreate(title: "Success", msg: "Your New Food Is Successfully Added")
        
        
        
    }
    func initView() {
        
        let imageName = UUID().uuidString
        imageReference = Storage.storage().reference().child("image").child(imageName)

        
        let thepicker = UIPickerView()
        tfFoodType.inputView = thepicker
        thepicker.delegate = self
        thepicker.dataSource = self
       
    }

    @IBAction func onTapChooseImage(_ sender: Any) {
        ImagePickerManager().pickImage(self) { (image) in
            self.ivFoodImage.image = image
        }
        
    }
    
    @IBAction func onTapUploadImage(_ sender: Any) {
        
        guard let image = self.ivFoodImage.image , let data = image.jpegData(compressionQuality: 0.5) else {return}
        
        imageReference.putData(data, metadata: nil) { (metadata, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
        }
        self.showAlertdialog(title: "Success", msg: "Your Image is successfully uploaded")
        
       
        
        
    }
    
}

extension AddToFoodListViewController : UIPickerViewDelegate {
    
}
extension AddToFoodListViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfFoodType.text = myPickerData[row]
    }
    
 
    func showAlertdialog(title : String,msg : String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (result) in
        }
        alert.addAction(action)
        present(alert,animated: true)
    }
    
   
    func showAlertdialogForCreate(title : String,msg : String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (result) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert,animated: true)
    }
    
    
}
