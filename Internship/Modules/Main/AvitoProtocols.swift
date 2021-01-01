//
//  AvitoProtocols.swift
//  Internship
//
//  Created by Ildar on 12/28/20.
//

import UIKit

protocol AvitoViewProtocol: class {
    func addCloseButton()
    func addTextLabel()
    func addCollectionView()
    func addChooseButton()
}

protocol AvitoPresenterProtocol: class {
    var router: AvitoRouterProtocol? { set get }
    func configureView()
    func loadAvitoData() -> AvitoData?
    func showChooseButtonAlert()
}

protocol AvitoInteractorProtocol: class {
    var avitoData: AvitoData? { get }
}

protocol AvitoRouterProtocol: class {
    func showChooseButtonAlertVC()
}

protocol AvitoConfiguratorProtocol: class {
    func configure(with viewController: AvitoViewController)
}

