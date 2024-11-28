//
//  HomeAdsBO.swift
//  Idealista
//
//  Created by Conrado Capilla García on 24/11/24.
//

import Foundation


struct HomeAdListBO {
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: CGFloat
    let priceInfo: PriceInfoBO
    let propertyType: AdPropertyType
    let operation: AdOperationType
    let size: CGFloat
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String
    let latitude: CGFloat
    let longitude: CGFloat
    let description: String
    let multimedia: MultimediaBO
    let features: FeaturesBO
}

struct PriceInfoBO {
    let price: PriceBO
}

struct PriceBO {
    let amount: CGFloat
    let currencySuffix: String
}

struct MultimediaBO {
    let images: [ImageBO]
}

struct ImageBO {
    let url: String
    let tag: String
}

struct FeaturesBO {
    let hasAirConditioning: Bool
    let hasBoxRoom: Bool
}

enum AdOperationType: String {
    case sale
    case rent
    case unknown
}

enum AdPropertyType: String {
    case flat
    case unknown
}
