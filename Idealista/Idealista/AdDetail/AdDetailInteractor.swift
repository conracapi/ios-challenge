//
//  AdDetailInteractor.swift
//  Idealista
//
//  Created by Conrado Capilla García on 25/11/24.
//  
//

import Foundation


// MARK: - Protocols
// Protocol: Presenter -> Interactor
protocol AdDetailInteractorInputProtocol: AnyObject {
    var presenter: AdDetailInteractorOutputProtocol? { get set }
    var localDatamanager: AdDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: AdDetailRemoteDataManagerInputProtocol? { get set }
    func fetchDetailAd()
    func favoriteAdAction(_ ad: HomeAdDetailViewModel)
}

// Protocol: RemoteDataManager -> Interactor
protocol AdDetailRemoteDataManagerOutputProtocol: AnyObject { }

// Protocol: LocalDataManager -> Interactor
protocol AdDetailLocalDataManagerOutputProtocol: AnyObject {
    func favoriteAdSaved(date: Date?)
    func favoriteAdRemoved()
}


// MARK: - Class
// Protocol: Presenter -> Interactor
final class AdDetailInteractor: AdDetailInteractorInputProtocol {

    // Protocols vars
    weak var presenter: AdDetailInteractorOutputProtocol?
    var localDatamanager: AdDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: AdDetailRemoteDataManagerInputProtocol?

    // Protocol functions
    func fetchDetailAd() {
        guard let remoteDatamanager, let localDatamanager else { return }
        remoteDatamanager.fetchDetailAd { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let detailAd):
                    guard let presenter = self.presenter else { return }
                    var detailAdBO = HomeAdDetailBO(dto: detailAd)
                    detailAdBO.isFavorite = self.localDatamanager?.isFavoriteAd(with: String(detailAdBO.adid)) ?? false
                    detailAdBO.dateSavedAsFavorite = localDatamanager.fetchAdDetailDateSaved(by: String(detailAd.adid))
                    presenter.fetchedAdDetail(ad: detailAdBO)
                case .failure:
                    break
            }
        }
    }
    
    func favoriteAdAction(_ ad: HomeAdDetailViewModel) {
        guard let localDatamanager else { return }
        localDatamanager.favoriteAdAction(ad)
    }
}


// Protocol: RemoteDataManager -> Interactor
extension AdDetailInteractor: AdDetailRemoteDataManagerOutputProtocol { }


// Protocol: LocalDataManager -> Interactor
extension AdDetailInteractor: AdDetailLocalDataManagerOutputProtocol {
    
    func favoriteAdSaved(date: Date?) {
        guard let presenter else { return }
        presenter.favoriteAdSaved(date: date)
    }
    
    func favoriteAdRemoved() {
        guard let presenter else { return }
        presenter.favoriteAdRemoved()
    }
}
