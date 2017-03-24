//
//  GMGaritoModel.swift
//  App_GaritosMadrid
//
//  Created by formador on 24/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit

class GMGaritoModel: NSObject {
    
    var direccionGarito : String?
    var latitudGarito : Double?
    var longitudGarito : Double?
    var imagenGarito : String?
    
    init(pDireccionGarito : String, pLatitudGarito : Double, pLongitudGarito : Double, pImagenGarito : String) {
        self.direccionGarito = pDireccionGarito
        self.latitudGarito = pLatitudGarito
        self.longitudGarito = pLongitudGarito
        self.imagenGarito = pImagenGarito
        super.init()
    }
    
    
    
    
    
    

}
