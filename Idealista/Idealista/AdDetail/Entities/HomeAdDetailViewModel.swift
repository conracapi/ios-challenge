//
//  HomeAdDetailViewModel.swift
//  Idealista
//
//  Created by Conrado Capilla García on 28/11/24.
//

import Foundation
import CoreLocation

struct HomeAdDetailViewModel {
    let adId: Int
    let propertyType: String
    let price: String
    let location: CLLocation
    let homeAdDescription: String
    let propietaryDescription: String
    let multimedia: [String]
    var isFavorite: Bool = false
    var dateSavedAsFavorite: Date? = nil
}
