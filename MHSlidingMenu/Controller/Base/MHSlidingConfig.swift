//
//  MHSlidingConfig.swift
//  MHSlidingMenu
//
//  Created by Masoud Heydari on 5/1/19.
//  Copyright © 2019 smartlife. All rights reserved.
//

import UIKit

struct MHSlidingCofig {
    let direction: MHSlidinMenuDirection
    let mode: MHSlidingMenuMode
    let statusbarStyleWhenMenuIsOpen: UIStatusBarStyle
    let menuWidth: CGFloat
}

enum MHSlidinMenuDirection {
    case rtl
    case ltr
}

enum MHSlidingMenuMode {
    case slideIn
    case slideOut
}
