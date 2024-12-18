//
//  PhotoListCollectionViewCell.swift
//  Idealista
//
//  Created by Conrado Capilla García on 24/11/24.
//

import UIKit

final class PhotoListCollectionViewCell: UICollectionViewCell {

    // MARK: IBOutlets
    @IBOutlet private weak var homeImageView: UIImageView!
    
    // MARK: Variables
    static let name: String = String(describing: PhotoListCollectionViewCell.self)
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.homeImageView.image = nil
    }
    
    // MARK: Public functions
    func load(url: String?) {
        self.homeImageView.loadImage(from: url)
    }
    
    // MARK: Private functions
    

}
