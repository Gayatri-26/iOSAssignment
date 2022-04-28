//
//  Response.swift
//  iOSAssignment
//
//  Created by Vishal Jagtap on 26/04/22.
//

import Foundation
class Response {
    
    // MARK:- Variables
    
    var response_code: Int?
    var message: String?
    var data: AnyObject?
    
    // MARK:- Initializers
    init(withStatus response_code : Int?, message : String?, andResponseObject data : AnyObject?) {
        
        self.response_code = response_code
        self.message = message
        self.data = data
        
    }
    
}

