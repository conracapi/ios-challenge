//
//  AdDetailLocalDataManager.swift
//  Idealista
//
//  Created by Conrado Capilla García on 25/11/24.
//  
//

import Foundation


// MARK: - Protocols
// Protocol: Interactor -> LocalDataManager
protocol AdDetailLocalDataManagerInputProtocol: AnyObject {
    var interactor: AdDetailLocalDataManagerOutputProtocol? { get set }
    func favoriteAdAction(_ ad: HomeAdDetailViewModel)
    func isFavoriteAd(with propertyCode: String) -> Bool
    func fetchAdDetailDateSaved(by propertyCode: String) -> Date?
}


// MARK: - Class
// Protocol: Interactor -> LocalDataManager
final class AdDetailLocalDataManager: AdDetailLocalDataManagerInputProtocol {
    
    // Protocol vars
    weak var interactor: AdDetailLocalDataManagerOutputProtocol?
    
    // Protocol functions
    func favoriteAdAction(_ ad: HomeAdDetailViewModel) {
        if self.isFavoriteAd(with: String(ad.adId)) {
            CoreDataManager.shared.removeAdDetail(propertyCode: "\(ad.adId)") { [weak self] removed in
                guard let self, let interactor else { return }
                removed ? interactor.favoriteAdRemoved() : ()
            }
        } else {
            CoreDataManager.shared.saveAdDetail(newAd: ad) { [weak self] saved, date in
                guard let self, let interactor else { return }
                saved ? interactor.favoriteAdSaved(date: date) : ()
            }
        }
        
    }
    
    func isFavoriteAd(with propertyCode: String) -> Bool {
        return CoreDataManager.shared.isFavoriteAdDetail(propertyCode: propertyCode)
    }
    
    func fetchAdDetailDateSaved(by propertyCode: String) -> Date? {
        return CoreDataManager.shared.fetchAdDetailDateSaved(by: propertyCode)
    }
    
}
