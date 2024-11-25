//
//  MapLocationInteractor.swift
//  Idealista
//
//  Created by Conrado Capilla García on 25/11/24.
//  
//

import Foundation


protocol MapLocationInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: MapLocationInteractorOutputProtocol? { get set }
}


class MapLocationInteractor: MapLocationInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: MapLocationInteractorOutputProtocol?

}
