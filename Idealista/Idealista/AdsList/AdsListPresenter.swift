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
    func viewWillAppear()
    func fetchAllAds()
    func favoriteAdAction(_ ad: HomeAdListViewModel)
    func showAdLocationOnMap(latitude: CGFloat, longitude: CGFloat)
    func goToDetailAd()
}

// Protocol: Interactor -> Presenter
protocol AdsListInteractorOutputProtocol: AnyObject {
    func fetchedAds(_ ads: [HomeAdListBO])
    func favoriteAdSaved(with propertyCode: String, date: Date?)
    func favoriteAdRemoved(with propertyCode: String)
    func showAlertError()
}


// MARK: - Class
final class AdsListPresenter  {
    
    // Protocol vars
    weak var view: AdsListViewProtocol?
    var interactor: AdsListInteractorInputProtocol?
    var wireFrame: AdsListWireFrameProtocol?
    
    // Private vars
    private var adsViewModel: [HomeAdListViewModel] = []
    
    // Private functions
    private func updateFavoriteAd(with propertyCode: String, isFavorite: Bool, date: Date?) {
        guard let index = adsViewModel.firstIndex(where: { $0.propertyCode == propertyCode }), let view else { return }
        adsViewModel[index].isFavorite = isFavorite
        view.setFavoriteAd(with: index, of: adsViewModel, date: isFavorite ? date : nil)
    }
}


// Protocol: View -> Presenter
extension AdsListPresenter: AdsListPresenterProtocol {
    
    func viewDidLoad() {
        guard let view = self.view else { return }
        view.loadUI()
        self.fetchAllAds()
    }
    
    func viewWillAppear() {
        guard let view else { return }
        view.hideBackButtonNavBar()
    }
    
    func fetchAllAds() {
        guard let interactor = self.interactor else { return }
        interactor.fetchAllAds()
    }
    
    func favoriteAdAction(_ ad: HomeAdListViewModel) {
        guard let interactor else { return }
        interactor.favoriteAdAction(ad)
    }
    
    func showAdLocationOnMap(latitude: CGFloat, longitude: CGFloat) {
        guard let view, let wireFrame else { return }
        wireFrame.showAdLocationOnMap(view: view, latitude: latitude, longitude: longitude)
    }
    
    func goToDetailAd() {
        guard let view, let wireFrame else { return }
        wireFrame.goToDetail(view: view)
    }
}


// Protocol: Interactor -> Presenter
extension AdsListPresenter: AdsListInteractorOutputProtocol {
    
    func fetchedAds(_ ads: [HomeAdListBO]) {
        guard let view else { return }
        let adsListVO = ads.map { HomeAdListVO(bo: $0) }
        self.adsViewModel = adsListVO.enumerated().map { index, ad in
            HomeAdListViewModel(vo: ad, isFirst: index == 0, isLast: index == adsListVO.count - 1)
        }
        view.fetchedAds(self.adsViewModel)
    }
    
    func favoriteAdSaved(with propertyCode: String, date: Date?) {
        self.updateFavoriteAd(with: propertyCode, isFavorite: true, date: date)
    }

    func favoriteAdRemoved(with propertyCode: String) {
        self.updateFavoriteAd(with: propertyCode, isFavorite: false, date: nil)
    }
    
    func showAlertError() {
        guard let view else { return }
        view.showAlertError()
    }

}
