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
}

// Protocol: Interactor -> Presenter
protocol AdDetailInteractorOutputProtocol: AnyObject { }


// MARK: - Class
class AdDetailPresenter  {
    
    weak var view: AdDetailViewProtocol?
    var interactor: AdDetailInteractorInputProtocol?
    var wireFrame: AdDetailWireFrameProtocol?
    
}

extension AdDetailPresenter: AdDetailPresenterProtocol {
    
    func viewDidLoad() { }
    
}

extension AdDetailPresenter: AdDetailInteractorOutputProtocol { }
