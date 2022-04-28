//
//  ProductsData+CoreDataProperties.swift
//  iOSAssignment
//
//  Created by Vishal Jagtap on 28/04/22.
//
//

import Foundation
import CoreData


extension ProductsData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsData> {
        return NSFetchRequest<ProductsData>(entityName: "ProductsData")
    }

    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var rate: Double
    @NSManaged public var pdescription: String?

}

extension ProductsData : Identifiable {

}
