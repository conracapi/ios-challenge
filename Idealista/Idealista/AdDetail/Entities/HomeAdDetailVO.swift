//
//  HomeAdDetailVO.swift
//  Idealista
//
//  Created by Conrado Capilla García on 28/11/24.
//

import Foundation

struct HomeAdDetailVO {
    let adid: Int
    let price: CGFloat
    let priceInfo: PriceVO
    let operation: AdOperationType
    let propertyType: String
    let extendedPropertyType: AdPropertyType
    let homeType: String
    let state: String
    let multimedia: MultimediaVO
    let propertyComment: String
    let ubication: UbicationVO
    let country: String
    let moreCharacteristics: CharacteristicsVO
    let energyCertification: EnergyCertificationVO
    var isFavorite: Bool = false
}

struct UbicationVO {
    let latitude: CGFloat
    let longitude: CGFloat
}

struct CharacteristicsVO {
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

struct EnergyCertificationVO {
    let title: String
    let energyConsumption: EnergyConsumptionVO
    let emissions: EmissionsVO
}

struct EnergyConsumptionVO {
    let type: String
}

struct EmissionsVO {
    let type: String
}
