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
    func fetchDetailAd(completion: @escaping (Result<HomeAdDetailDTO, Error>) -> Void)
}


// MARK: - Class
// Protocol: Interactor -> RemoteDataManager
final class AdDetailRemoteDataManager:AdDetailRemoteDataManagerInputProtocol {
    
    // Protocol var
    var remoteRequestHandler: AdDetailRemoteDataManagerOutputProtocol?
    
    // Private var
    private let httpClient: HTTPClientProtocol = HTTPClient()
    
    // Protocol function
    func fetchDetailAd(completion: @escaping (Result<HomeAdDetailDTO, Error>) -> Void) {
        guard let url = URL(string: UrlConstants.HomeAdDetail.adDetailUrl) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        self.httpClient.performRequest(url: url, responseType: HomeAdDetailDTO.self, completion: completion)
    }
}
