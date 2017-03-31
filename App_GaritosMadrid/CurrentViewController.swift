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
    var calloutSelected : UIImage?
    
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
        
        APIManagerData.shared.cargarDatos()
        
        actualizandoLocalizacion = false
        
        if revealViewController() != nil{
            myMenuBTN.target = revealViewController()
            myMenuBTN.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        myMapView.delegate = self
        myMapView.addAnnotations(APIManagerData.shared.garito)
        
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
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tagGaritoSegue"{
            let navVC = segue.destination as! UINavigationController
            let detalleVC = navVC.topViewController as! DetalleGaritoViewController
            detalleVC.garito = garito
            detalleVC.ciceDelegate = self
        }
        if segue.identifier == "showPinImage"{
            let navVC = segue.destination as! UINavigationController
            let detalleImageVC = navVC.topViewController as! ImagenGaritoViewController
            detalleImageVC.calloutNewImage = calloutSelected
        }
    }
    
    
}//TODO: -- FIN DE LA CLASE

//MARK: - CoreLocation Delegate
extension CurrentViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("*** Error en el CoreLocation ***")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let userLocation = locations.last else {
            return
        }
        
        let latitud = userLocation.coordinate.latitude
        let longitud = userLocation.coordinate.longitude
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            self.actualizandoLocalizacion = false
            if error == nil{
                var direccion = ""
                if let placemarkData = placemarks?.last{
                    direccion = self.stringFromPlacemark(placemarkData)
                }
                self.garito = GMGaritoModel(pDireccionGarito: direccion,
                                            pLatitudGarito: latitud,
                                            pLongitudGarito: longitud,
                                            pImagenGarito: "")
                self.myAddButton.isEnabled = true
            }else{
               self.present(muestraAlert("Oops!",
                                    messageData: "Tienes problemas de conexión",
                                    titleAction: "ok"),
                       animated: true,
                       completion: nil)
            }
        }
    }
    
    func stringFromPlacemark(_ placemarkData : CLPlacemark) -> String{
        
        var lineaUno = ""
        if let stringUno = placemarkData.thoroughfare{
            lineaUno += stringUno + ", "
        }
        if let stringUno = placemarkData.subThoroughfare{
            lineaUno += stringUno
        }
        
        var lineaDos = ""
        if let stringDos = placemarkData.postalCode{
            lineaDos += stringDos + " "
        }
        if let stringDos = placemarkData.locality{
            lineaDos += stringDos
        }
        
        var lineaTres = ""
        if let stringTres = placemarkData.administrativeArea{
            lineaTres += stringTres + " "
        }
        if let stringTres = placemarkData.country{
            lineaTres += stringTres
        }
        
        return lineaUno + "\n" + lineaDos + "\n" + lineaTres
    }
    
    
}//TODO: - Fin de la extension Location Manager

//MARK: - DetalleVC Delegate
extension CurrentViewController : DetalleGaritoViewControllerDelegate{
    func detalleBarEtiquetado(_ detalleVC: DetalleGaritoViewController, barEtiquetado: GMGaritoModel) {
        
        APIManagerData.shared.garito.append(barEtiquetado)
        APIManagerData.shared.salvarDatos()
    }
}//TODO: - Fin de la extension DetalleVC Delegate

//MARK: - Mapkit delegate
extension CurrentViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //1
        if annotation is MKUserLocation{
            return nil
        }
        //2
        var annotationView = myMapView.dequeueReusableAnnotationView(withIdentifier: "garitoPin")
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "garitoPin")
        }else{
            annotationView?.annotation = annotation
        }
        //3 vamos a configurar la anotation
        if let place = annotation as? GMGaritoModel{
            let imageName = place.imagenGarito
            if let imageUrl = APIManagerData.shared.imagenUrl(){
                do{
                    let imageData = try Data(contentsOf: imageUrl.appendingPathComponent(imageName!))
                    self.calloutSelected = UIImage(data: imageData)
                    let myImageNewScale = resizeImage(calloutSelected!, newWidth: 40)
                    let btnNewAction = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                    btnNewAction.setImage(myImageNewScale, for: .normal)
                    annotationView?.leftCalloutAccessoryView = btnNewAction
                    annotationView?.image = #imageLiteral(resourceName: "img_pin")
                    annotationView?.canShowCallout = true
                }catch let error{
                    print("Error en la configuracion de la imagen \(error.localizedDescription)")
                }
            }
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView{
            performSegue(withIdentifier: "showPinImage", sender: view)
        }
    }
    
    //MARK: - Utils
    func resizeImage(_ image : UIImage, newWidth : CGFloat) -> UIImage{
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



























