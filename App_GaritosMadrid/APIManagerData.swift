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
        if let urlData = dataBaseUrl(){
            
        }
    }
    
    func cargarDatos(){
        
    }
    
    
    func dataBaseUrl() -> URL?{
        
    }
    
    func imagenUrl() -> URL?{
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}//TODO: - Fin de nuestra clase
