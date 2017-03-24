//
//  DetalleGaritoViewController.swift
//  App_GaritosMadrid
//
//  Created by formador on 24/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit

class DetalleGaritoViewController: UIViewController {
    
    //MARK: - Variables locales
    var garito : GMGaritoModel?
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageViewPicker: UIImageView!
    @IBOutlet weak var myLatitudLBL: UILabel!
    @IBOutlet weak var myLongitudLBL: UILabel!
    @IBOutlet weak var myDireccionLBL: UILabel!
    @IBOutlet weak var mySalvarDatosBTN: UIBarButtonItem!
    
    //MARK: - IBActions
    
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveInfo(_ sender: Any) {
        
        
    }
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageViewPicker.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(pickerPhoto))
        myImageViewPicker.addGestureRecognizer(tapGR)
        
        configuredLabels()

        // Do any additional setup after loading the view.
    }

    //MARK: - Utils
    func configuredLabels(){
        myLatitudLBL.text = String(format: "%.8f", (garito?.coordinate.latitude)!)
        myLongitudLBL.text = String(format: "%.8f", (garito?.coordinate.longitude)!)
        myDireccionLBL.text = garito?.direccionGarito
    }
    

    

}//TODO: - Fin e la clase

extension DetalleGaritoViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func pickerPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            muestraMenu()
        }else{
            muestraLibreriaFotos()
        }
    }
    
    func muestraMenu(){
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let tomaFotoCamarAction = UIAlertAction(title: "Toma foto", style: .default) { _ in
            self.muestraCamaraDisposito()
        }
        let seleccionaFotoAction = UIAlertAction(title: "Selecciona desde la Librería", style: .default) { _ in
            self.muestraLibreriaFotos()
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(tomaFotoCamarAction)
        alertVC.addAction(seleccionaFotoAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func muestraLibreriaFotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func muestraCamaraDisposito(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageData = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImageViewPicker.image = imageData
            mySalvarDatosBTN.isEnabled = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}














