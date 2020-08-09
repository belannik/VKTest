//
//  UILabel + Extensions.swift
//  VKTest
//
//  Created by Anton on 03.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit

extension UILabel {
    func addCharacterSpacing(kernValue: Double = 1) {
        if let labelText = text,
            labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttributes([NSAttributedString.Key.kern : kernValue],
                                           range: NSRange(location: 0, length: attributedString.length - 1))
        }
    }
}
