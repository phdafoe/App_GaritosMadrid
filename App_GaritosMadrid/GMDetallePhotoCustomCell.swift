//
//  GMDetallePhotoCustomCell.swift
//  App_GaritosMadrid
//
//  Created by formador on 10/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit

class GMDetallePhotoCustomCell: UITableViewCell {
    
    @IBOutlet weak var myPhotoIV: UIImageView!
    @IBOutlet weak var myTituloLBL: UILabel!
    @IBOutlet weak var myThumbnailIV: UIImageView!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
