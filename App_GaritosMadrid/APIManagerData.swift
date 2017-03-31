//
//  APIManagerData.swift
//  App_GaritosMadrid
//
//  Created by formador on 24/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit

class APIManagerData: NSObject {
    
    static let shared = APIManagerData()
    
    var garito : [GMGaritoModel] = []
    
    
    //MARK: - SALVAR DATOS
    func salvarDatos(){
        if let urlData = dateBaseUrl(){
            NSKeyedArchiver.archiveRootObject(garito, toFile: urlData.path)
        }else{
            print("Error guardando datos")
        }
    }
    
    func cargarDatos(){
        if let urlData = dateBaseUrl(), let datosSalvados = NSKeyedUnarchiver.unarchiveObject(withFile: urlData.path) as? [GMGaritoModel]{
            garito = datosSalvados
        }else{
            print("Error cargando Datos")
        }
    }
    
    
    func dateBaseUrl() -> URL?{
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            let customUrl = URL(fileURLWithPath: documentDirectory)
            return customUrl.appendingPathComponent("garitos.data")
        }else{
            return nil
        }
    }
    
    func imagenUrl() -> URL?{
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            let customUrl = URL(fileURLWithPath: documentDirectory)
            return customUrl
        }else{
            return nil
        } 
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}//TODO: - Fin de nuestra clase
