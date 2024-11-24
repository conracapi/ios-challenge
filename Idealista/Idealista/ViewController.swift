//
//  ViewController.swift
//  Idealista
//
//  Created by Conrado Capilla García on 22/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var navigateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func navigateToAdsList(_ sender: Any) {
        print("Ahora toca navegar a la pantalla del listado de anuncios")
        if let navController = self.navigationController {
            let adsListView = AdsListWireFrame.createAdsListModule()
            navController.setViewControllers([adsListView], animated: true)
        }
    }
    

}

