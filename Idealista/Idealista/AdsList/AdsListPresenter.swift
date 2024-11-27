//
//  AdsListPresenter.swift
//  Idealista
//
//  Created by Conrado Capilla García on 22/11/24.
//  
//

import Foundation


// MARK: - Protocols
// Protocol: View -> Presenter
protocol AdsListPresenterProtocol: AnyObject {
    var view: AdsListViewProtocol? { get set }
    var interactor: AdsListInteractorInputProtocol? { get set }
    var wireFrame: AdsListWireFrameProtocol? { get set }
    func viewDidLoad()
    func fetchAllAds()
    func saveFavoriteAd(_ ad: HomeAdListViewModel)
    func navigateToMapLocation(latitude: CGFloat, longitude: CGFloat)
}

// Protocol: Interactor -> Presenter
protocol AdsListInteractorOutputProtocol: AnyObject {
    func fetchedAds(_ ads: [HomeAdListBO])
}


// MARK: - Class
class AdsListPresenter  {
    
    // Protocol vars
    weak var view: AdsListViewProtocol?
    var interactor: AdsListInteractorInputProtocol?
    var wireFrame: AdsListWireFrameProtocol?
    
    // Owner vars
    private var ads: [HomeAdListVO] = []
    
    // Private functions
    private func getAdViewModels() -> [HomeAdListViewModel] {
        return self.ads.enumerated().map { index, ad in
            HomeAdListViewModel(
                vo: ad,
                isFirst: index == 0,
                isLast: index == ads.count - 1
            )
        }
    }
}


// Protocol: View -> Presenter
extension AdsListPresenter: AdsListPresenterProtocol {
    
    func viewDidLoad() {
        guard let view = self.view else { return }
        view.loadUI()
        self.fetchAllAds()
    }
    
    func fetchAllAds() {
        guard let interactor = self.interactor else { return }
        interactor.fetchAllAds()
    }
    
    func saveFavoriteAd(_ ad: HomeAdListViewModel) {
        guard let interactor else { return }
        interactor.saveFavoriteAd(ad)
    }
    
    func navigateToMapLocation(latitude: CGFloat, longitude: CGFloat) {
        guard let view = self.view, let wireFrame = self.wireFrame else { return }
        wireFrame.navigateToMapLocation(view: view, latitude: latitude, longitude: longitude)
    }
    
}


// Protocol: Interactor -> Presenter
extension AdsListPresenter: AdsListInteractorOutputProtocol {
    
    func fetchedAds(_ ads: [HomeAdListBO]) {
        guard let view else { return }
        let adsListVO = ads.map { HomeAdListVO(bo: $0) }
        self.ads = adsListVO
        let viewModels = self.getAdViewModels()
        view.fetchedAds(viewModels)
    }
    
}
