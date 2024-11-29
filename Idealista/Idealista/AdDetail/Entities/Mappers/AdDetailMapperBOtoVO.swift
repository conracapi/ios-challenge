//
//  MapperBOtoVO.swift
//  Idealista
//
//  Created by Conrado Capilla García on 24/11/24.
//

import Foundation


extension HomeAdDetailVO {
    init(bo: HomeAdDetailBO) {
        self.adid = bo.adid
        self.price = bo.price
        self.priceInfo = PriceVO(bo: bo.priceInfo)
        self.operation = bo.operation
        self.propertyType = bo.propertyType
        self.extendedPropertyType = bo.extendedPropertyType
        self.homeType = bo.homeType
        self.state = bo.state
        self.multimedia = MultimediaVO(bo: bo.multimedia)
        self.propertyComment = bo.propertyComment
        self.ubication = UbicationVO(bo: bo.ubication)
        self.country = bo.country
        self.moreCharacteristics = CharacteristicsVO(bo: bo.moreCharacteristics)
        self.energyCertification = EnergyCertificationVO(bo: bo.energyCertification)
        self.isFavorite = bo.isFavorite
        self.dateSavedAsFavorite = bo.dateSavedAsFavorite
    }
}


extension UbicationVO {
    init(bo: UbicationBO) {
        self.latitude = bo.latitude
        self.longitude = bo.longitude
    }
}


extension CharacteristicsVO {
    init(bo: CharacteristicsBO) {
        self.communityCosts = bo.communityCosts
        self.roomNumber = bo.roomNumber
        self.bathNumber = bo.bathNumber
        self.exterior = bo.exterior
        self.housingFurnitures = bo.housingFurnitures
        self.agencyIsABank = bo.agencyIsABank
        self.energyCertificationType = bo.energyCertificationType
        self.flatLocation = bo.flatLocation
        self.modificationDate = bo.modificationDate
        self.constructedArea = bo.constructedArea
        self.lift = bo.lift
        self.boxroom = bo.boxroom
        self.isDuplex = bo.isDuplex
        self.floor = bo.floor
        self.status = bo.status
    }
}


extension EnergyCertificationVO {
    init(bo: EnergyCertificationBO) {
        self.title = bo.title
        self.energyConsumption = EnergyConsumptionVO(bo: bo.energyConsumption)
        self.emissions = EmissionsVO(bo: bo.emissions)
    }
}


extension EnergyConsumptionVO {
    init(bo: EnergyConsumptionBO) {
        self.type = bo.type
    }
}


extension EmissionsVO {
    init(bo: EmissionsBO) {
        self.type = bo.type
    }
}

