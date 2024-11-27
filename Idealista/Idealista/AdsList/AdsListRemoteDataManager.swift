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
class AdsListRemoteDataManager:AdsListRemoteDataManagerInputProtocol {
    
    // Protocol var
    var remoteRequestHandler: AdsListRemoteDataManagerOutputProtocol?
    
    // Protocol functions
    func fetchAllAds(completion: @escaping (Result<[HomeAdListDTO], Error>) -> Void) {
        guard let url = URL(string: UrlConstants.HomeAdsList.adsListUrl) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(NetworkError.errorFetchingData))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            do {
                let adsList = try JSONDecoder().decode([HomeAdListDTO].self, from: data)
                completion(.success(adsList))
            } catch {
                completion(.failure(NetworkError.errorParsingData))
                return
            }
        }.resume()
    }
}
