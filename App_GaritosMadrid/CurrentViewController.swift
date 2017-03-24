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
    
    
    //MARK: - IBActions
    @IBAction func obtenerLocalizacion(_ sender: Any) {
        iniciaLocationManager()
    }
    
    
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actualizandoLocalizacion = false
        
        
        if revealViewController() != nil{
            myMenuBTN.target = revealViewController()
            myMenuBTN.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: - Utils
    func iniciaLocationManager(){
        let estadoAutorizado = CLLocationManager.authorizationStatus()
        switch estadoAutorizado {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            present(muestraAlert("Localización desactivada",
                                 messageData: "Por favor, activa la localización para esta aplicación en los ajustes del dispositivo",
                                 titleAction: "OK"),
                    animated: true,
                    completion: nil)
        default:
            if CLLocationManager.locationServicesEnabled(){
                actualizandoLocalizacion = true
                myAddButton.isEnabled = false
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.delegate = self
                locationManager.requestLocation()
                
                let region = MKCoordinateRegionMakeWithDistance(myMapView.userLocation.coordinate, 100, 100)
                myMapView.setRegion(myMapView.regionThatFits(region), animated: true)
            }
        }
    }
    
}//TODO: -- FIN DE LA CLASE

//MARK: - CoreLocation Delegate
extension CurrentViewController : CLLocationManagerDelegate{
    
}





















