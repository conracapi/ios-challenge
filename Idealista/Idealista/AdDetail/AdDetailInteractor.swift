//
//  AdDetailInteractor.swift
//  Idealista
//
//  Created by Conrado Capilla García on 25/11/24.
//  
//

import Foundation


// MARK: - Protocols
// Protocol: Presenter -> Interactor
protocol AdDetailInteractorInputProtocol: AnyObject {
    var presenter: AdDetailInteractorOutputProtocol? { get set }
    var localDatamanager: AdDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: AdDetailRemoteDataManagerInputProtocol? { get set }
}

// Protocol: RemoteDataManager -> Interactor
protocol AdDetailRemoteDataManagerOutputProtocol: AnyObject { }


// MARK: - Class
class AdDetailInteractor: AdDetailInteractorInputProtocol {

    weak var presenter: AdDetailInteractorOutputProtocol?
    var localDatamanager: AdDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: AdDetailRemoteDataManagerInputProtocol?

}

extension AdDetailInteractor: AdDetailRemoteDataManagerOutputProtocol { }
