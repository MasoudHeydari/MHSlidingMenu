//
//  MenuCellItem.swift
//  MHSlidingMenu
//
//  Created by Masoud Heydari on 3/29/19.
//  Copyright © 2019 smartlife. All rights reserved.
//

import UIKit

class PrimaryItemCell: UITableViewCell {
    
    public let imgUser: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        return img
    }()

    public let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
    public let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = .white
        return label
    }()
    
    public let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = UIColor.gray.withAlphaComponent(0.9)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "23 Mars"
        label.numberOfLines = 1
        return label
    }()
    
    private let startImg: ImgStar = {
        let img = ImgStar()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .white
        img.image = UIImage(named: "star")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        addViews()
        addViewsConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgUser.layer.cornerRadius = imgUser.frame.height / 2
    }
    
    private func setupView() {
        selectionStyle = .none
    }
    
    private func addViews() {
        addSubview(imgUser)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        addSubview(startImg)
    }
    
    private func addViewsConstraints() {
        NSLayoutConstraint.activate([
            imgUser.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            imgUser.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            imgUser.widthAnchor.constraint(equalToConstant: 48),
            imgUser.heightAnchor.constraint(equalToConstant: 48),

            titleLabel.leftAnchor.constraint(equalTo: imgUser.rightAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: imgUser.topAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 3/5),
            
            dateLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 4),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            dateLabel.topAnchor.constraint(equalTo: imgUser.topAnchor),
            
            descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 4/6),
            
            startImg.rightAnchor.constraint(equalTo: dateLabel.rightAnchor),
            startImg.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor)
            ])
    }
}


