//
//  productsModel.swift
//  iOSAssignment
//
//  Created by Vishal Jagtap on 26/04/22.
//

import Foundation
class Products : NSObject{
    var title : String?
    var price : Double?
    var productdescription : String?
    var image : String?
    var rating : [rating]
    init(title:String, price:Double,productdescription:String,image:String,rating:[rating]){
        self.title = title
        self.price = price
        self.productdescription = productdescription
        self.image = image
        self.rating = rating
    }
}

class rating : NSObject{
    var rate : Double?
    init(rate:Double) {
        self.rate  = rate
    }
}
