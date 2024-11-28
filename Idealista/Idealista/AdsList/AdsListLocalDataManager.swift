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
    func saveFavoriteAd(_ ad: HomeAdListViewModel)
}


// MARK: - Class
// protocol: Interactor -> LocalDataManager
final class AdsListLocalDataManager:AdsListLocalDataManagerInputProtocol {
    
    func saveFavoriteAd(_ ad: HomeAdListViewModel) {
        var ads = CoreDataManager.shared.fetchAds()
        CoreDataManager.shared.deleteAllAds()
        ads = CoreDataManager.shared.fetchAds()
        CoreDataManager.shared.saveAdList(newAd: ad)
        ads = CoreDataManager.shared.fetchAds()
        ads.forEach { ad in
            print(ad.propertyCode ?? "Sin código")
        }
    }
}
