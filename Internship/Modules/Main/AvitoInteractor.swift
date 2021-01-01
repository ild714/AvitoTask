//
//  AvitoInteractor.swift
//  Internship
//
//  Created by Ildar on 12/28/20.
//

import UIKit

class AvitoInteractor: AvitoInteractorProtocol {
    
    weak var presenter: AvitoPresenterProtocol!
    
    let serverService: ServerService = ServerService()
    
    required init(presenter: AvitoPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - MainInteractorProtocol methods
    
    var avitoData: AvitoData? {
        get {
            var avitoData : AvitoData?
            serverService.loadAvitoJSON { (result) in
                switch result {
                case .success(let result):
                    avitoData = result
                case .failure(let error):
                    print(error)
                }
            }
            return avitoData
        }
    }
}
