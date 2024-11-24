//
//  AdsListInteractor.swift
//  Idealista
//
//  Created by Conrado Capilla García on 22/11/24.
//  
//

import Foundation

// MARK: - Protocols
// Protocol: Presenter -> Interactor
protocol AdsListInteractorInputProtocol: AnyObject {
    var presenter: AdsListInteractorOutputProtocol? { get set }
    var localDatamanager: AdsListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: AdsListRemoteDataManagerInputProtocol? { get set }
}

// Protocol: RemoteDataManager -> Interactor
protocol AdsListRemoteDataManagerOutputProtocol: AnyObject { }


// MARK: - Class
class AdsListInteractor: AdsListInteractorInputProtocol {
    weak var presenter: AdsListInteractorOutputProtocol?
    var localDatamanager: AdsListLocalDataManagerInputProtocol?
    var remoteDatamanager: AdsListRemoteDataManagerInputProtocol?
}

extension AdsListInteractor: AdsListRemoteDataManagerOutputProtocol {
    
}
