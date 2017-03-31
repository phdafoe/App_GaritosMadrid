//
//  ImagenGaritoViewController.swift
//  App_GaritosMadrid
//
//  Created by formador on 31/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit

class ImagenGaritoViewController: UIViewController {
    
    //MARK: - Variables locales
    var calloutNewImage : UIImage?
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myIMageView: UIImageView!
    
    
    //MARK: - IBactions
    @IBAction func hideVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let detalleImagen = calloutNewImage{
            myIMageView.image = detalleImagen
        }
        
        /*if calloutNewImage != nil{
            myIMageView.image = calloutNewImage!
        }*/
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
