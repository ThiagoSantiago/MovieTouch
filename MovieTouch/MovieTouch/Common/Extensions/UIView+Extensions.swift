//
//  UIView+Extensions.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 2/28/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

extension UIView {
    
    func setGradient(startColor: CGColor, finalColor: CGColor) {
        let backgroundLayer = CAGradientLayer()
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        let gradientColors: [AnyObject] = [startColor, finalColor]
        backgroundLayer.colors = gradientColors
        backgroundLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        backgroundLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.backgroundColor = UIColor.clear
        self.layer.insertSublayer(backgroundLayer, below: self.subviews.first?.layer)
    }
}
