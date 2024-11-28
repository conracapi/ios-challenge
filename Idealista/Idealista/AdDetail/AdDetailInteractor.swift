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
    func saveFavoriteAd(_ ad: HomeAdDetailViewModel)
}

// Protocol: RemoteDataManager -> Interactor
protocol AdDetailRemoteDataManagerOutputProtocol: AnyObject { }


// MARK: - Class
// Protocol: Presenter -> Interactor
final class AdDetailInteractor: AdDetailInteractorInputProtocol {

    // Protocols vars
    weak var presenter: AdDetailInteractorOutputProtocol?
    var localDatamanager: AdDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: AdDetailRemoteDataManagerInputProtocol?

    // Protocol functions
    func fetchDetailAd() {
        guard let remoteDatamanager else { return }
        remoteDatamanager.fetchDetailAd { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let detailAd):
                    guard let presenter = self.presenter else { return }
                    let detailAdBO = HomeAdDetailBO(dto: detailAd)
                    presenter.fetchedAdDetail(ad: detailAdBO)
                case .failure:
                    break
            }
        }
    }
    
    func saveFavoriteAd(_ ad: HomeAdDetailViewModel) {
        guard let localDatamanager else { return }
        localDatamanager.saveFavoriteAd(ad)
    }
}


// Protocol: RemoteDataManager -> Interactor
extension AdDetailInteractor: AdDetailRemoteDataManagerOutputProtocol { }
