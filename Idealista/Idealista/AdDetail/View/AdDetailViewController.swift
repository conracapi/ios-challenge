//
//  AdDetailViewController.swift
//  Idealista
//
//  Created by Conrado Capilla García on 26/11/24.
//

import UIKit


// MARK: - Protocols
// Protocol: Presenter -> View
protocol AdDetailViewProtocol: AnyObject {
    var presenter: AdDetailPresenterProtocol? { get set }
}


// MARK: - Class
class AdDetailViewController: UIViewController {
    
    var presenter: AdDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


extension AdDetailViewController: AdDetailViewProtocol {
    
}
