//
//  MapperVOtoViewModel.swift
//  Idealista
//
//  Created by Conrado Capilla García on 27/11/24.
//

import Foundation
import CoreLocation


extension HomeAdListViewModel {
    
    init(vo: HomeAdListVO, isFirst: Bool, isLast: Bool) {
        self.propertyCode = vo.propertyCode
        self.price = "\(Double(vo.priceInfo.price.amount).applyThousandsSeparator()) \(vo.priceInfo.price.currencySuffix)"
        var propertyType: String = ""
        switch vo.propertyType {
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
        self.direction = vo.district + ", " + vo.province
        self.location = CLLocation(latitude: vo.latitude, longitude: vo.longitude)
        self.multimedia = vo.multimedia.images.map { $0.url }
        let floor = "-  \(vo.floor)ª \(NSLocalizedString("floor", comment: ""))."
        let size = "-  \(vo.size) m² \(NSLocalizedString("of_area", comment: ""))."
        let rooms = "-  \(vo.rooms) \(NSLocalizedString("rooms", comment: ""))."
        let bathrooms = "-  \(vo.bathrooms) \(NSLocalizedString("bathrooms", comment: ""))."
        let exterior = vo.exterior ? "-  \(NSLocalizedString("with_exterior", comment: ""))." : "-  \(NSLocalizedString("without_exterior", comment: ""))."
        let airConditioning = vo.features.hasAirConditioning ? "-  \(NSLocalizedString("with_air_conditioning", comment: ""))." : "-  \(NSLocalizedString("without_air_conditioning", comment: ""))."
        let boxRoom = vo.features.hasBoxRoom ? "-  \(NSLocalizedString("with_box_room", comment: ""))." : "-  \(NSLocalizedString("without_box_room", comment: ""))."
        self.additionalInfo = floor + "\n" + size + "\n" + rooms + "\n" + bathrooms + "\n" + exterior + "\n" + airConditioning + "\n" + boxRoom
        self.isFirst = isFirst
        self.isLast = isLast
        self.isFavorite = vo.isFavorite
    }
}
