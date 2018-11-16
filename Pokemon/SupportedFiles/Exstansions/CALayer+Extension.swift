//
//  CALayer+Extension.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 15/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    func addShadow(color: UIColor = .black,
                   alpha: Float = 0.5,
                   x: CGFloat = 0,
                   y: CGFloat = 2,
                   blur: CGFloat = 4,
                   spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
