//
//  AvitoRouter.swift
//  Internship
//
//  Created by Ildar on 12/28/20.
//

import UIKit

class AvitoRouter: AvitoRouterProtocol {
    
    var viewController: AvitoViewController!
    
    init(viewController: AvitoViewController) {
        self.viewController = viewController
    }
    
    func showChooseButtonAlertVC() {
        let alertVC = UIAlertController(title: "Кнопка выбора", message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alertVC, animated: true, completion: nil)
    }
}
