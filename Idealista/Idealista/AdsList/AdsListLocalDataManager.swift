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
class AdsListLocalDataManager:AdsListLocalDataManagerInputProtocol {
    
    func saveFavoriteAd(_ ad: HomeAdListViewModel) {
        CoreDataManager.shared.saveAd(newAd: ad)
        let ads = CoreDataManager.shared.fetchAds()
        ads.forEach { ad in
            print(ad.titleAd ?? "Sin título")
        }
    }
}
