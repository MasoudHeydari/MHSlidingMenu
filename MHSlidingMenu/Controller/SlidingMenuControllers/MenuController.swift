//
//  MenuController.swift
//  MHSlidingMenu
//
//  Created by Masoud Heydari on 3/20/19.
//  Copyright © 2019 smartlife. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {
    private let menuCellId = "menu_cell_id"
    
    let textLabelList = [
        ["Primary", "Social", "Promotions"],
        ["Snoozed", "Stared", "Important", "Sent", "Settings"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupTableView()
        setupNavBar()
        
    }
    
    private func setupTableView() {
        // hide the unnecessery seperator lines of Table view
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: menuCellId)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.bounces = false
    }
    
    private func setupNavBar() {
        navigationItem.title = "Gmail Design"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return textLabelList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupTableViewCellForRow(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textLabelList[section].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performTableViewCellSelection(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setupViewForHeader(section: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 80 : 60
    }
}

extension MenuController {
    
    fileprivate func performTableViewCellSelection(indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MenuItemCell else { return }
        switch indexPath.section {
        case 0:
            var txtAndBackgroundColor = UIColor()
            
            if indexPath.row == 0 {
                txtAndBackgroundColor = UIColor(red: 188/255, green: 67/255, blue: 57/255, alpha: 1)
            } else if indexPath.row == 1 {
                txtAndBackgroundColor = UIColor(red: 86/255, green: 135/255, blue: 209/255, alpha: 1)
            } else if indexPath.row == 2 {
                txtAndBackgroundColor = UIColor(red: 71/255, green: 149/255, blue: 86/255, alpha: 1)
            }
            
            cell.txtLabel.textColor = txtAndBackgroundColor
            cell.imgView.backgroundColor = txtAndBackgroundColor
            
        default:
            cell.txtLabel.textColor = UIColor(red: 92/255, green: 94/255, blue: 96/255, alpha: 1)
        }
        menuItemSelected(indexPath: indexPath)
    }
    
    fileprivate func menuItemSelected(indexPath: IndexPath) {
        guard let rootViewController = (UIApplication.shared.keyWindow?.rootViewController as? MHBaseSlidingController) else { return }
        if indexPath.section == 0 {
            
            switch indexPath.row {
            case 0:
                // Primary Controller
                rootViewController.showNewViewController(UINavigationController(rootViewController: PrimaryViewController()))
            case 1:
                // Social Controller
                rootViewController.showNewViewController(UINavigationController(rootViewController: SocialViewController()))
            case 2:
                // Promotions Controller
                rootViewController.showNewViewController(UINavigationController(rootViewController: PromotionsViewController()))
            default:
                // closing the menu
                rootViewController.closeMenu()
            }
        } else {
            print(" akdjfksfjsfsjfksfn slksjfdks dfklsdfkljsdf")
            rootViewController.closeMenu()
        }
    }
    
    fileprivate func setupViewForHeader(section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = HeaderView()
            return headerView
        case 1:
            let headerLabel = HeaderLabel()
            return headerLabel
        default:
            return nil
        }
    }
    
    fileprivate func setupTableViewCellForRow(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: menuCellId, for: indexPath) as? MenuItemCell else { return UITableViewCell() }
        
        cell.txtLabel.text = textLabelList[indexPath.section][indexPath.row]

        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.bgView.backgroundColor = UIColor(red: 248/255, green: 232/255, blue: 229/255, alpha: 1)
            } else if indexPath.row == 1 {
                cell.bgView.backgroundColor = UIColor(red: 232/255, green: 242/255, blue: 252/255, alpha: 1)
            } else {
                cell.bgView.backgroundColor = UIColor(red: 231/255, green: 243/255, blue: 233/255, alpha: 1)
            }
            
        default:
            cell.bgView.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        }
        return cell
    }
}
