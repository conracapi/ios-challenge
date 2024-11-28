//
//  UIFont+extensions.swift
//  Idealista
//
//  Created by Conrado Capilla García on 25/11/24.
//

import UIKit

extension UIFont {
    
    static func kohinoorBanglaRegular(withSize size: CGFloat) -> UIFont {
        guard let kohinoorBanglaRegular = UIFont(name: "KohinoorBangla-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return kohinoorBanglaRegular
    }
    
    static func kohinoorBanglaLight(withSize size: CGFloat) -> UIFont {
        guard let kohinoorBanglaLight = UIFont(name: "KohinoorBangla-Light", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return kohinoorBanglaLight
    }
    
    static func kohinoorBanglaSemibold(withSize size: CGFloat) -> UIFont {
        guard let kohinoorBanglaSemibold = UIFont(name: "KohinoorBangla-Semibold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return kohinoorBanglaSemibold
    }
    
    
}
