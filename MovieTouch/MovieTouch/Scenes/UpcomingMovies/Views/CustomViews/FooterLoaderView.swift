//
//  FooterLoaderView.swift
//  MovieTouch
//
//  Created by Thiago Santiago on 3/1/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class FooterLoaderView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("FooterLoaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func hide() {
        self.alpha = 0
        self.frame.size.height = 0
        self.loader.stopAnimating()
    }
    
    public func show() {
        self.alpha = 1
        self.frame.size.height = 50
        self.loader.startAnimating()
    }
}
