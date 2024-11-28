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
        self.homeAdDescription = "Esta es la descrición de la casa."
        /*let floor = "-  \(vo.floor)ª \(NSLocalizedString("floor", comment: ""))."
        let size = "-  \(vo.size) m² \(NSLocalizedString("of_area", comment: ""))."
        let rooms = "-  \(vo.rooms) \(NSLocalizedString("rooms", comment: ""))."
        let bathrooms = "-  \(vo.bathrooms) \(NSLocalizedString("bathrooms", comment: ""))."
        let exterior = vo.exterior ? "-  \(NSLocalizedString("with_exterior", comment: ""))." : "-  \(NSLocalizedString("without_exterior", comment: ""))."
        let airConditioning = vo.features.hasAirConditioning ? "-  \(NSLocalizedString("with_air_conditioning", comment: ""))." : "-  \(NSLocalizedString("without_air_conditioning", comment: ""))."
        let boxRoom = vo.features.hasBoxRoom ? "-  \(NSLocalizedString("with_box_room", comment: ""))." : "-  \(NSLocalizedString("without_box_room", comment: ""))."
        self.additionalInfo = floor + "\n" + size + "\n" + rooms + "\n" + bathrooms + "\n" + exterior + "\n" + airConditioning + "\n" + boxRoom*/
    }
}

