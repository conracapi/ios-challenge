//
//  Mapper.swift
//  Idealista
//
//  Created by Conrado Capilla García on 24/11/24.
//

import Foundation

import Foundation


extension HomeAdDetailBO {
    init(dto: HomeAdDetailDTO) {
        self.adid = dto.adid
        self.price = dto.price
        self.priceInfo = PriceBO(dto: dto.priceInfo)
        switch dto.operation {
            case AdOperationType.rent.rawValue: self.operation = .rent
            case AdOperationType.sale.rawValue: self.operation = .sale
            default: self.operation = .unknown
        }
        self.propertyType = dto.propertyType
        switch dto.extendedPropertyType {
            case AdPropertyType.flat.rawValue: self.extendedPropertyType = .flat
            default: self.extendedPropertyType = .unknown
        }
        self.homeType = dto.homeType
        self.state = dto.state
        self.multimedia = MultimediaBO(dto: dto.multimedia)
        self.propertyComment = dto.propertyComment
        self.ubication = UbicationBO(dto: dto.ubication)
        self.country = dto.country
        self.moreCharacteristics = CharacteristicsBO(dto: dto.moreCharacteristics)
        self.energyCertification = EnergyCertificationBO(dto: dto.energyCertification)
    }
}


extension UbicationBO {
    init(dto: UbicationDTO) {
        self.latitude = dto.latitude
        self.longitude = dto.longitude
    }
}


extension CharacteristicsBO {
    init(dto: CharacteristicsDTO) {
        self.communityCosts = dto.communityCosts
        self.roomNumber = dto.roomNumber
        self.bathNumber = dto.bathNumber
        self.exterior = dto.exterior
        self.housingFurnitures = dto.housingFurnitures
        self.agencyIsABank = dto.agencyIsABank
        self.energyCertificationType = dto.energyCertificationType
        self.flatLocation = dto.flatLocation
        self.modificationDate = dto.modificationDate
        self.constructedArea = dto.constructedArea
        self.lift = dto.lift
        self.boxroom = dto.boxroom
        self.isDuplex = dto.isDuplex
        self.floor = dto.floor
        self.status = dto.status
    }
}


extension EnergyCertificationBO {
    init(dto: EnergyCertificationDTO) {
        self.title = dto.title
        self.energyConsumption = EnergyConsumptionBO(dto: dto.energyConsumption)
        self.emissions = EmissionsBO(dto: dto.emissions)
    }
}


extension EnergyConsumptionBO {
    init(dto: EnergyConsumptionDTO) {
        self.type = dto.type
    }
}


extension EmissionsBO {
    init(dto: EmissionsDTO) {
        self.type = dto.type
    }
}

