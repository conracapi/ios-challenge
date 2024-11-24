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
}

// Protocol: Interactor -> Presenter
protocol AdsListInteractorOutputProtocol: AnyObject { }


// MARK: - Class
class AdsListPresenter  {
    weak var view: AdsListViewProtocol?
    var interactor: AdsListInteractorInputProtocol?
    var wireFrame: AdsListWireFrameProtocol?
}

extension AdsListPresenter: AdsListPresenterProtocol {
    func viewDidLoad() { }
}

extension AdsListPresenter: AdsListInteractorOutputProtocol {
    
}
