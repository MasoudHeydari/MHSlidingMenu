//
//  Const.swift
//  MHSlidingMenu
//
//  Created by Masoud Heydari on 3/20/19.
//  Copyright © 2019 smartlife. All rights reserved.
//

import UIKit

struct Const {
    static let empty = ""
    
    struct Image {
        static let profile = ""
    }
    
    struct NavTitle {
        
    }
    
    public func getFakeEmailList() -> [PrimaryModel] {
        let p1 = PrimaryModel(img: UIImage(named: "masoud")!, titel: "Masoud Heydari", description: "As a developer, it's tempting to start writing code as soon as that brilliant idea enters your mind. I have taken that path too many times in the past. This week and last week's episodes focus on tasks I handle before writing that first line of code.", date: "MAR 23", isStared: true )
        
        
        let p2 = PrimaryModel(img: UIImage(named: "mohammad")!, titel: "Mohammad Teimory", description: "Mohammad Teimori Pabandi has 6 new connections.\n People you may know...", date: "MAR 24", isStared: true )
        
        
        let p3 = PrimaryModel(img: UIImage(named: "drew")!, titel: "Drew Badger", description: "I got a lot of great feedback and questions from learners during yesterday's live video on Facebook. One learner named Mel explained that he could understand what I was saying, but that he often had trouble understanding natives.", date: "MAR 21", isStared: true )
        
        
        let p4 = PrimaryModel(img: UIImage(named: "robert")!, titel: "Robert Kiyosaki", description: "Take code signing as an example. It often surprises me how companies manage certificates and provisioning profiles in a team. There are many approaches, but fastlane's way of working feels like the right one. Set it and forget it.", date: "MAR 23", isStared: true )
        
        
        let p5 = PrimaryModel(img: UIImage(named: "bart")!, titel: "Bart Jacobs", description: "As a developer, it's tempting to start writing code as soon as that brilliant idea enters your mind. I have taken that path too many times in the past. This week and last week's episodes focus on tasks I handle before writing that first line of code.", date: "MAR 23", isStared: true )
        
        //        Drew Badger
        return [p4, p2, p1, p3, p5]
    }
}
