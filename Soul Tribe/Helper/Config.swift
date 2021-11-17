//
//  Config.swift
//  Hyak
//
//  Created by mac-16 on 3/18/20.
//  Copyright © 2020 mac-16. All rights reserved.
//


import Foundation
import UIKit
import CoreData


class Config: NSObject,UIAlertViewDelegate {
    let API_URL = "https://tribe.devtechnosys.tech/api/user/"
    let AppUserDefaults = UserDefaults.standard
    let debug_mode = 1
    
    let api_key = "tribe123"
    
    let googleApiKey = "AIzaSyD0tudEKZMvuqLW-cxqQ-qtSrHIZjzlFm8"
    
    /********************************* App Color Codes ***************************************/
//    #16C79A
   
    let AppThemeMainColor = UIColor(red: 0.09, green: 0.78, blue: 0.60, alpha: 0.5)
}
