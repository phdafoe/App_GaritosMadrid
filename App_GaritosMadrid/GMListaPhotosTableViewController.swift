//
//  GMListaPhotosTableViewController.swift
//  App_GaritosMadrid
//
//  Created by formador on 10/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import PKHUD


class GMListaPhotosTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var arrayPhotos : [GMPhotosModel] = []
    
    //MARK: - IBoutlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var extraButton: UIBarButtonItem!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - LLamada
        llamadaPhotos()
        

        //MARK: - MENU Lateral
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            extraButton.target = revealViewController()
            extraButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //MARK: - registro de la XIB
        tableView.register(UINib(nibName: "GMDetallePhotoCustomCell", bundle: nil), forCellReuseIdentifier: "DetallePhotoCustomCell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayPhotos.count
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetallePhotoCustomCell", for: indexPath) as! GMDetallePhotoCustomCell

        // Configure the cell...
        let model = arrayPhotos[indexPath.row]
        
        cell.myTituloLBL.text = model.title
        cell.myPhotoIV.kf.setImage(with: URL(string: model.url!),
                                   placeholder: #imageLiteral(resourceName: "placehoder"),
                                   options: nil,
                                   progressBlock: nil,
                                   completionHandler: nil)
        
        cell.myThumbnailIV.kf.setImage(with: URL(string: model.thumbnailUrl!),
                                       placeholder: #imageLiteral(resourceName: "placehoder"),
                                       options: nil,
                                       progressBlock: nil,
                                       completionHandler: nil)

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 415
    }
    

    //MARK: - Utils
    func llamadaPhotos(){
        let customPhotoGet = GMParserPhotosData()
        HUD.show(.progress)
        firstly{
            return when(resolved: customPhotoGet.getDatosPhotos())
        }.then{_ in
            self.arrayPhotos = customPhotoGet.getParserPhotos()
        }.then{_ in
            self.tableView.reloadData()
        }.then{_ in
            HUD.hide(afterDelay: 0)
        }.catch { error in
            self.present(muestraAlert("Estimado usuario", messageData: "\(error.localizedDescription)", titleAction: "OK"), animated: true, completion: nil)
        }
    }

}










