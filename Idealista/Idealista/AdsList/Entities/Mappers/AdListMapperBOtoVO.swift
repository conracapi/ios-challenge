//
//  MapperBOtoVO.swift
//  Idealista
//
//  Created by Conrado Capilla García on 24/11/24.
//

import Foundation

extension HomeAdListVO {
    init(bo: HomeAdListBO) {
        self.propertyCode = bo.propertyCode
        self.thumbnail = bo.thumbnail
        self.floor = bo.floor
        self.price = bo.price
        self.propertyType = bo.propertyType
        self.operation = bo.operation
        self.size = bo.size
        self.exterior = bo.exterior
        self.rooms = bo.rooms
        self.bathrooms = bo.bathrooms
        self.address = bo.address
        self.province = bo.province
        self.municipality = bo.municipality
        self.district = bo.district
        self.country = bo.country
        self.neighborhood = bo.neighborhood
        self.latitude = bo.latitude
        self.longitude = bo.longitude
        self.description = bo.description
        self.priceInfo = PriceInfoVO(bo: bo.priceInfo)
        self.multimedia = MultimediaVO(bo: bo.multimedia)
        self.features = FeaturesVO(bo: bo.features)
        self.isFavorite = bo.isFavorite
    }
}

extension PriceInfoVO {
    init(bo: PriceInfoBO) {
        self.price = PriceVO(bo: bo.price)
    }
}

extension PriceVO {
    init(bo: PriceBO) {
        self.amount = bo.amount
        self.currencySuffix = bo.currencySuffix
    }
}

extension MultimediaVO {
    init(bo: MultimediaBO) {
        self.images = bo.images.map { ImageVO(url: $0.url, tag: $0.tag) }
    }
}

extension FeaturesVO {
    init(bo: FeaturesBO) {
        self.hasAirConditioning = bo.hasAirConditioning
        self.hasBoxRoom = bo.hasBoxRoom
    }
}
