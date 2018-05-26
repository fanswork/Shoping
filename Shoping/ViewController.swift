//
//  ViewController.swift
//  Shoping
//
//  Created by Admin on 2018/5/23.
//  Copyright © 2018年 Peter He. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
  
    
    @IBOutlet var cSegment: UISegmentedControl!
    @IBOutlet weak var tableView:UITableView!
   
    var products = [Product]()
    var selectedproducts = [Product]()
    var purchased = [Product]()
    var unpurchased = [Product]()
    func filterproduct(){
        for product in products {
            if product.paid == true {
                purchased.append(product)
            }else{
                unpurchased.append(product)
            }
        }
        selectedproducts = products
    }
    
    func pay(selectIndex:Int){
        let sproduct:Product
        sproduct = products[selectIndex]
        sproduct.paid = true
        PersistenceService.saveContext()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            let products = try PersistenceService.context.fetch(fetchRequest)
            self.products = products
            self.tableView.reloadData()
        }catch{}
        filterproduct()
        // Do any additional setup after loading the view, typically from a nib.
    }
    // Set editing
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
    }
    

    @IBAction func unwindToList(segue:UIStoryboardSegue){
        self.tableView.reloadData()
        
    }


    
    @IBAction func filletdata(_ sender: UISegmentedControl) {
    
        switch cSegment.selectedSegmentIndex {
        case 0:
            selectedproducts = products
            break
        case 1:
            selectedproducts = purchased
            break
        case 2:
            selectedproducts = unpurchased
            
            break
        default:
            selectedproducts = products
            break
        }
        tableView.reloadData()
    }
    
    @IBAction func taptopay(_ sender: UISwitch) {
          
    }
}
  //@IBAction func addItemTapped(){
//        let alert = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
//        alert.addTextField{(textFiled) in
//            textFiled.placeholder = "Name"
//        }
//        alert.addTextField{(textFiled) in
//            textFiled.placeholder = "Price"
//        }
//        alert.addTextField{(textFiled) in
//            textFiled.placeholder = "Quantity"
//        }
//        let action = UIAlertAction(title: "Add", style: .default) { (_) in
//            let name = alert.textFields!.first?.text!
//            let note = alert.textFields!.last?.text!
//            let price = 0
//            let quantity = 0
//            let item = Product(context: PersistenceService.context)
//            item.name = name!
//            item.price = Double(price)
//            item.quantity = Double(quantity)
//            item.note = note!
//            item.paid = false
//            PersistenceService.saveContext()
//            self.product.append(item)
//            self.tableView.reloadData()
//        }
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
//}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
  

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveObjTemp = products[sourceIndexPath.row]
        products.remove(at: sourceIndexPath.item)
        products.insert(moveObjTemp, at: destinationIndexPath.item)
    }
    
    
    // Delete item through editing
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            //tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
            products.remove(at: indexPath.row)
            PersistenceService.saveContext()
            tableView.reloadData()
            cSegment.setEnabled(true, forSegmentAt: indexPath.row)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnVaule = 0
        switch cSegment.selectedSegmentIndex {
        case 0:
            returnVaule = products.count
            break
        case 1:
            returnVaule = purchased.count
            break
        case 2:
            returnVaule = unpurchased.count
            break
        default:
            returnVaule = products.count
            break
        }
        return returnVaule
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pCell", for: indexPath)
       
        let product = selectedproducts[indexPath.row]
        if let productCell = cell as? ProductListTableViewCell{
            productCell.productName.text = product.name
            productCell.productDescription.text = product.note
            productCell.productPrice.text = String(product.price)
            productCell.productQuantity.text = String(product.quantity)
            productCell.purchasedState.isHidden = true
            productCell.accessoryType = UITableViewCellAccessoryType.checkmark
            if product.paid {
            productCell.changeText.text = "Paid"
            productCell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
            else {
                productCell.purchasedState.isHidden = false
                productCell.changeText.text = "Pay"
                 productCell.accessoryType = UITableViewCellAccessoryType.none
                
            }
           // if productCell.payTopaid.accessibilityCustomActions
            // Configure the cell...
        }
        return cell

        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
//            products[indexPath.row].paid = false
//            PersistenceService.saveContext()
            
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
//            products[indexPath.row].paid = true
//            PersistenceService.saveContext()
            
        }
        
        
        
    }
}

