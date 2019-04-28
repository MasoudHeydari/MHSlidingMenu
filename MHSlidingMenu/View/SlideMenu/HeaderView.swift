//
//  HeaderView.swift
//  MHSlidingMenu
//
//  Created by Masoud Heydari on 3/31/19.
//  Copyright © 2019 smartlife. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    private let gmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.text = "Gmail"
        label.font = UIFont.systemFont(ofSize: 26)
        label.textColor = UIColor(red: 188/255, green: 67/255, blue: 57/255, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private let dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        addViews()
        addViewConstraints()
    }
    
    private func addViews() {
        addSubview(gmailLabel)
        addSubview(dividerLine)
    }
    
    private func addViewConstraints() {
        NSLayoutConstraint.activate( [
            gmailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            gmailLabel.rightAnchor.constraint(equalTo: rightAnchor),
            gmailLabel.topAnchor.constraint(equalTo: topAnchor),
            gmailLabel.bottomAnchor.constraint(equalTo: dividerLine.topAnchor),
            
            
            dividerLine.leftAnchor.constraint(equalTo: leftAnchor),
            dividerLine.rightAnchor.constraint(equalTo: rightAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 1),
            dividerLine.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            ])
    }
}
