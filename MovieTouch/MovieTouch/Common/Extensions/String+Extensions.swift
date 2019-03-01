//
//  String+Extensions.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

extension String {
    
    func formatString() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.init(identifier: "pt-BR")
        
        if let date = dateFormatterGet.date(from: self) {
            return dateFormatter.string(from: date)
        } else {
            return self
        }
    }
}
