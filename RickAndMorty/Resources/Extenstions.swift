//
//  Extenstions.swift
//  RickAndMorty
//
//  Created by Hashim Saffarini on 08/12/2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
