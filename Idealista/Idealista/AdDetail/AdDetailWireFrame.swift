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
}


// MARK: - Class
class AdDetailWireFrame: AdDetailWireFrameProtocol {
    
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
    
}
