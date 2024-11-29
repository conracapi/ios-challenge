//
//  AdsListWireFrame.swift
//  Idealista
//
//  Created by Conrado Capilla García on 22/11/24.
//  
//

import UIKit


// MARK: - Protocols
// Protocol: Presenter -> Wireframe
protocol AdsListWireFrameProtocol: AnyObject {
    static func createAdsListModule() -> UIViewController
    func showAdLocationOnMap(view: AdsListViewProtocol, latitude: CGFloat, longitude: CGFloat)
}


// MARK: - Class
final class AdsListWireFrame: AdsListWireFrameProtocol {
    
    static func createAdsListModule() -> UIViewController {
        // Initializing VIPER module variables
        let view = AdsListViewController(nibName: String(describing: AdsListViewController.self), bundle: nil)
        let presenter: AdsListPresenterProtocol & AdsListInteractorOutputProtocol = AdsListPresenter()
        let interactor: AdsListInteractorInputProtocol & AdsListRemoteDataManagerOutputProtocol & AdsListLocalDataManagerOutputProtocol = AdsListInteractor()
        let localDataManager: AdsListLocalDataManagerInputProtocol = AdsListLocalDataManager()
        let remoteDataManager: AdsListRemoteDataManagerInputProtocol = AdsListRemoteDataManager()
        let wireFrame: AdsListWireFrameProtocol = AdsListWireFrame()
        // Assigning VIPER module variables
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        localDataManager.interactor = interactor
        remoteDataManager.remoteRequestHandler = interactor
        return view
    }
    
    func showAdLocationOnMap(view: any AdsListViewProtocol, latitude: CGFloat, longitude: CGFloat) {
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
