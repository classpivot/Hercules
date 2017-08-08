//
//  MainTabBar.swift
//  Bloodhoof
//
//  Created by Xiao Yan on 7/26/17.
//  Copyright © 2017 Xiao Yan. All rights reserved.
//

import UIKit
import Foundation

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewWillLayoutSubviews()
    {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 60
        tabFrame.origin.y = self.view.frame.size.height - 60
        self.tabBar.frame = tabFrame
        self.delegate = self
    }
    
    override func viewDidLoad() {
        UITabBar.appearance().tintColor = UIColor.white
        
        // Sets the default color of the background of the UITabBar
        //        UITabBar.appearance().barTintColor = UIColor(red: 245.0/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        UITabBar.appearance().barTintColor = Constants.Colors.darkGray
        // Sets the background color of the selected UITabBarItem (using and plain colored UIImage with the width = 1/5 of the tabBar (if you have 5 items) and the height of the tabBar)
        for item in self.tabBar.items as [UITabBarItem]! {
            if let image = item.image {
                item.image = image.imageWithColor(Constants.Colors.gray).withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController.viewDidAppear(true)

    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    
}
