//
//  webServices.swift
//  iOSAssignment
//
//  Created by Vishal Jagtap on 26/04/22.
//

import Foundation


class Service : NSObject {
    
    static let shareInstance = Service()
    let session = URLSession.shared
    
    func getProductList(_ completion : @escaping([Products]?, Error?) -> ()){
        
        let url = URL(string:"https://fakestoreapi.com/products")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            // Check if there is an error from response
            if error != nil {
                
                // Create a Response object, set it's status and message
                // and call the completion block
               
                return
                
            } else {
                
                // Check if data is nil
                if let responseData = data {
                    
                    // Create Object from data
                    do {
                        let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                        
                        var productArr = [Products]()
                        
                        for i in responseJSON as! [AnyObject]{
                            
                            let title = i["title"] as? String ?? ""
                            let price = i["price"] as? Double ?? 0.0
                            let description = i["description"] as? String ?? ""
                            let image = i["image"] as? String ?? ""
                            //                            let Rating = i["rating"] as? NSDictionary
                            var ratingArr = [rating]()
                            if let Rating =  i["rating"] as? NSDictionary {
                                let rate = Rating["rate"]as? Double ?? 0.0
                                let rateData = rating(rate: rate)
                                ratingArr.append(rateData)
                                
                                let productdata = Products(title: title, price: price, productdescription: description, image: image, rating: ratingArr)
                                productArr.append(productdata)
                                
                            }
                        }
                        completion(productArr, nil)
                        
                    } catch {
                        
                    }
                }
            }
        }
        dataTask.resume()
        
        
    }
}
