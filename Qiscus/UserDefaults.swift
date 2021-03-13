//
//  UserDefaults.swift
//  Qiscus
//
//  Created by hilmy ghozy on 13/03/21.
//

import Foundation


extension UserDefaults{
    
    //MARK: Save Device Token
    func setDeviceToken(value: String){
        set(value, forKey: "deviceTokenKey")
        //synchronize()
    }
    
    //MARK: Retrieve User Data
    func getDeviceToken() -> String?{
        return string(forKey: "deviceTokenKey")
    }
}

