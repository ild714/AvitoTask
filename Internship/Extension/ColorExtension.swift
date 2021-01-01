//
//  ColorExtension.swift
//  Internship
//
//  Created by Ildar on 12/30/20.
//

import UIKit

extension UIColor {
    convenience init(redS: Int, greenS: Int, blueS: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(redS) / 255.0,
            green: CGFloat(greenS) / 255.0,
            blue: CGFloat(blueS) / 255.0,
            alpha: alpha
        )
    }
}
