//
//  GMGaritoModel.swift
//  App_GaritosMadrid
//
//  Created by formador on 24/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import MapKit

class GMGaritoModel: NSObject, NSCoding {
    
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
    
    required convenience init?(coder aDecoder: NSCoder) {
        let direccion = aDecoder.decodeObject(forKey: "direccionKey") as! String
        let latitud = aDecoder.decodeObject(forKey: "latitudKey") as! Double
        let longitud = aDecoder.decodeObject(forKey: "longitudKey") as! Double
        let imagen = aDecoder.decodeObject(forKey: "imagenKey") as! String
        
        self.init(pDireccionGarito : direccion, pLatitudGarito : latitud, pLongitudGarito : longitud, pImagenGarito : imagen)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(direccionGarito, forKey: "direccionKey")
        aCoder.encode(latitudGarito, forKey: "latitudKey")
        aCoder.encode(longitudGarito, forKey: "longitudKey")
        aCoder.encode(imagenGarito, forKey: "imagenKey")
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







