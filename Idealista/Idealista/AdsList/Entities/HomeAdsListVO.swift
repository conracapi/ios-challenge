//
//  HomeAdsVO.swift
//  Idealista
//
//  Created by Conrado Capilla García on 24/11/24.
//

import Foundation


struct HomeAdListVO {
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: CGFloat
    let priceInfo: PriceInfoVO
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
    let multimedia: MultimediaVO
    let features: FeaturesVO
}

struct PriceInfoVO {
    let price: PriceVO
}

struct PriceVO {
    let amount: CGFloat
    let currencySuffix: String
}

struct MultimediaVO {
    let images: [ImageVO]
}

struct ImageVO {
    let url: String
    let tag: String
}

struct FeaturesVO {
    let hasAirConditioning: Bool
    let hasBoxRoom: Bool
}
