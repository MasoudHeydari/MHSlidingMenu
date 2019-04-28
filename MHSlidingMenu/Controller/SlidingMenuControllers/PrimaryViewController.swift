//
//  HomeController.swift
//  MHSlidingMenu
//
//  Created by Masoud Heydari on 3/20/19.
//  Copyright © 2019 smartlife. All rights reserved.
//

import UIKit

class PrimaryViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    private var primaryList = [PrimaryModel]()
    private let primaryCellId = "primary_cell_id"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFakeData()
        
        guard let root = (UIApplication.shared.keyWindow?.rootViewController) as? MHBaseSlidingController else { return }
        root.delegate = self
        
        setupTableView()
        setupNavigationItems()

    }
    
    private func getFakeData() {
        let const = Const()
        self.primaryList = const.getFakeEmailList()
    }
    
    private func setupTableView() {
        tableView.register(PrimaryItemCell.self , forCellReuseIdentifier: primaryCellId)
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    @objc func handleOpen() {
        print("i am here!")
        (UIApplication.shared.keyWindow?.rootViewController as? MHBaseSlidingController)?.openMenu()
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Primary"
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
        
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.primaryList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell selected")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: primaryCellId, for: indexPath) as? PrimaryItemCell else { return UITableViewCell()}
        cell.titleLabel.text = self.primaryList[indexPath.row].titel
        cell.descriptionLabel.text = self.primaryList[indexPath.row].description
        cell.imgUser.image = self.primaryList[indexPath.row].img
        cell.dateLabel.text = self.primaryList[indexPath.row].date

        return cell
        
    }
}

extension PrimaryViewController: MHBaseSlidingControllerDelegate {
    func menuDidOpen() {
//        print("menuDidOpen")
    }
    
    func menuDidClose() {
//        print("menuDidClose")
    }
    
    func menuWillOpen() {
//        print("menuWillOpen")
    }
    
    func menuWillClose() {
//        print("menuWillClose")
    }
}
