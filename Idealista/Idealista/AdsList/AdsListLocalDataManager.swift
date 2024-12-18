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
    func fetchAdListDateSaved(by propertyCode: String) -> Date?
}


// MARK: - Class
// protocol: Interactor -> LocalDataManager
final class AdsListLocalDataManager: AdsListLocalDataManagerInputProtocol {
    
    // Protocol vars
    weak var interactor: AdsListLocalDataManagerOutputProtocol?
    
    // Protocol functions
    func favoriteAdAction(_ ad: HomeAdListViewModel) {
        if self.isFavoriteAd(with: ad.propertyCode) {
            CoreDataManager.shared.removeAdList(propertyCode: ad.propertyCode) { [weak self] removed in
                guard let self, let interactor else { return }
                removed ? interactor.favoriteAdRemoved(with: ad.propertyCode) : interactor.showAlertError()
            }
        } else {
            CoreDataManager.shared.saveAdList(newAd: ad, saved: { [weak self] saved, date in
                guard let self, let interactor else { return }
                saved ? interactor.favoriteAdSaved(with: ad.propertyCode, date: date) : interactor.showAlertError()
            })
        }
        
    }
    
    func isFavoriteAd(with propertyCode: String) -> Bool {
        return CoreDataManager.shared.isFavoriteAdList(propertyCode: propertyCode)
    }
    
    func fetchAdListDateSaved(by propertyCode: String) -> Date? {
        return CoreDataManager.shared.fetchAdListDateSaved(by: propertyCode)
    }
}
