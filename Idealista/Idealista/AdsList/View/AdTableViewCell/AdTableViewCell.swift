//
//  AdTableViewCell.swift
//  Idealista
//
//  Created by Conrado Capilla García on 24/11/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var propertyTypeLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var extraInfoLabel: UILabel!
    
    // MARK: Vars
    private var photosAd: [ImageVO] = []
    static let name: String = String(describing: AdTableViewCell.self)
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setDelegatesCollectionView()
        self.registerCell()
    }
    
    override func prepareForReuse() {
        self.prepareForReuse()
        self.propertyTypeLabel.text = nil
        self.locationLabel.text = nil
        self.priceLabel.text = nil
        self.extraInfoLabel.text = nil
    }
    
    // MARK: Public functions
    func load(homeAd: HomeAdListVO) {
        self.setPhotos(homeAd.multimedia.images)
        self.setPropertyType(with: homeAd.propertyType)
        self.setLocation(with: homeAd.district, and: homeAd.province)
        self.setPrice(with: homeAd.priceInfo.price.amount, and: homeAd.priceInfo.price.currencySuffix)
        self.setExtraInfo()
    }
    
    // MARK: Private functions
    private func setDelegatesCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func registerCell() {
        self.collectionView.register(UINib(nibName: PhotoListCollectionViewCell.name, bundle: nil), forCellWithReuseIdentifier: PhotoListCollectionViewCell.name)
    }
    
    private func setPhotos(_ photos: [ImageVO]) {
        self.photosAd = photos
        self.collectionView.reloadData()
    }
    
    private func setPropertyType(with propertyType: String) {
        self.propertyTypeLabel.text = propertyType
    }
    
    private func setLocation(with district: String, and province: String) {
        self.locationLabel.text = district + ", " + province
    }
    
    private func setPrice(with price: CGFloat, and currency: String) {
        self.priceLabel.text = "\(price) \(currency)"
    }
    
    private func setExtraInfo() {
        self.extraInfoLabel.text = "Información extra de la casa"
    }
}

extension AdTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoListCollectionViewCell.name, for: indexPath)
        guard let photoCell = cell as? PhotoListCollectionViewCell else { return UICollectionViewCell() }
        return photoCell
    }
    
}
