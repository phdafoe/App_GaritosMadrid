//
//  GMParserPosterData.swift
//  App_GaritosMadrid
//
//  Created by formador on 10/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire
import SwiftyJSON

class GMParserPosterData: NSObject {
    
    var jsonDataPosterImdb : JSON?
    
    func getDataImdb(_ idObjeto : String, idNumero : String) -> Promise<JSON>{
        let customRequest = URLRequest(url: URL(string: CONSTANTES.CONEXIONES_URL.BASE_URL_OMDB + idObjeto + "&page=" + idNumero)!)
        return Alamofire.request(customRequest).responseJSON().then { (data) -> JSON in
            self.jsonDataPosterImdb = JSON(data)
            return self.jsonDataPosterImdb!
        }
    }
    
    func getParseImdb() -> [GMComicsPostersModel]{
        var arrayDatosImdb = [GMComicsPostersModel]()
        for item in jsonDataPosterImdb!["Search"]{
            let dataModel = GMComicsPostersModel(pTitle: dimeString(item.1, nombreKey: "Title"),
                                                 pYear: dimeString(item.1, nombreKey: "Year"),
                                                 pImdbId: dimeString(item.1, nombreKey: "imdbID"),
                                                 pType: dimeString(item.1, nombreKey: "Type"),
                                                 pPoster: dimeString(item.1, nombreKey: "Poster"))
            arrayDatosImdb.append(dataModel)
        }
        return arrayDatosImdb
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
