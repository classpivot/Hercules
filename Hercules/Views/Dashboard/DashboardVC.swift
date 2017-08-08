//
//  ViewController.swift
//  Bloodhoof
//
//  Created by Xiao Yan on 6/24/17.
//  Copyright © 2017 Xiao Yan. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarInit()
    }

    func navigationBarInit() {
        navigationItem.title = NSLocalizedString("Records", comment: "")
        
//        //navi left button
//        let img = UIImage(named: "menu")!.imageWithColor(UIColor.white)
//        menuButton = UIButton(type: .custom);
//        menuButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
//        menuButton.setBackgroundImage(img, for: .normal)
//        menuButton.addTarget(self, action: #selector(self.didTapOpenButton(sender:)), for: .touchUpInside)
//        let naviLeftButton = UIBarButtonItem()
//        naviLeftButton.customView = menuButton
//        navigationItem.leftBarButtonItem = naviLeftButton
//        
//        //navi right button
//        helpButton = UIButton(type: .custom)
//        helpButton.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
//        helpButton.setTitle("Help", for: .normal)
//        helpButton.addTarget(self, action: #selector(self.didTapHelpButton(sender:)), for: .touchUpInside)
//        let naviRightButton = UIBarButtonItem()
//        naviRightButton.customView = helpButton
//        navigationItem.rightBarButtonItem = naviRightButton
    }
}

