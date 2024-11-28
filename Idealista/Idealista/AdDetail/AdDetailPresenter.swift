//
//  AdDetailPresenter.swift
//  Idealista
//
//  Created by Conrado Capilla García on 25/11/24.
//  
//

import Foundation


// MARK: - Protocols
// Protocol: View -> Presenter
protocol AdDetailPresenterProtocol: AnyObject {
    var view: AdDetailViewProtocol? { get set }
    var interactor: AdDetailInteractorInputProtocol? { get set }
    var wireFrame: AdDetailWireFrameProtocol? { get set }
    func viewDidLoad()
    func fetchDetailAd()
    func showAdLocationOnMap(latitude: CGFloat, longitude: CGFloat)
    func saveFavoriteAd(_ ad: HomeAdDetailViewModel)
}

// Protocol: Interactor -> Presenter
protocol AdDetailInteractorOutputProtocol: AnyObject {
    func fetchedAdDetail(ad: HomeAdDetailBO)
}


// MARK: - Class
final class AdDetailPresenter  {
    
    // Protocol vars
    weak var view: AdDetailViewProtocol?
    var interactor: AdDetailInteractorInputProtocol?
    var wireFrame: AdDetailWireFrameProtocol?
    
}


// Protocol: View -> Presenter
extension AdDetailPresenter: AdDetailPresenterProtocol {
    
    func viewDidLoad() {
        guard let view else { return }
        view.loadUI()
        self.fetchDetailAd()
    }
    
    func fetchDetailAd() {
        guard let interactor else { return }
        interactor.fetchDetailAd()
    }
    
    func showAdLocationOnMap(latitude: CGFloat, longitude: CGFloat) {
        guard let wireFrame, let view else { return }
        wireFrame.showAdLocationOnMap(view: view, latitude: latitude, longitude: longitude)
    }
    
    func saveFavoriteAd(_ ad: HomeAdDetailViewModel) {
        guard let interactor else { return }
        interactor.saveFavoriteAd(ad)
    }
}


// Protocol: Interactor -> Presenter
extension AdDetailPresenter: AdDetailInteractorOutputProtocol {
    
    func fetchedAdDetail(ad: HomeAdDetailBO) {
        guard let view else { return }
        let adDetailVO = HomeAdDetailVO(bo: ad)
        let adDetailViewModel = HomeAdDetailViewModel(vo: adDetailVO)
        view.fetchedDetailAd(ad: adDetailViewModel)
    }
    
}
