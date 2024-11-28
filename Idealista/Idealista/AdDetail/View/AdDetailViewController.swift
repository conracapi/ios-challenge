//
//  AdDetailViewController.swift
//  Idealista
//
//  Created by Conrado Capilla García on 26/11/24.
//

import UIKit


// MARK: - Protocols
// Protocol: Presenter -> View
protocol AdDetailViewProtocol: AnyObject {
    var presenter: AdDetailPresenterProtocol? { get set }
    func loadUI()
    func fetchedDetailAd(ad: HomeAdDetailViewModel)
}


// MARK: - Class
final class AdDetailViewController: BaseViewController {
    
    // IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var propertyTypeLabel: UILabel!
    @IBOutlet private weak var mapLocationImageView: UIImageView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var firstSeparatorView: UIView!
    @IBOutlet private weak var homeAdDescriptionLabel: UILabel!
    @IBOutlet private weak var secondSeparatorView: UIView!
    @IBOutlet private weak var propietaryDesription: UILabel!
    @IBOutlet private weak var favoriteAdImageView: UIImageView!
    
    // Vars
    var presenter: AdDetailPresenterProtocol?
    private var adViewModel: HomeAdDetailViewModel? = nil
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter else { return }
        presenter.viewDidLoad()
    }
    
    // IBActions private functions
    @IBAction private func seeOnMapLocation(_ sender: Any) {
        guard let ad = self.adViewModel, let presenter else { return }
        presenter.navigateToMapLocation(latitude: ad.location.coordinate.latitude , longitude: ad.location.coordinate.longitude)
    }
    
    @IBAction private func saveFavoriteAd(_ sender: Any) {
        guard let presenter, let ad = self.adViewModel else { return }
        presenter.saveFavoriteAd(ad)
    }
    
    // Private functions
    private func configureCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: PhotoListCollectionViewCell.name, bundle: nil), forCellWithReuseIdentifier: PhotoListCollectionViewCell.name)
    }
    
    private func setPropertyType() {
        guard let ad = self.adViewModel else { return }
        self.propertyTypeLabel.font = .kohinoorBanglaSemibold(withSize: 16.0)
        self.propertyTypeLabel.text = ad.propertyType
        self.propertyTypeLabel.textColor = .adText
    }
    
    private func setPrice() {
        guard let ad = self.adViewModel else { return }
        self.priceLabel.font = .kohinoorBanglaSemibold(withSize: 22.0)
        self.priceLabel.text = ad.price
        self.priceLabel.textColor = .adText
    }
    
    private func setPropietaryDesription() {
        guard let ad = self.adViewModel else { return }
        self.propietaryDesription.font = .kohinoorBanglaSemibold(withSize: 16.0)
        self.propietaryDesription.text = ad.propietaryDescription
        self.propietaryDesription.textColor = .adText
    }
    
    private func setHomeAdDesription() {
        guard let ad = self.adViewModel else { return }
        self.homeAdDescriptionLabel.font = .kohinoorBanglaSemibold(withSize: 16.0)
        self.homeAdDescriptionLabel.text = ad.homeAdDescription
        self.homeAdDescriptionLabel.textColor = .adText
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


// Protocol: Presenter -> View
extension AdDetailViewController: AdDetailViewProtocol {
    
    func loadUI() {
        self.configureCollectionView()
    }
    
    func fetchedDetailAd(ad: HomeAdDetailViewModel) {
        self.adViewModel = ad
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.setPropertyType()
            self.setPrice()
            self.setPropietaryDesription()
            self.setHomeAdDesription()
            self.configureButtons()
            self.view.backgroundColor = .adCellBackground
        }
    }
    
}

extension AdDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoListCollectionViewCell.name, for: indexPath)
        guard let photoCell = cell as? PhotoListCollectionViewCell else { return UICollectionViewCell() }
        photoCell.load(url: self.adViewModel?.multimedia[indexPath.row])
        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 350.0)
    }
    
}
