//
//  Mapper.swift
//  Idealista
//
//  Created by Conrado Capilla García on 24/11/24.
//

import Foundation

extension HomeAdListBO {
    init(dto: HomeAdListDTO) {
        self.propertyCode = dto.propertyCode
        self.thumbnail = dto.thumbnail
        self.floor = dto.floor
        self.price = dto.price
        self.propertyType = dto.propertyType
        switch dto.operation {
            case "rent": self.operation = .rent
            case "sale": self.operation = .sale
            default: self.operation = .unknown
        }
        self.size = dto.size
        self.exterior = dto.exterior
        self.rooms = dto.rooms
        self.bathrooms = dto.bathrooms
        self.address = dto.address
        self.province = dto.province
        self.municipality = dto.municipality
        self.district = dto.district
        self.country = dto.country
        self.neighborhood = dto.neighborhood
        self.latitude = dto.latitude
        self.longitude = dto.longitude
        self.description = dto.description
        self.priceInfo = PriceInfoBO(dto: dto.priceInfo)
        self.multimedia = MultimediaBO(dto: dto.multimedia)
        self.features = FeaturesBO(dto: dto.features)
    }
}

extension PriceInfoBO {
    init(dto: PriceInfoDTO) {
        self.price = PriceBO(dto: dto.price)
    }
}

extension PriceBO {
    init(dto: PriceDTO) {
        self.amount = dto.amount
        self.currencySuffix = dto.currencySuffix
    }
}

extension MultimediaBO {
    init(dto: MultimediaDTO) {
        self.images = dto.images.map { ImageBO(url: $0.url, tag: $0.tag) }
    }
}

extension FeaturesBO {
    init(dto: FeaturesDTO) {
        self.hasAirConditioning = dto.hasAirConditioning
        self.hasBoxRoom = dto.hasBoxRoom
    }
}
