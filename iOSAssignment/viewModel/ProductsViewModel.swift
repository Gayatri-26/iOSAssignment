//
//  ProductsViewModel.swift
//  iOSAssignment
//
//  Created by Vishal Jagtap on 26/04/22.
//

import Foundation
class ProductsViewModel:NSObject{
    var title : String?
    var price : Int?
    var productdescription : String?
    var image : String?
    var rating : [Int:Rating]
    
    init(productData:Products){
        self.title = productData.title
        self.price = productData.price
        self.productdescription = productData.productdescription
        self.image = productData.image
        self.rating = productData.rating
        
    }
    
}

class Rating : NSObject{
    var rate : Int?
    init(rate:Int) {
        self.rate  = rate
    }
}
