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
    func favoriteAdAction(_ ad: HomeAdListViewModel)
}

// Protocol: RemoteDataManager -> Interactor
protocol AdsListRemoteDataManagerOutputProtocol: AnyObject { }

// Protocol: LocalDataManager -> Interactor
protocol AdsListLocalDataManagerOutputProtocol: AnyObject {
    func favoriteAdSaved(with propertyCode: String, date: Date?)
    func favoriteAdRemoved(with propertyCode: String)
}


// MARK: - Class
// Protocol: Presenter -> Interactor
final class AdsListInteractor: AdsListInteractorInputProtocol {
    
    // Protocols vars
    weak var presenter: AdsListInteractorOutputProtocol?
    var localDatamanager: AdsListLocalDataManagerInputProtocol?
    var remoteDatamanager: AdsListRemoteDataManagerInputProtocol?
    
    // Protocol functions
    func fetchAllAds() {
        guard let remoteDatamanager, let localDatamanager else { return }
        remoteDatamanager.fetchAllAds { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let ads):
                    guard let presenter = self.presenter else { return }
                    var adsListBO = ads.map { HomeAdListBO(dto: $0) }
                    adsListBO = adsListBO.map { ad in
                        var mutableAd = ad
                        mutableAd.isFavorite = localDatamanager.isFavoriteAd(with: ad.propertyCode)
                        mutableAd.dateSavedAsFavorite = localDatamanager.fetchAdListDateSaved(by: ad.propertyCode)
                        return mutableAd
                    }
                    presenter.fetchedAds(adsListBO)
                case .failure:
                    break
            }
        }
    }
    
    func favoriteAdAction(_ ad: HomeAdListViewModel) {
        guard let localDatamanager else { return }
        localDatamanager.favoriteAdAction(ad)
    }
}


// Protocol: RemoteDataManager -> Interactor
extension AdsListInteractor: AdsListRemoteDataManagerOutputProtocol {
    
}


// Protocol: LocalDataManager -> Interactor
extension AdsListInteractor: AdsListLocalDataManagerOutputProtocol {
    
    func favoriteAdSaved(with propertyCode: String, date: Date?) {
        guard let presenter else { return }
        presenter.favoriteAdSaved(with: propertyCode, date: date)
    }
    
    func favoriteAdRemoved(with propertyCode: String) {
        guard let presenter else { return }
        presenter.favoriteAdRemoved(with: propertyCode)
    }
}
