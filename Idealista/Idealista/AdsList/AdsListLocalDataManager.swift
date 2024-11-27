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
    func saveFavoriteAd(_ ad: HomeAdListVO)
}


// MARK: - Class
class AdsListLocalDataManager:AdsListLocalDataManagerInputProtocol {
    
    func saveFavoriteAd(_ ad: HomeAdListVO) {
        print("¡¡Hola!!")
        print("¡¡\(ad.district)!!")
    }
    
}
