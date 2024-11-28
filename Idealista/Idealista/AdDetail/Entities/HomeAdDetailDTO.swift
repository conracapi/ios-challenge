//
//  HomeAdDetailDTO.swift
//  Idealista
//
//  Created by Conrado Capilla García on 28/11/24.
//

import Foundation


struct HomeAdDetailDTO: Codable {
    let adid: Int
    let price: CGFloat
    let priceInfo: PriceDTO
    let operation: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let multimedia: MultimediaDTO
    let propertyComment: String
    let ubication: UbicationDTO
    let country: String
    let moreCharacteristics: CharacteristicsDTO
    let energyCertification: EnergyCertificationDTO
}

struct UbicationDTO: Codable {
    let latitude: CGFloat
    let longitude: CGFloat
}

struct CharacteristicsDTO: Codable {
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

struct EnergyCertificationDTO: Codable {
    let title: String
    let energyConsumption: EnergyConsumptionDTO
    let emissions: EmissionsDTO
}

struct EnergyConsumptionDTO: Codable {
    let type: String
}

struct EmissionsDTO: Codable {
    let type: String
}
