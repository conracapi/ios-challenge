//
//  HomeAdsListViewModel.swift
//  Idealista
//
//  Created by Conrado Capilla García on 27/11/24.
//

import Foundation
import CoreLocation

struct HomeAdListViewModel {
    let propertyCode: String
    let price: String
    let propertyType: String
    let direction: String
    let location: CLLocation
    let multimedia: [String]
    let additionalInfo: String
    let isFirst: Bool
    let isLast: Bool
    var isFavorite: Bool = false
    var dateSavedAsFavorite: Date? = nil
}
