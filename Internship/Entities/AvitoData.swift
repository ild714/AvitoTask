//
//  AvitoData.swift
//  Internship
//
//  Created by Ildar on 12/31/20.
//

import UIKit

struct AvitoData: Codable {
    let status: String
    let result: Results
}

struct Results: Codable {
    let title: String
    let actionTitle: String
    let selectedActionTitle: String
    let list: [List]
}

struct List: Codable {
    let id: String
    let title: String
    let description: String?
    let icon: Size
    let price: String
    let isSelected: Bool
}

struct Size: Codable {
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case url = "52x52"
    }
}
