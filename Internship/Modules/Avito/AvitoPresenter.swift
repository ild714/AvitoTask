//
//  AvitoPresenter.swift
//  Internship
//
//  Created by Ildar on 12/28/20.
//

import UIKit

class AvitoPresenter: AvitoPresenterProtocol {
    
    weak var view: AvitoViewProtocol?
    var interactor: AvitoInteractorProtocol?
    var router: AvitoRouterProtocol?
    
    required init(view: AvitoViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view?.addCloseButton()
        view?.addTextLabel()
        view?.addChooseButton()
        view?.addCollectionView()
    }
    
    func loadAvitoData() -> AvitoData? {
        return interactor?.avitoData
    }
    
    func showChooseButtonAlert() {
        router?.showChooseButtonAlertVC()
    }
}
