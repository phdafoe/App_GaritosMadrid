//
//  GMParserPhotosData.swift
//  App_GaritosMadrid
//
//  Created by formador on 10/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire


class GMParserPhotosData: NSObject {
    
    var jsonDataPhotos : JSON?
    
    func getDatosPhotos() -> Promise<JSON>{
        let customRequest = URLRequest(url: URL(string: CONSTANTES.CONEXIONES_URL.BASE_URL)!)
        return Alamofire.request(customRequest).responseJSON().then { (data) -> JSON in
            self.jsonDataPhotos = JSON(data)
            return self.jsonDataPhotos!
        }
    }
    
    func getParserPhotos() -> [GMPhotosModel]{
        var arrayPhotosModel = [GMPhotosModel]()
        for customItem in jsonDataPhotos!{
            let photoModel = GMPhotosModel(pAlbumId: dimeInt(customItem.1, nombreKey: "albumId"),
                                           pId: dimeInt(customItem.1, nombreKey: "id"),
                                           pTitle: dimeString(customItem.1, nombreKey: "title"),
                                           pUrl: dimeString(customItem.1, nombreKey: "url"),
                                           pThumbnail: dimeString(customItem.1, nombreKey: "thumbnailUrl"))
            arrayPhotosModel.append(photoModel)
        }
        return arrayPhotosModel
    }
    

}








