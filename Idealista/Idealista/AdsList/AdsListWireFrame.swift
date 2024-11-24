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
}


// MARK: - Class
class AdsListWireFrame: AdsListWireFrameProtocol {
    
    static func createAdsListModule() -> UIViewController {
        // Initializing VIPER module variables
        let view = AdsListViewController(nibName: "AdsListViewController", bundle: nil)
        let presenter: AdsListPresenterProtocol & AdsListInteractorOutputProtocol = AdsListPresenter()
        let interactor: AdsListInteractorInputProtocol & AdsListRemoteDataManagerOutputProtocol = AdsListInteractor()
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
        remoteDataManager.remoteRequestHandler = interactor
        return view
    }
    
}
