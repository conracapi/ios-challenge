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
    func saveFavoriteAd(_ ad: HomeAdListVO)
}

// Protocol: Interactor -> Presenter
protocol AdsListInteractorOutputProtocol: AnyObject {
    func fetchedAds(_ ads: [HomeAdListBO])
}


// MARK: - Class
class AdsListPresenter  {
    weak var view: AdsListViewProtocol?
    var interactor: AdsListInteractorInputProtocol?
    var wireFrame: AdsListWireFrameProtocol?
}

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
    
    func saveFavoriteAd(_ ad: HomeAdListVO) {
        guard let interactor else { return }
        interactor.saveFavoriteAd(ad)
    }
    
}

extension AdsListPresenter: AdsListInteractorOutputProtocol {
    
    func fetchedAds(_ ads: [HomeAdListBO]) {
        guard let view else { return }
        let adsListVO = ads.map { HomeAdListVO(bo: $0) }
        view.fetchedAds(adsListVO)
    }
    
}
