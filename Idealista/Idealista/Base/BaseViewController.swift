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
        // back button
        let backButtonImage = UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysTemplate)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        navController.navigationBar.tintColor = .black
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showErrorAlert(title: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let alertController = UIAlertController(title: title, message: NSLocalizedString("error", comment: ""), preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
