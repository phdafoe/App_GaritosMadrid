//
//  GMGaritoModel.swift
//  App_GaritosMadrid
//
//  Created by formador on 24/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import MapKit

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
}//TODO: - Fin de la clase modelo


extension GMGaritoModel : MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: latitudGarito!, longitude: longitudGarito!)
        }
    }
    
    var title: String? {
        get{
            return "Garito de Madrid"
        }
    }
    
    var subtitle: String? {
        get{
            return direccionGarito?.replacingOccurrences(of: "\n", with: "")
        }
    }
    
}







