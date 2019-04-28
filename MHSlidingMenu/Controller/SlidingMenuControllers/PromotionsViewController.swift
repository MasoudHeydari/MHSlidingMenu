//
//  PromotionsViewController.swift
//  MHSlidingMenu
//
//  Created by Masoud Heydari on 4/1/19.
//  Copyright © 2019 smartlife. All rights reserved.
//

import UIKit

class PromotionsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupNavBar() {
        navigationItem.title = "Promotions"
        setupCircularNavigationButton()
    }
    
    fileprivate func setupCircularNavigationButton() {
        let image = #imageLiteral(resourceName: "masoud_profile").withRenderingMode(.alwaysOriginal)
        
        let customView = UIButton(type: .system)
        customView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFit
        
        customView.layer.cornerRadius = 20
        customView.clipsToBounds = true
        
        customView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let barButtonItem = UIBarButtonItem(customView: customView)
        
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc private func handleOpen() {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? MHBaseSlidingController else { return }
        rootViewController.openMenu()
    }
}
