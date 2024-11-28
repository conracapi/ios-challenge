//
//  AdDetailWireFrame.swift
//  Idealista
//
//  Created by Conrado Capilla García on 25/11/24.
//  
//

import Foundation
import UIKit


// MARK: - Protocols
// Protocol: Presenter -> Wireframe
protocol AdDetailWireFrameProtocol: AnyObject {
    static func createAdDetailModule() -> UIViewController
    func navigateToMapLocation(view: any AdDetailViewProtocol, latitude: CGFloat, longitude: CGFloat)
}


// MARK: - Class
// Protocol: Presenter -> Wireframe
final class AdDetailWireFrame: AdDetailWireFrameProtocol {
    
    class func createAdDetailModule() -> UIViewController {
        let view = AdDetailViewController(nibName: String(describing: AdDetailViewController.self), bundle: nil)
        let presenter: AdDetailPresenterProtocol & AdDetailInteractorOutputProtocol = AdDetailPresenter()
        let interactor: AdDetailInteractorInputProtocol & AdDetailRemoteDataManagerOutputProtocol = AdDetailInteractor()
        let localDataManager: AdDetailLocalDataManagerInputProtocol = AdDetailLocalDataManager()
        let remoteDataManager: AdDetailRemoteDataManagerInputProtocol = AdDetailRemoteDataManager()
        let wireFrame: AdDetailWireFrameProtocol = AdDetailWireFrame()
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        return view
    }
    
    func navigateToMapLocation(view: any AdDetailViewProtocol, latitude: CGFloat, longitude: CGFloat) {
        guard let view = view as? UIViewController,
              let navController = view.navigationController
        else { return }
        let mapLocationModule = MapLocationWireFrame.createMapLocationModule()
        guard let mapViewController = mapLocationModule as? MapLocationViewController else { return }
        mapViewController.latitude = latitude
        mapViewController.longitude = longitude
        navController.pushViewController(mapViewController, animated: true)
    }
    
}
