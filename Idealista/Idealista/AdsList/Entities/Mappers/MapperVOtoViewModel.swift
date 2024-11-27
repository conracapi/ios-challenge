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
        self.floor = vo.floor
        self.priceInfo = vo.priceInfo
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
        self.size = vo.size
        self.exterior = vo.exterior
        self.rooms = vo.rooms
        self.bathrooms = vo.bathrooms
        self.address = vo.address
        self.province = vo.province
        self.district = vo.district
        self.location = CLLocation(latitude: vo.latitude, longitude: vo.longitude)
        self.multimedia = vo.multimedia
        self.features = vo.features
        self.isFirst = isFirst
        self.isLast = isLast
    }
}
