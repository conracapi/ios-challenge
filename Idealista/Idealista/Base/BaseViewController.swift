//
//  BaseViewController.swift
//  Idealista
//
//  Created by Conrado Capilla García on 27/11/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationController()
    }
    
    private func configureNavigationController() {
        guard let navController = self.navigationController else { return }
        // appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .greenBrand
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        // title image navigation bar
        let titleImageView = UIImageView(image: UIImage(named: "logoNavBar"))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = titleImageView
        titleImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        titleImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}