//
//  UIImageView+Extensions.swift
//  Idealista
//
//  Created by Conrado Capilla García on 25/11/24.
//


import Foundation
import UIKit


extension UIImageView {
    
    func loadImage(from url: String?) {
        guard let url, let imageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, error in
            guard let self, let data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    
}
