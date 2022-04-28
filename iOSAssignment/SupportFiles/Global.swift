//
//  Global.swift
//  iOSAssignment
//
//  Created by Vishal Jagtap on 28/04/22.
//

import Foundation

let MSG_NO_INTERNET = "No Internet connection available..!"

func isInternetAvailable() -> Bool {
    
    let reachability = Reachability.forInternetConnection()
    let networkStatus = reachability?.currentReachabilityStatus()
    
    return !(networkStatus == .NotReachable)
}
