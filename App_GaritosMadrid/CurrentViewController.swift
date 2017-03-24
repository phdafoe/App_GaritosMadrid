//
//  CurrentViewController.swift
//  App_GaritosMadrid
//
//  Created by formador on 24/2/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class CurrentViewController: UIViewController {
    
    //MARK: - Varibale locales
    var garito : GMGaritoModel?
    var locationManager = CLLocationManager()
    var actualizandoLocalizacion = false{
        didSet{
            if actualizandoLocalizacion{
                myBuscarMapa.setImage(#imageLiteral(resourceName: "btn_localizar_off"), for: .normal)
                myActiInd.isHidden = false
                myActiInd.startAnimating()
                myBuscarMapa.isUserInteractionEnabled = false
            }else{
                myBuscarMapa.setImage(#imageLiteral(resourceName: "btn_localizar_on"), for: .normal)
                myActiInd.isHidden = true
                myActiInd.stopAnimating()
                myBuscarMapa.isUserInteractionEnabled = true
                myAddButton.isEnabled = false
            }
        }
    }
    
    
    
    
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var myMenuBTN : UIBarButtonItem!
    @IBOutlet weak var myBuscarMapa: UIButton!
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var myAddButton: UIBarButtonItem!
    @IBOutlet weak var myActiInd: UIActivityIndicatorView!
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil{
            myMenuBTN.target = revealViewController()
            myMenuBTN.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

