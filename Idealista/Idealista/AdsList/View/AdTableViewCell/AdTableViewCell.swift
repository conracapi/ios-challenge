//
//  AdTableViewCell.swift
//  Idealista
//
//  Created by Conrado Capilla García on 24/11/24.
//

import UIKit

final class AdTableViewCell: UITableViewCell {
    
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
    @IBOutlet private weak var favoriteAdView: UIView!
    @IBOutlet private weak var favoriteAdImageView: UIImageView!
    
    // MARK: Vars
    static let name: String = String(describing: AdTableViewCell.self)
    weak var delegate: AdTableViewCellProtocol?
    private var homeAd: HomeAdListViewModel? = nil
    private var photosUrl: [String] = []
    
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
    func load(homeAd: HomeAdListViewModel) {
        self.homeAd = homeAd
        self.setStyles()
        self.setPhotos()
        self.setupLabelsContent()
        self.configureButtons()
    }
    
    // MARK: IBActions private functions
    @IBAction private func seeOnMapAction(_ sender: Any) {
        guard let delegate = self.delegate, let homeAd = self.homeAd else { return }
        delegate.showAdLocationOnMap(latitude: homeAd.location.coordinate.latitude, longitude: homeAd.location.coordinate.longitude)
    }
    
    @IBAction private func saveFavoriteAd(_ sender: Any) {
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
    
    private func setStyles() {
        self.backgroundColor = .mainBackground
        self.collectionView.backgroundColor = .adCellBackground
        self.collectionView.layer.cornerRadius = 10.0
        self.collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.collectionView.layer.masksToBounds = true
        self.infoView.backgroundColor = .adCellBackground
        self.infoView.layer.cornerRadius = 10.0
        self.infoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.infoView.layer.masksToBounds = true
        guard let isFirst = homeAd?.isFirst, let isLast = homeAd?.isLast else { return }
        self.topConstraint.constant = isFirst ? 0.0 : 10.0
        self.bottomConstraint.constant = isLast ? 0.0 : 10.0
    }
    
    private func setPhotos() {
        guard let photos = homeAd?.multimedia else { return }
        self.photosUrl = photos
        self.collectionView.reloadData()
    }
    
    private func setupLabelsContent() {
        guard let homeAd else { return }
        self.propertyTypeLabel.setStyle(font: .kohinoorBanglaSemibold(withSize: 16.0), textColor: .adText, text: homeAd.propertyType)
        self.locationLabel.setStyle(font: .kohinoorBanglaRegular(withSize: 15.0), textColor: .adText, text: homeAd.direction)
        self.priceLabel.setStyle(font: .kohinoorBanglaSemibold(withSize: 22.0), textColor: .adText, text: homeAd.price)
        self.extraInfoLabel.setStyle(font: .kohinoorBanglaLight(withSize: 15.0), textColor: .adText, text: homeAd.additionalInfo)
    }
    
    private func configureButtons() {
        self.mapLocationImageView.image = UIImage(systemName: "location.circle")?.withRenderingMode(.alwaysTemplate)
        self.mapLocationImageView.tintColor = .adText
        // heart -> corazón vacío
        // heart.fill -> corazón lleno
        self.favoriteAdImageView.image = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
        self.favoriteAdImageView.tintColor = .red
    }
}

extension AdTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoListCollectionViewCell.name, for: indexPath)
        guard let photoCell = cell as? PhotoListCollectionViewCell else { return UICollectionViewCell() }
        photoCell.load(url: self.photosUrl[indexPath.row])
        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: self.collectionViewHeightConstraint.constant)
    }
    
}
