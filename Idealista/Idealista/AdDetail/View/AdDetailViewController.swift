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
    func showAlertError()
}


// MARK: - Class
final class AdDetailViewController: BaseViewController {
    
    // IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var favoriteAdSavedView: UIView!
    @IBOutlet private weak var favoriteAdSavedLabel: UILabel!
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
    private var adDetailViewModel: HomeAdDetailViewModel? = nil
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter else { return }
        presenter.viewDidLoad()
    }
    
    // IBActions private functions
    @IBAction private func seeOnMapLocation(_ sender: Any) {
        guard let ad = self.adDetailViewModel, let presenter else { return }
        presenter.showAdLocationOnMap(latitude: ad.location.coordinate.latitude , longitude: ad.location.coordinate.longitude)
    }
    
    @IBAction private func favoriteAdAction(_ sender: Any) {
        guard let presenter, let ad = self.adDetailViewModel else { return }
        presenter.favoriteAdAction(ad)
    }
    
    // Private functions
    private func configureCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: PhotoListCollectionViewCell.name, bundle: nil), forCellWithReuseIdentifier: PhotoListCollectionViewCell.name)
    }
    
    private func setupLabelsContent() {
        guard let adDetail = self.adDetailViewModel else { return }
        self.propertyTypeLabel.setStyle(font: .kohinoorBanglaSemibold(withSize: 16.0), textColor: .adText, text: adDetail.propertyType)
        self.priceLabel.setStyle(font: .kohinoorBanglaSemibold(withSize: 24.0), textColor: .adText, text: adDetail.price)
        self.propietaryDesription.setStyle(font: .kohinoorBanglaRegular(withSize: 15.0), textColor: .adText, text: adDetail.propietaryDescription)
        self.homeAdDescriptionLabel.setStyle(font: .kohinoorBanglaSemibold(withSize: 15.0), textColor: .adText, text: adDetail.homeAdDescription)
    }
    
    private func configureFavoriteAdSavedView() {
        self.favoriteAdSavedView.layer.cornerRadius = 6
        self.favoriteAdSavedView.backgroundColor = .mainBackground.withAlphaComponent(0.5)
    }
    
    private func configureButtons() {
        self.mapLocationImageView.image = UIImage(systemName: "location.circle")?.withRenderingMode(.alwaysTemplate)
        self.mapLocationImageView.tintColor = .adText
        if self.adDetailViewModel?.isFavorite ?? false {
            self.favoriteAdImageView.image = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
            self.favoriteAdImageView.tintColor = .red
            self.favoriteAdSavedView.isHidden = false
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let formattedDate = formatter.string(from: adDetailViewModel?.dateSavedAsFavorite ?? Date())
            self.favoriteAdSavedLabel.setStyle(font: .kohinoorBanglaSemibold(withSize: 15.0), textColor: .adText, text: "\(NSLocalizedString("saved", comment: "")) \(formattedDate)")
        } else {
            self.favoriteAdImageView.image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
            self.favoriteAdImageView.tintColor = .adText
            self.favoriteAdSavedView.isHidden = true
            self.favoriteAdSavedLabel.setStyle(font: .kohinoorBanglaSemibold(withSize: 15.0), textColor: .adText, text: "")
        }
    }
    
    private func setViewStyles() {
        self.firstSeparatorView.backgroundColor = .separatorViewColor
        self.secondSeparatorView.backgroundColor = .separatorViewColor
        self.view.backgroundColor = .adCellBackground
    }
}


// Protocol: Presenter -> View
extension AdDetailViewController: AdDetailViewProtocol {
    
    func loadUI() {
        self.configureCollectionView()
        self.configureFavoriteAdSavedView()
    }
    
    func fetchedDetailAd(ad: HomeAdDetailViewModel) {
        self.adDetailViewModel = ad
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.collectionView.reloadData()
            self.setupLabelsContent()
            self.configureButtons()
            self.setViewStyles()
        }
    }
    
    func showAlertError() {
        self.showErrorAlert(title: "Error")
    }
    
}


// Protocols: set collectionView
extension AdDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.adDetailViewModel?.multimedia.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoListCollectionViewCell.name, for: indexPath)
        guard let photoCell = cell as? PhotoListCollectionViewCell else { return UICollectionViewCell() }
        photoCell.load(url: self.adDetailViewModel?.multimedia[indexPath.row])
        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 350.0)
    }
    
}
