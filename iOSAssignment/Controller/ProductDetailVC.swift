//
//  ProductDetailVC.swift
//  iOSAssignment
//
//  Created by Vishal Jagtap on 27/04/22.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    
    var Ptitle: String?
    var Price : Double?
    var Pdescription: String?
    var rate:Double?
    var image:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Products Details"
        self.lblTitle.text = Ptitle
        self.lblPrice.text = "₹ " + String(describing:Price!)
        self.lblDescription.text = Pdescription
        self.lblRate.text = String(describing:rate!)
        if !isInternetAvailable(){}
        else{
            DispatchQueue.global(qos: .userInitiated).async{
                let data = try? Data(contentsOf: URL.init(string: self.image ?? "")!)
                DispatchQueue.main.async {
                    self.productImg.image = UIImage(data: data!)
                    
                }
            }
        }
        
        
    }
    
}
