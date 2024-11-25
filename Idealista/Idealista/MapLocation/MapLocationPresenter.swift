//
//  MapLocationPresenter.swift
//  Idealista
//
//  Created by Conrado Capilla García on 25/11/24.
//  
//

import Foundation


protocol MapLocationPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MapLocationViewProtocol? { get set }
    var interactor: MapLocationInteractorInputProtocol? { get set }
    var wireFrame: MapLocationWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol MapLocationInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}


class MapLocationPresenter  {
    
    // MARK: Properties
    weak var view: MapLocationViewProtocol?
    var interactor: MapLocationInteractorInputProtocol?
    var wireFrame: MapLocationWireFrameProtocol?
    
}

extension MapLocationPresenter: MapLocationPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension MapLocationPresenter: MapLocationInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
