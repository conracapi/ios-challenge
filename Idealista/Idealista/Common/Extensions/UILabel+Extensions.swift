//
//  UILabel+Extensions.swift
//  Idealista
//
//  Created by Conrado Capilla García on 28/11/24.
//

import UIKit


extension UILabel {
    
    func setStyle(font: UIFont? = nil, textColor: UIColor? = nil, text: String? = nil) {
        if let font = font { self.font = font }
        if let textColor = textColor { self.textColor = textColor }
        if let text = text { self.text = text }
    }
    
}
