//
//  MenuItemCell.swift
//  MHSlidingMenu
//
//  Created by Masoud Heydari on 3/31/19.
//  Copyright © 2019 smartlife. All rights reserved.
//


import UIKit

class MenuItemCell: UITableViewCell {
    
    let selectedColor = UIColor(red: 188/255, green: 67/255, blue: 57/255, alpha: 1)
    let unSelectedColor = UIColor(red: 94/255, green: 96/255, blue: 97/255, alpha: 1)
    
    public let bgView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 248/255, green: 232/255, blue: 229/255, alpha: 1)
        return v
    }()
    
    public let txtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = "Primary"
        label.textColor = UIColor(red: 188/255, green: 67/255, blue: 57/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    public let imgView: UIImageView = {
        let img = EmailImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .blue
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        bgView.isHidden = !selected
        txtLabel.textColor = selected ? self.selectedColor : self.unSelectedColor
        imgView.backgroundColor = selected ? self.unSelectedColor : self.unSelectedColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bgViewRadius = frame.height / 2
        let txtLabelRadius = txtLabel.frame.height / 2
        
        bgView.roundCorners(corners: [.topRight, .bottomRight], radius: bgViewRadius)
        txtLabel.roundCorners(corners: [.topRight, .bottomRight], radius: txtLabelRadius)
    }
    
    private func setupViews() {
        selectionStyle = .none
        addViews()
        addViewsConstraints()
    }
    
    private func addViews() {
        addSubview(bgView)
        addSubview(txtLabel)
        addSubview(imgView)
    }
    
    private func addViewsConstraints() {
        let stackView = UIStackView(arrangedSubviews: [imgView, txtLabel, UIView()])
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 8, left: 12, bottom: 8, right: 12)

        NSLayoutConstraint.activate([
            bgView.leftAnchor.constraint(equalTo: leftAnchor),
            bgView.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        
        sendSubviewToBack(bgView)
    }
}
