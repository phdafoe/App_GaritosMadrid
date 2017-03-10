//
//  GMDetallePosterCustomCell.swift
//  App_GaritosMadrid
//
//  Created by formador on 10/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit

class GMDetallePosterCustomCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenPoster: UIImageView!
    @IBOutlet weak var myTituloPoster: UILabel!
    @IBOutlet weak var myYearPoster: UILabel!
    @IBOutlet weak var myIdPoster: UILabel!
    @IBOutlet weak var myTipoPoster: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
