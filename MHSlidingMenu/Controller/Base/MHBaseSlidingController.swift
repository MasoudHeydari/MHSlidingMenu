//
//  BaseSlidingController.swift
//  MHSlidingMenu
//
//  Created by Masoud Heydari on 3/20/19.
//  Copyright © 2019 smartlife. All rights reserved.
//

import UIKit

class DarkView: UIView { }

final class MHBaseSlidingController: UIViewController {
    
    private let isMenuMode: Bool
    private let isLeftToRight: Bool
    private let statusbarStyleWhenMenuIsOpen: UIStatusBarStyle
    
    private let config: MHSlidingCofig
    
    private let withDuration: TimeInterval = 0.3
    fileprivate let direction: MHSlidinMenuDirection
    fileprivate let mode: MHSlidingMenuMode
    
    // MARK:- Properties
    private var sliderLeftConstraint: NSLayoutConstraint!
    private var sliderRightConstraint: NSLayoutConstraint!
    
    public weak var delegate: MHBaseSlidingControllerDelegate?
    
    private var rightViewController: UIViewController
    private var menuController: UIViewController
    
    private var isMenuOpen = false
    private var menuWidth: CGFloat
    private let velocityThreshold: CGFloat = 500
    
    fileprivate let mainViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    fileprivate let menuViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let darkViewCover: DarkView = {
        let view = DarkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.isUserInteractionEnabled = false
        view.alpha = 0
        return view
    }()
    
    fileprivate let dummyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isMenuOpen ? self.config.statusbarStyleWhenMenuIsOpen : .default
    }
    
    init(baseController: UIViewController, menuController: UIViewController, config: MHSlidingCofig) {
        self.config = config
        self.rightViewController = UINavigationController(rootViewController: baseController)
        self.menuController = menuController
        self.mode = config.mode
        self.direction = config.direction
        
        self.isMenuMode = (config.mode == .slideOut) ? true : false
        self.isLeftToRight = (config.direction == .LTR) ? true : false

        self.menuWidth = config.menuWidth
        
        self.statusbarStyleWhenMenuIsOpen = config.statusbarStyleWhenMenuIsOpen
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Helper Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainView()
        addViews()
        addConstraints()
        setupGestures()
    }
    
    private func setupMainView() {
        view.backgroundColor = .white
    }
    
    private func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
        let darkViewGesture = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        darkViewCover.addGestureRecognizer(darkViewGesture)
    }
    
    private func addViews() {
        view.addSubview(mainViewContainer)
        view.addSubview(menuViewContainer)
        
        if !isMenuMode {
            view.addSubview(dummyView)
        }
    }
    
    private func addConstraints() {
        
        addCommonConstraints()
        
        if isMenuMode {
            addConstraintsWhenIsMenuModeIsTrue()
        } else {
            addConstraintsWhenIsMenuModeIsFalse()
        }
        
        setupViewControllers()
    }
    
    fileprivate func addCommonConstraints() {
        NSLayoutConstraint.activate([
            // mainViewContainer view constraints
            mainViewContainer.topAnchor.constraint(equalTo: view.topAnchor),
            mainViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // menuViewContainer view constraints
            menuViewContainer.topAnchor.constraint(equalTo: view.topAnchor),
            menuViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuViewContainer.widthAnchor.constraint(equalToConstant: self.menuWidth)
            ])
    }
    
    fileprivate func addConstraintsWhenIsMenuModeIsTrue() {

        if isLeftToRight {
            sliderRightConstraint = mainViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor)
            sliderRightConstraint.isActive = true
            
            sliderLeftConstraint = mainViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor)
            sliderLeftConstraint.isActive = true
            
            menuViewContainer.trailingAnchor.constraint(equalTo: mainViewContainer.leadingAnchor).isActive = true
        } else {
            sliderLeftConstraint = mainViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor)
            sliderLeftConstraint.isActive = true
            
            sliderRightConstraint = mainViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor)
            sliderRightConstraint.isActive = true
            
            menuViewContainer.leftAnchor.constraint(equalTo: mainViewContainer.rightAnchor).isActive = true
        }
    }
    
    fileprivate func addConstraintsWhenIsMenuModeIsFalse() {
        mainViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        dummyView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dummyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        sliderRightConstraint = dummyView.rightAnchor.constraint(equalTo: view.rightAnchor)
        sliderRightConstraint.isActive = true
        
        sliderLeftConstraint = dummyView.leftAnchor.constraint(equalTo: view.leftAnchor)
        sliderLeftConstraint.isActive = true
        
        if isLeftToRight {
            menuViewContainer.trailingAnchor.constraint(equalTo: dummyView.leadingAnchor).isActive = true
        } else {
            menuViewContainer.leftAnchor.constraint(equalTo: dummyView.rightAnchor).isActive = true
        }
        
    }
    
    fileprivate func addDarkViewsConstraints() {
        if isMenuMode {
            darkViewCover.leftAnchor.constraint(equalTo: mainViewContainer.leftAnchor).isActive = true
            darkViewCover.rightAnchor.constraint(equalTo: mainViewContainer.rightAnchor).isActive = true
            darkViewCover.topAnchor.constraint(equalTo: mainViewContainer.topAnchor).isActive = true
            darkViewCover.bottomAnchor.constraint(equalTo: mainViewContainer.bottomAnchor).isActive = true
        } else {
            darkViewCover.leftAnchor.constraint(equalTo: dummyView.leftAnchor).isActive = true
            darkViewCover.rightAnchor.constraint(equalTo: dummyView.rightAnchor).isActive = true
            darkViewCover.topAnchor.constraint(equalTo: dummyView.topAnchor).isActive = true
            darkViewCover.bottomAnchor.constraint(equalTo: dummyView.bottomAnchor).isActive = true
        }
    }
    
    private func setupViewControllers() {
        let homeView = rightViewController.view!
        let menuView = menuController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        mainViewContainer.addSubview(homeView)
        isMenuMode ? mainViewContainer.addSubview(darkViewCover) : dummyView.addSubview(darkViewCover)
        menuViewContainer.addSubview(menuView)
        
        addChild(rightViewController)
        addChild(menuController)
        
        NSLayoutConstraint.activate([
            homeView.leftAnchor.constraint(equalTo: mainViewContainer.leftAnchor),
            homeView.rightAnchor.constraint(equalTo: mainViewContainer.rightAnchor),
            homeView.topAnchor.constraint(equalTo: mainViewContainer.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: mainViewContainer.bottomAnchor),
            
            menuView.leftAnchor.constraint(equalTo: menuViewContainer.leftAnchor),
            menuView.rightAnchor.constraint(equalTo: menuViewContainer.rightAnchor),
            menuView.topAnchor.constraint(equalTo: menuViewContainer.topAnchor),
            menuView.bottomAnchor.constraint(equalTo: menuViewContainer.bottomAnchor),
            
            ])
        
        addDarkViewsConstraints()
    }
    
    private func rightViewControllerCleanUp() {
        rightViewController.removeFromParent()
        rightViewController.view.removeFromSuperview()
    }
    
    public final func showNewViewController(_ newController: UIViewController, completion: (() -> Void)? = nil) {
        // first of all, close the menu
        self.closeMenu()
        // after that, clean up the rightViewController
        self.rightViewControllerCleanUp()
        
        rightViewController = newController
        
        mainViewContainer.addSubview(rightViewController.view)
        addChild(rightViewController)
        
        isMenuMode ? mainViewContainer.bringSubviewToFront(darkViewCover) : dummyView.bringSubviewToFront(darkViewCover)
        
        // unwrap the completion block with 'guard let'
        guard let completion = completion else {
            print("BaseSlidingController: completion block is nil!")
            return
            
        }
        // perform completion block
        completion()
    }
    
    fileprivate func privateOpenMenu() {
        // enable user interaction for darkView if isMenuMode is false
        setUserInteractionForDummyAndDarkView(true)
        
        isMenuOpen = true
        delegate?.menuWillOpen()
        
        sliderLeftConstraint.constant = isLeftToRight ? menuWidth : -menuWidth
        sliderRightConstraint.constant = isLeftToRight ? menuWidth : -menuWidth
        
        performAnimations { [weak self] in
            guard let strongSelf = self else { return }
            guard let delegate = strongSelf.delegate else { return }
            delegate.menuDidOpen()
        }
        
        // update the status bar style
        setNeedsStatusBarAppearanceUpdate()
    }
    
    fileprivate func privateCloseMenu() {
        // disable user interaction for darkView if isMenuMode is true
        setUserInteractionForDummyAndDarkView(false)
        
        isMenuOpen = false
        delegate?.menuWillClose()
        
        sliderLeftConstraint.constant = 0
        sliderRightConstraint.constant = 0
        
        performAnimations { [weak self] in
            guard let strongSelf = self else { return }
            guard let delegate = strongSelf.delegate else { return }
            delegate.menuDidClose()
        }
        // update the status bar style
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func performAnimations(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: withDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.view.layoutIfNeeded()
            strongSelf.darkViewCover.alpha = strongSelf.isMenuOpen ? 1 : 0
            }, completion: { (_) in
                completion?()
        })
    }
    
    fileprivate func setUserInteractionForDummyAndDarkView(_ isEnabled: Bool) {
        darkViewCover.isUserInteractionEnabled = isEnabled
        dummyView.isUserInteractionEnabled = isEnabled
    }
    
    // MARK:- Selector
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        
        if isLeftToRight {
            handlePanWhenDirectionisLTR(gesture: gesture)
        } else {
            handlePanWhenDirectionisRTL(gesture: gesture)
        }
        
        switch gesture.state {
        case .ended:
            handlePanEnded(gesture: gesture)
        default:
            break
        }
    }
    
    fileprivate func handlePanWhenDirectionisLTR(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpen ? (x + menuWidth) : x
        
        x = min(x, self.menuWidth)
        x = max(0, x)
        
        sliderLeftConstraint.constant = x
        sliderRightConstraint.constant = x
        
        darkViewCover.alpha = x / menuWidth

    }
    
    fileprivate func handlePanWhenDirectionisRTL(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x

        x = isMenuOpen ? (x - menuWidth) : x
        
        x = min(0, x)
        x = max(x, -menuWidth)
        
        sliderLeftConstraint.constant = x
        sliderRightConstraint.constant = x
        
        darkViewCover.alpha = -(x / menuWidth)
    }
    
    private func handlePanEnded(gesture: UIPanGestureRecognizer) {
        if isLeftToRight {
            handlePanEndedWhenDirectionisLTR(gesture: gesture)
        } else {
            handlePanEndedWhenDirectionisRTL(gesture: gesture)
        }
    }
    
    fileprivate func handlePanEndedWhenDirectionisLTR(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        let velocity = gesture.velocity(in: self.view)
        
        if isMenuOpen {
            // menu is open
            if velocity.x < -velocityThreshold {
                privateCloseMenu()
                return
            }
            
            if (translation.x < 0) && abs(translation.x) > (menuWidth / 2) {
                privateCloseMenu()
            }
            else {
                privateOpenMenu()
            }
        } else {
            // menu is close
            if (velocity.x) > velocityThreshold {
                // open the menu
                privateOpenMenu()
                return
            }
            
            if translation.x > (menuWidth / 2) {
                privateOpenMenu()
            } else {
                privateCloseMenu()
            }
        }
    }

    fileprivate func handlePanEndedWhenDirectionisRTL(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        let velocity = gesture.velocity(in: self.view)
        
        if isMenuOpen {
            // menu is open
            if velocity.x > velocityThreshold {
                privateCloseMenu()
                return
            }
            
            if (translation.x > 0) && translation.x > (menuWidth / 2) {
                privateCloseMenu()
            } else {
                privateOpenMenu()
            }
        } else {
            // menu is close
            if (velocity.x) < -velocityThreshold {
                // open the menu
                privateOpenMenu()
                return
            }
            
            if translation.x > -(menuWidth / 2) {
                privateCloseMenu()
            } else {
                privateOpenMenu()
            }
        }
    }
    
    @objc fileprivate func dismissMenu(gesture: UITapGestureRecognizer) {
        // close the menu
        privateCloseMenu()
    }
    
    public func openMenu() {
        privateOpenMenu()
    }
    
    public func closeMenu() {
        // close menu with a bit delay!
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.privateCloseMenu()
        }
    }
}

// MARK:- Delegate
@objc protocol MHBaseSlidingControllerDelegate: class {
    func menuDidOpen()
    func menuDidClose()
    
    func menuWillOpen()
    func menuWillClose()
}
