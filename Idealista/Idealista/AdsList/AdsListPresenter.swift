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
}

// Protocol: Interactor -> Presenter
protocol AdsListInteractorOutputProtocol: AnyObject {
    func fetchedAds(_ ads: [HomeAdListBO])
    func favoriteAdSaved(with propertyCode: String, date: Date?)
    func favoriteAdRemoved(with propertyCode: String)
}


// MARK: - Class
final class AdsListPresenter  {
    
    // Protocol vars
    weak var view: AdsListViewProtocol?
    var interactor: AdsListInteractorInputProtocol?
    var wireFrame: AdsListWireFrameProtocol?
    
    // Owner vars
    private var adsVO: [HomeAdListVO] = []
    private var adsViewModel: [HomeAdListViewModel] = []
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
        guard let view = self.view, let wireFrame = self.wireFrame else { return }
        wireFrame.showAdLocationOnMap(view: view, latitude: latitude, longitude: longitude)
    }
}


// Protocol: Interactor -> Presenter
extension AdsListPresenter: AdsListInteractorOutputProtocol {
    
    func fetchedAds(_ ads: [HomeAdListBO]) {
        guard let view else { return }
        let adsListVO = ads.map { HomeAdListVO(bo: $0) }
        self.adsVO = adsListVO
        self.adsViewModel = self.adsVO.enumerated().map { index, ad in
            HomeAdListViewModel(vo: ad, isFirst: index == 0, isLast: index == adsVO.count - 1)
        }
        view.fetchedAds(self.adsViewModel)
    }
    
    func favoriteAdSaved(with propertyCode: String, date: Date?) {
        guard let index = adsViewModel.firstIndex(where: { $0.propertyCode == propertyCode }), let view else { return }
        self.adsViewModel[index].isFavorite = true
        view.setFavoriteAd(with: index, of: self.adsViewModel, date: date)
    }
    
    func favoriteAdRemoved(with propertyCode: String) {
        guard let index = adsViewModel.firstIndex(where: { $0.propertyCode == propertyCode }), let view else { return }
        self.adsViewModel[index].isFavorite = false
        view.setFavoriteAd(with: index, of: self.adsViewModel, date: nil)
    }
}
