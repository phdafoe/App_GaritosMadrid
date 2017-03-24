//
//  GMListaPostersTableViewController.swift
//  App_GaritosMadrid
//
//  Created by formador on 10/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import PKHUD

class GMListaPostersTableViewController: UITableViewController {
    
    //MARK: - Variable locales
    var arrayPosters : [GMComicsPostersModel] = []
    var idNumero : Int?
    var idObjeto : String?
    let arrayPersonajes = ["Superman", "Batman", "Hulk", "Flash"]
    var customRefresControl = UIRefreshControl()
    
    
    //MARK: - IBoutlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var extraButton: UIBarButtonItem!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customRefresControl.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        customRefresControl.addTarget(self, action: #selector(self.recargardo), for: .valueChanged)
        tableView.addSubview(customRefresControl)
        
        idNumero = randomNumero()
        let randomString = Int(arc4random_uniform(UInt32(arrayPersonajes.count)))
        idObjeto = arrayPersonajes[randomString]
        
        //MARK: - LLamada
        llamadaPoster()
        
        
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
        tableView.register(UINib(nibName: "GMDetallePosterCustomCell", bundle: nil), forCellReuseIdentifier: "DetallePosterCustomCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recargardo(){
        idNumero = randomNumero()
        llamadaPoster()
        customRefresControl.endRefreshing()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayPosters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetallePosterCustomCell", for: indexPath) as! GMDetallePosterCustomCell

        // Configure the cell...
        let model = arrayPosters[indexPath.row]
        
        cell.myTituloPoster.text = model.title
        cell.myYearPoster.text = model.year
        cell.myIdPoster.text = model.imdbId
        cell.myTipoPoster.text = model.type
        
        cell.myImagenPoster.kf.setImage(with: URL(string: model.poster!),
                                        placeholder: #imageLiteral(resourceName: "placehoder"),
                                        options: nil,
                                        progressBlock: nil,
                                        completionHandler: nil)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 415
    }
    

    func llamadaPoster(){
        let posterData = GMParserPosterData()
       
        
        HUD.show(.progress)
        firstly{
            return when(resolved: posterData.getDataImdb(idObjeto!, idNumero: "\(idNumero!)"))
            }.then{_ in
                self.arrayPosters = posterData.getParseImdb()
            }.then{_ in
                self.tableView.reloadData()
            }.then{_ in
                HUD.hide(afterDelay: 0)
            }.catch { (error) in
                self.present(muestraAlert("Estimado usuario", messageData: "\(error.localizedDescription)", titleAction: "OK"), animated: true, completion: nil)
            }
    }
    
    func randomNumero() -> Int{
        let customRandom = Int(arc4random_uniform(12))
        return customRandom
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
