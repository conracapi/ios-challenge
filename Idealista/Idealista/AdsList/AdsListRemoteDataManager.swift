//
//  AdsListRemoteDataManager.swift
//  Idealista
//
//  Created by Conrado Capilla García on 22/11/24.
//  
//

import Foundation


// MARK: - Protocols
// Protocol: Interactor -> RemoteDataManager
protocol AdsListRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: AdsListRemoteDataManagerOutputProtocol? { get set }
}


// MARK: - Class
class AdsListRemoteDataManager:AdsListRemoteDataManagerInputProtocol {
    var remoteRequestHandler: AdsListRemoteDataManagerOutputProtocol?
}
