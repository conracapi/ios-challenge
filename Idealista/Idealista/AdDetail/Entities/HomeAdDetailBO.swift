//
//  HomeAdDetailBO.swift
//  Idealista
//
//  Created by Conrado Capilla García on 28/11/24.
//

import Foundation

struct HomeAdDetailBO {
    let adid: Int
    let price: CGFloat
    let priceInfo: PriceBO
    let operation: AdOperationType
    let propertyType: String
    let extendedPropertyType: AdPropertyType
    let homeType: String
    let state: String
    let multimedia: MultimediaBO
    let propertyComment: String
    let ubication: UbicationBO
    let country: String
    let moreCharacteristics: CharacteristicsBO
    let energyCertification: EnergyCertificationBO
    var isFavorite: Bool = false
}

struct UbicationBO {
    let latitude: CGFloat
    let longitude: CGFloat
}

struct CharacteristicsBO {
    let communityCosts: CGFloat
    let roomNumber: Int
    let bathNumber: Int
    let exterior: Bool
    let housingFurnitures: String
    let agencyIsABank: Bool
    let energyCertificationType: String
    let flatLocation: String
    let modificationDate: Int
    let constructedArea: Int
    let lift: Bool
    let boxroom: Bool
    let isDuplex: Bool
    let floor: String
    let status: String
}

struct EnergyCertificationBO {
    let title: String
    let energyConsumption: EnergyConsumptionBO
    let emissions: EmissionsBO
}

struct EnergyConsumptionBO {
    let type: String
}

struct EmissionsBO {
    let type: String
}
