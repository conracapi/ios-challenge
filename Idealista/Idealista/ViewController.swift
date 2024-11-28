//
//  ViewController.swift
//  Idealista
//
//  Created by Conrado Capilla García on 22/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .greenBrand
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self else { return }
            if let navController = self.navigationController {
                let adsListView = AdsListWireFrame.createAdsListModule()
                navController.setViewControllers([adsListView], animated: true)
                
            }
        }
    }
    
}

