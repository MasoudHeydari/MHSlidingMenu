//
//  ListsController.swift
//  MHSlidingMenu
//
//  Created by Masoud Heydari on 3/31/19.
//  Copyright © 2019 smartlife. All rights reserved.
//
import UIKit

class SocialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        setupCircularNavigationButton()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupNavBar() {
        navigationItem.title = "Social"
    }
    
    private func setupCircularNavigationButton() {
        
        let image = #imageLiteral(resourceName: "masoud_profile").withRenderingMode(.alwaysOriginal)
        
        let customView = UIButton(type: .system)
        customView.setImage(image, for: .normal)
        customView.addTarget(self, action: #selector(self.handleOpen), for: .touchUpInside)
        
        customView.clipsToBounds = true
        customView.layer.cornerRadius = 20
        
        customView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView)
    }
    
    @objc private func handleOpen() {
        guard let rootViewController = (UIApplication.shared.keyWindow?.rootViewController as? MHBaseSlidingController) else { return }
        rootViewController.openMenu()
    }
}
