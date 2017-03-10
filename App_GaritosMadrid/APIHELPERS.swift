//
//  APIHELPERS.swift
//  App_GaritosMadrid
//
//  Created by formador on 10/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

//MARK: - Alert Controler
func muestraAlert(_ titleData : String, messageData : String, titleAction : String) -> UIAlertController{
    let alert = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: titleAction, style: .default, handler: nil))
    return alert
}

//MARK: - Null to String
func dimeString(_ json : JSON, nombreKey : String) -> String{
    if let stringResult = json[nombreKey].string{
        return stringResult
    }else{
        return ""
    }
}

//MARK: - Null to Int
func dimeInt(_ json : JSON, nombreKey : String) -> Int{
    if let intResult = json[nombreKey].int{
        return intResult
    }else{
        return 0
    }
}

//MARK: - Null to Double
func dimeDouble(_ json : JSON, nombreKey : String) -> Double{
    if let doubleResult = json[nombreKey].double{
        return doubleResult
    }else{
        return 0.0
    }
}

//MARK: - Null to Float
func dimeFloat(_ json : JSON, nombreKey : String) -> Float{
    if let floatResult = json[nombreKey].float{
        return floatResult
    }else{
        return 0.0
    }
}















