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
    let floor: String
    let priceInfo: PriceInfoVO
    let propertyType: String
    let size: CGFloat
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let district: String
    let location: CLLocation
    let multimedia: MultimediaVO
    let features: FeaturesVO
    let isFirst: Bool
    let isLast: Bool

}
