//
//  AdsListView.swift
//  Idealista
//
//  Created by Conrado Capilla García on 22/11/24.
//  
//

import UIKit


// MARK: - Protocols
// Protocol: Presenter -> View
protocol AdsListViewProtocol: AnyObject {
    var presenter: AdsListPresenterProtocol? { get set }
}


// MARK: - Class
class AdsListViewController: UIViewController {

    var presenter: AdsListPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AdsListViewController: AdsListViewProtocol {
    
}
