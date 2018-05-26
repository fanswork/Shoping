//
//  Product+CoreDataProperties.swift
//  Shoping
//
//  Created by Admin on 2018/5/23.
//  Copyright © 2018年 Peter He. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var paid: Bool
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var quantity: Double
    @NSManaged public var note: String?

}
