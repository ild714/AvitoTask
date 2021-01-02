//
//  AvitoConfigurator.swift
//  Internship
//
//  Created by Ildar on 12/28/20.
//

import UIKit

class AvitoConfigurator: AvitoConfiguratorProtocol {
    func configure(with viewController: AvitoViewController) {
        let presenter = AvitoPresenter(view: viewController)
        let interactor = AvitoInteractor(presenter: presenter)
        let router = AvitoRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}

