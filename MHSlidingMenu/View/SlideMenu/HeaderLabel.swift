//
//  HeaderLabel.swift
//  MHSlidingMenu
//
//  Created by Masoud Heydari on 3/31/19.
//  Copyright © 2019 smartlife. All rights reserved.
//

import UIKit

class HeaderLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 24, dy: 0))
    }
    
    private func setupView() {
        text = "ALL LABELS"
        font = UIFont.boldSystemFont(ofSize: 15)
        textColor = UIColor(red: 121/255, green: 123/255, blue: 126/255, alpha: 1)    }
}
