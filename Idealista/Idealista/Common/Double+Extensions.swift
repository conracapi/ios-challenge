//
//  CGFloat+Extensions.swift
//  Idealista
//
//  Created by Conrado Capilla García on 28/11/24.
//

import Foundation

extension Double {
    
    func applyThousandsSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.groupingSize = 3
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        if let formattedNumber = formatter.string(from: NSNumber(value: self)) {
            return formattedNumber
        } else { return "" }
    }
    
}
