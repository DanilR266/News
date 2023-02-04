//
//  UILabel Extension.swift
//  NewsList
//
//  Created by Данила on 03.02.2023.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init()
        self.text = text
        self.font = font
    }
}
