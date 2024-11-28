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
    
    var remoteRequestHandler: AdDetailRemoteDataManagerOutputProtocol?
    
    func fetchDetailAd(completion: @escaping (Result<HomeAdDetailDTO, Error>) -> Void) {
        guard let url = URL(string: UrlConstants.HomeAdDetail.adDetailUrl) else {
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
                let adDetail = try JSONDecoder().decode(HomeAdDetailDTO.self, from: data)
                completion(.success(adDetail))
            } catch {
                completion(.failure(NetworkError.errorParsingData))
                return
            }
        }.resume()
        
    }
}
