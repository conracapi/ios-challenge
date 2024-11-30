//
//  MapperVOtoViewModel.swift
//  Idealista
//
//  Created by Conrado Capilla García on 27/11/24.
//

import Foundation
import CoreLocation


extension HomeAdDetailViewModel {
    
    init(vo: HomeAdDetailVO) {
        self.adId = vo.adid
        self.price = "\(Double(vo.priceInfo.amount).applyThousandsSeparator()) \(vo.priceInfo.currencySuffix)"
        var propertyType: String = ""
        switch vo.extendedPropertyType {
            case .flat: propertyType = NSLocalizedString("flat", comment: "")
            default: break
        }
        var adType: String = ""
        switch vo.operation {
            case .rent: adType = NSLocalizedString("rent", comment: "")
            case .sale: adType = NSLocalizedString("sale", comment: "")
            default: break
        }
        self.propertyType = "\(propertyType.uppercased()) (\(adType))"
        self.location = CLLocation(latitude: vo.ubication.latitude, longitude: vo.ubication.longitude)
        self.multimedia = vo.multimedia.images.map { $0.url }
        self.propietaryDescription = vo.propertyComment
        self.isFavorite = vo.isFavorite
        self.dateSavedAsFavorite = vo.dateSavedAsFavorite
        let size = "-  \(vo.moreCharacteristics.constructedArea) m² \(NSLocalizedString("of_area", comment: ""))."
        let rooms = "-  \(vo.moreCharacteristics.roomNumber) \(NSLocalizedString("rooms", comment: ""))."
        let bathrooms = "-  \(vo.moreCharacteristics.bathNumber) \(NSLocalizedString("bathrooms", comment: ""))."
        let exterior = vo.moreCharacteristics.exterior ? "-  \(NSLocalizedString("with_exterior", comment: ""))." : "-  \(NSLocalizedString("without_exterior", comment: ""))."
        let boxRoom = vo.moreCharacteristics.boxroom ? "-  \(NSLocalizedString("with_box_room", comment: ""))." : "-  \(NSLocalizedString("without_box_room", comment: ""))."
        self.homeAdDescription = size + "\n" + rooms + "\n" + bathrooms + "\n" + exterior + "\n" + boxRoom
    }
}

