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
    func saveFavoriteAd(_ ad: HomeAdListViewModel)
}

// Protocol: RemoteDataManager -> Interactor
protocol AdsListRemoteDataManagerOutputProtocol: AnyObject { }


// MARK: - Class
// Protocol: Presenter -> Interactor
final class AdsListInteractor: AdsListInteractorInputProtocol {
    
    // Protocols vars
    weak var presenter: AdsListInteractorOutputProtocol?
    var localDatamanager: AdsListLocalDataManagerInputProtocol?
    var remoteDatamanager: AdsListRemoteDataManagerInputProtocol?
    
    // Protocol functions
    func fetchAllAds() {
        guard let remoteDatamanager else { return }
        remoteDatamanager.fetchAllAds { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let ads):
                    guard let presenter = self.presenter else { return }
                    let adsListBO = ads.map { (HomeAdListBO(dto: $0)) }
                    presenter.fetchedAds(adsListBO)
                case .failure:
                    break
            }
        }
    }
    
    func saveFavoriteAd(_ ad: HomeAdListViewModel) {
        guard let localDatamanager else { return }
        localDatamanager.saveFavoriteAd(ad)
    }
}


// Protocol: RemoteDataManager -> Interactor
extension AdsListInteractor: AdsListRemoteDataManagerOutputProtocol {
    
}
