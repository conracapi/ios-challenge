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
    func fetchAllAds()
}

// Protocol: RemoteDataManager -> Interactor
protocol AdsListRemoteDataManagerOutputProtocol: AnyObject { }


// MARK: - Class
class AdsListInteractor: AdsListInteractorInputProtocol {
    
    weak var presenter: AdsListInteractorOutputProtocol?
    var localDatamanager: AdsListLocalDataManagerInputProtocol?
    var remoteDatamanager: AdsListRemoteDataManagerInputProtocol?
    
    func fetchAllAds() {
        guard let remoteDatamanager else { return }
        remoteDatamanager.fetchAllAds { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let ads):
                    guard let presenter = self.presenter else { return }
                    let adsListBO = ads.map { (HomeAdListBO(dto: $0)) }
                    presenter.fetchedAds(adsListBO)
                case .failure(let _):
                    break
                    // self.presenter?.presentError(.failedToFetchAds)
            }
        }
    }
}

extension AdsListInteractor: AdsListRemoteDataManagerOutputProtocol {
    
}
