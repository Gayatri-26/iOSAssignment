//
//  ViewController.swift
//  iOSAssignment
//
//  Created by Vishal Jagtap on 26/04/22.
//

import UIKit

class ProductsVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    
    @IBOutlet weak var productsTblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var productsArr = [Products]()
    var filterSearchProductArr = [Products]()
    var ProductsDataArr = [ProductsData]()
    var filterProductDataArr = [ProductsData]()
    var Searching = false
    var isInternet = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadingView.layer.cornerRadius = 6
        
        productsTblView.delegate = self
        productsTblView.dataSource = self
        productsTblView.register(UINib(nibName: "DisplayProductsTableViewCell", bundle: nil), forCellReuseIdentifier: "DisplayProductsTableViewCell")
        
        searchBar.delegate = self
        self.showSpinner()
        
        self.callApiData()
        
    }
    
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
    }
    
    private func hideSpinner() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.loadingView.isHidden = true
        }
    }
    
    func callApiData(){
        self.showSpinner()
        if !isInternetAvailable(){
            self.hideSpinner()
            ProductsDataArr = DataBaseHelper.shareInstance.fetchData()
            
        }else{
            isInternet = true
            ProductsDataArr = DataBaseHelper.shareInstance.fetchData()
            Service.shareInstance.getProductList { (response,err)  in
                if(err==nil){
                    for i in (response)!{
                        self.hideSpinner()
                        self.productsArr.append(i)
                        if(self.ProductsDataArr.count == 0){
                            DataBaseHelper.shareInstance.saveData(Image: Data(i.image!.utf8), Price: i.price ?? 0.0, Title: i.title ?? "", Rate: i.rating[0].rate ?? 0.0, Description: i.productdescription ?? "")
                        }
                        DispatchQueue.main.async {
                            self.productsTblView.reloadData()
                        }
                    }
                    
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isInternetAvailable(){
            if Searching{
                return filterProductDataArr.count
            }else{
                return ProductsDataArr.count
            }
            
        }else{
            if Searching {
                return filterSearchProductArr.count
            }else{
                return productsArr.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayProductsTableViewCell", for: indexPath) as! DisplayProductsTableViewCell
        if !isInternetAvailable(){
            let displayData = Searching ? filterProductDataArr[indexPath.row] : ProductsDataArr[indexPath.row]
            cell.productName.text = displayData.title
            cell.productPrice.text = "₹ " + String(describing:displayData.price)
            cell.procuctRating.text = String(describing:displayData.rate)
        }else{
            let displayData = Searching ? filterSearchProductArr[indexPath.row] : productsArr[indexPath.row]
            cell.productName.text = displayData.title
            cell.productPrice.text = "₹ " + String(describing:displayData.price!)
            let rate = displayData.rating
            
            cell.procuctRating.text = String(describing:rate[0].rate!)
            DispatchQueue.global(qos: .userInitiated).async{
                let data = try? Data(contentsOf: URL.init(string: displayData.image ?? "")!)
                DispatchQueue.main.async {
                    cell.productImg.image = UIImage(data: data!)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailVC  = self.storyboard!.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        if !isInternetAvailable(){
            let displayData = Searching ? filterProductDataArr[indexPath.row] : ProductsDataArr[indexPath.row]
            productDetailVC.Ptitle = displayData.title
            productDetailVC.Price = displayData.price
            productDetailVC.Pdescription = displayData.pdescription
            productDetailVC.rate = displayData.rate
        }else{
            let displayData = Searching ? filterSearchProductArr[indexPath.row] : productsArr[indexPath.row]
            productDetailVC.Ptitle = displayData.title
            productDetailVC.Price = displayData.price
            productDetailVC.Pdescription = displayData.productdescription
            productDetailVC.image = displayData.image
            productDetailVC.rate = displayData.rating[0].rate
        }
        self.navigationController?.pushViewController(productDetailVC, animated: true)
        
    }
    
}

extension ProductsVC : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        Searching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        Searching = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        Searching = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Searching = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        Searching = true
        if !isInternetAvailable(){
            filterProductDataArr = searchText.isEmpty ? ProductsDataArr : ProductsDataArr.filter({ (name) -> Bool in
                name.title?.range(of: searchText,options: .caseInsensitive) != nil
            })
        }else{
            filterSearchProductArr = searchText.isEmpty ? productsArr : productsArr.filter({ (name) -> Bool in
                name.title?.range(of: searchText,options: .caseInsensitive) != nil
            })
        }
        self.productsTblView.reloadData()
    }
}
