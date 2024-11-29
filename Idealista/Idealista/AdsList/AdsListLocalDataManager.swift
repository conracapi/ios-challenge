//
//  AdsListLocalDataManager.swift
//  Idealista
//
//  Created by Conrado Capilla García on 22/11/24.
//  
//

import Foundation


// MARK: - Protocols
// protocol: Interactor -> LocalDataManager
protocol AdsListLocalDataManagerInputProtocol: AnyObject {
    var interactor: AdsListLocalDataManagerOutputProtocol? { get set }
    func favoriteAdAction(_ ad: HomeAdListViewModel)
    func isFavoriteAd(with propertyCode: String) -> Bool
}


// MARK: - Class
// protocol: Interactor -> LocalDataManager
final class AdsListLocalDataManager: AdsListLocalDataManagerInputProtocol {
    
    // Protocol vars
    weak var interactor: AdsListLocalDataManagerOutputProtocol?
    
    // Protocol functions
    func favoriteAdAction(_ ad: HomeAdListViewModel) {
        CoreDataManager.shared.fetchAds()
        if self.isFavoriteAd(with: ad.propertyCode) {
            CoreDataManager.shared.removeAdList(propertyCode: ad.propertyCode) { [weak self] removed in
                guard let self, let interactor else { return }
                removed ? interactor.favoriteAdRemoved(with: ad.propertyCode) : ()
            }
        } else {
            CoreDataManager.shared.saveAdList(newAd: ad, saved: { [weak self] saved in
                guard let self, let interactor else { return }
                saved ? interactor.favoriteAdSaved(with: ad.propertyCode) : ()
            })
        }
        
    }
    
    func isFavoriteAd(with propertyCode: String) -> Bool {
        return CoreDataManager.shared.isFavoriteAdList(propertyCode: propertyCode)
    }
}
