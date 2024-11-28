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
    func fetchAllAds(completion: @escaping (Result<[HomeAdListDTO], Error>) -> Void)
}


// MARK: - Class
// Protocol: Interactor -> RemoteDataManager
final class AdsListRemoteDataManager:AdsListRemoteDataManagerInputProtocol {
    
    // Protocol var
    var remoteRequestHandler: AdsListRemoteDataManagerOutputProtocol?
    
    // Private var
    private let httpClient: HTTPClientProtocol = HTTPClient()
    
    // Protocol function
    func fetchAllAds(completion: @escaping (Result<[HomeAdListDTO], Error>) -> Void) {
        guard let url = URL(string: UrlConstants.HomeAdsList.adsListUrl) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        httpClient.performRequest(url: url, responseType: [HomeAdListDTO].self, completion: completion)
    }
}
