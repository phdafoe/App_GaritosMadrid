//
//  GMPhotosModel.swift
//  App_GaritosMadrid
//
//  Created by formador on 10/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit

class GMPhotosModel: NSObject {
    
    var albumId : Int?
    var id : Int?
    var title : String?
    var url : String?
    var thumbnailUrl : String?
    
    init(pAlbumId : Int, pId : Int, pTitle : String, pUrl : String, pThumbnail : String) {
        self.albumId = pAlbumId
        self.id = pId
        self.title = pTitle
        self.url = pUrl
        self.thumbnailUrl = pThumbnail
        super.init()
    }
    
    
    
    
    
    
    
    
    
    
    
    

}
