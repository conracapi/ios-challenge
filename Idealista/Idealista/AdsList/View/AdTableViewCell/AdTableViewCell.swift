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
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var propertyTypeLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var extraInfoLabel: UILabel!
    @IBOutlet private weak var mapLocationImageView: UIImageView!
    @IBOutlet private weak var mapLocationView: UIView!
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var favoriteAdView: UIView!
    @IBOutlet weak var favoriteAdImageView: UIImageView!
    
    // MARK: Vars
    static let name: String = String(describing: AdTableViewCell.self)
    weak var delegate: AdTableViewCellProtocol?
    private var homeAd: HomeAdListVO? = nil
    private var photosAd: [ImageVO] = []
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setDelegatesCollectionView()
        self.registerCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.propertyTypeLabel.text = nil
        self.locationLabel.text = nil
        self.priceLabel.text = nil
        self.extraInfoLabel.text = nil
    }
    
    // MARK: Public functions
    func load(homeAd: HomeAdListVO, _ isFirstCell: Bool, _ isLastCell: Bool) {
        self.homeAd = homeAd
        self.setStyles(isFirstCell, isLastCell)
        self.setPhotos(homeAd.multimedia.images)
        self.setPropertyType(with: homeAd.propertyType)
        self.setLocation(with: homeAd.district, and: homeAd.province)
        self.setPrice(with: homeAd.priceInfo.price.amount, and: homeAd.priceInfo.price.currencySuffix)
        self.setExtraInfo()
    }
    
    // MARK: IBActions
    @IBAction private func seeOnMapAction(_ sender: Any) {
        guard let delegate = self.delegate, let homeAd = self.homeAd else { return }
        delegate.navigateToMapLocation(latitude: homeAd.latitude, longitude: homeAd.longitude)
    }
    
    @IBAction func saveFavoriteAd(_ sender: Any) {
        guard let delegate, let homeAd else { return }
        delegate.saveFavoriteAd(homeAd)
    }
    
    // MARK: Private functions
    private func setDelegatesCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func registerCell() {
        self.collectionView.register(UINib(nibName: PhotoListCollectionViewCell.name, bundle: nil), forCellWithReuseIdentifier: PhotoListCollectionViewCell.name)
    }
    
    private func setStyles(_ isFirst: Bool, _ isLast: Bool) {
        self.backgroundColor = .mainBackground
        self.collectionView.backgroundColor = .adCellBackground
        self.collectionView.layer.cornerRadius = 10.0
        self.collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.collectionView.layer.masksToBounds = true
        self.infoView.backgroundColor = .adCellBackground
        self.infoView.layer.cornerRadius = 10.0
        self.infoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.infoView.layer.masksToBounds = true
        self.topConstraint.constant = isFirst ? 0.0 : 10.0
        self.bottomConstraint.constant = isLast ? 0.0 : 10.0
    }
    
    private func setPhotos(_ photos: [ImageVO]) {
        self.photosAd = photos
        self.collectionView.reloadData()
    }
    
    private func setPropertyType(with propertyType: String) {
        self.propertyTypeLabel.font = .kohinoorBanglaSemibold(withSize: 16.0)
        self.propertyTypeLabel.text = propertyType
    }
    
    private func setLocation(with district: String, and province: String) {
        self.locationLabel.font = .kohinoorBanglaRegular(withSize: 14.0)
        self.locationLabel.text = district + ", " + province
    }
    
    private func setPrice(with price: CGFloat, and currency: String) {
        self.priceLabel.font = .kohinoorBanglaSemibold(withSize: 22.0)
        self.priceLabel.text = "\(price) \(currency)"
    }
    
    private func setExtraInfo() {
        self.extraInfoLabel.font = .kohinoorBanglaLight(withSize: 14.0)
        self.extraInfoLabel.text = NSLocalizedString("hello_world", comment: "")
    }
}

extension AdTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoListCollectionViewCell.name, for: indexPath)
        guard let photoCell = cell as? PhotoListCollectionViewCell else { return UICollectionViewCell() }
        photoCell.load(url: homeAd?.multimedia.images[indexPath.row].url)
        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: self.collectionViewHeightConstraint.constant)
    }
    
}
