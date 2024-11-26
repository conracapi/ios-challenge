//
//  AdDetailRemoteDataManager.swift
//  Idealista
//
//  Created by Conrado Capilla García on 25/11/24.
//  
//

import Foundation


// MARK: - Protocols
// Protocol: Interactor -> RemoteDataManager
protocol AdDetailRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: AdDetailRemoteDataManagerOutputProtocol? { get set }
}


// MARK: - Class
class AdDetailRemoteDataManager:AdDetailRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: AdDetailRemoteDataManagerOutputProtocol?
    
}
