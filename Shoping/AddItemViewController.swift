//
//  AddItemViewController.swift
//  Shoping
//
//  Created by Admin on 2018/5/24.
//  Copyright © 2018年 Peter He. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var quantityField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextView!
    @IBOutlet var paidSwitch: UISwitch!
    @IBOutlet var remindMessage: UITextField!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func AddToList(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToList", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "unwindToList"{
            let fvc = segue.destination as? ViewController
            let newItem = Product(context: PersistenceService.context)
            guard let text = nameTextField.text, !text.isEmpty else {
                remindMessage.text = "Please enter an item name!"
                return
            }
            newItem.name = text
            let paid:Bool = paidSwitch.isOn
            newItem.paid = paid
            newItem.paid = false
            remindMessage.isHidden = true 
            guard let price = priceTextField.text, !price.isEmpty else {
                newItem.price = 0
                return
            }
            newItem.price = Double(price)!
            guard let quantity = quantityField.text, !quantity.isEmpty else {
                newItem.quantity = 0
                return
            }
            newItem.quantity = Double(quantity)!
            
            guard let note = descriptionTextField.text, !note.isEmpty else{
                newItem.note = ""
                return
            }
            newItem.note = note
            PersistenceService.saveContext()
            fvc?.products.append(newItem)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
