//
//  MapLocationWireFrame.swift
//  Idealista
//
//  Created by Conrado Capilla García on 25/11/24.
//  
//

import Foundation
import UIKit


protocol MapLocationWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createMapLocationModule() -> UIViewController
}

class MapLocationWireFrame: MapLocationWireFrameProtocol {

    class func createMapLocationModule() -> UIViewController {
        // Initializing VIPER module variables
        let view = MapLocationViewController(nibName: String(describing: MapLocationViewController.self), bundle: nil)
        let presenter: MapLocationPresenterProtocol & MapLocationInteractorOutputProtocol = MapLocationPresenter()
        let interactor: MapLocationInteractorInputProtocol = MapLocationInteractor()
        let wireFrame: MapLocationWireFrameProtocol = MapLocationWireFrame()
        // Assigning VIPER module variables
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
    
}
