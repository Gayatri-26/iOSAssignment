//
//  DataBaseHelper.swift
//  iOSAssignment
//
//  Created by Vishal Jagtap on 28/04/22.
//

import Foundation
import CoreData
import UIKit
class DataBaseHelper {
    
    static let shareInstance = DataBaseHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveData(Image: Data,Price:Double,Title:String,Rate:Double,Description:String) {
        
        let productDataInstance = ProductsData(context: context)
        productDataInstance.image = Image
        productDataInstance.pdescription = Description
        productDataInstance.title = Title
        productDataInstance.price = Price
        productDataInstance.rate = Rate
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func fetchData() -> [ProductsData] {
        var fetchingProductData = [ProductsData]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductsData")
        
        do {
            fetchingProductData = try context.fetch(fetchRequest) as! [ProductsData]
        } catch {
            print("Error while fetching the image")
        }
        return fetchingProductData
    }
}
