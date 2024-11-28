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
    func saveFavoriteAd(_ ad: HomeAdDetailViewModel)
}


// MARK: - Class
// Protocol: Interactor -> LocalDataManager
final class AdDetailLocalDataManager:AdDetailLocalDataManagerInputProtocol {
    
    func saveFavoriteAd(_ ad: HomeAdDetailViewModel) {
        var ads = CoreDataManager.shared.fetchAdsDetail()
        CoreDataManager.shared.deleteAllAdsDetail()
        ads = CoreDataManager.shared.fetchAdsDetail()
        CoreDataManager.shared.saveAdDetail(newAd: ad)
        ads = CoreDataManager.shared.fetchAdsDetail()
        ads.forEach { ad in
            print(ad.adId)
        }
    }
    
}
