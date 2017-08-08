//
//  Constants.swift
//  Bloodhoof
//
//  Created by Xiao Yan on 7/22/17.
//  Copyright © 2017 Xiao Yan. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct Colors {
        static let blue = UIColor(red: 0/255.0, green: 122/255.0, blue: 250/255.0, alpha: 1.0)
        static let red = UIColor(red: 255/255.0, green: 59/255.0, blue: 48/255.0, alpha: 1.0)
        static let orange = UIColor(red: 255/255.0, green: 149/255.0, blue: 0/255.0, alpha: 1.0)
        static let yellow = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 0/255.0, alpha: 1.0)
        static let green = UIColor(red: 76/255.0, green: 217/255.0, blue: 100/255.0, alpha: 1.0)
        static let teal_blue = UIColor(red: 90/255.0, green: 200/255.0, blue: 250/255.0, alpha: 1.0)
        static let purple = UIColor(red: 88/255.0, green: 86/255.0, blue: 214/255.0, alpha: 1.0)
        static let gray = UIColor(red: 209/255.0, green: 211/255.0, blue: 212/255.0, alpha: 1.0)
        static let darkGray = UIColor(red: 90/255.0, green: 90/255.0, blue: 90/255.0, alpha: 1.0)
        static let pink = UIColor(red: 253/255.0, green: 137/255.0, blue: 137/255.0, alpha: 1.0)
    }
    
    static let bodyParts = ["Chest", "Back", "Arms", "Shoulder", "Legs", "Glutes", "Core", "Cardio"]
}

extension UIViewController {
    func popupSimpleAlert(title:String = "Warning!", message:String = "") {
        if self.presentedViewController != nil {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    self.popupAlert(title: "Test", message: "Test", actionTitles: ["Good", "Bad"], actions: [
    {
    action1 in
    print("action 1!")
    },
    {
    action2 in
    print("action 2!")
    }
    ])
    */
}

extension UIImage {
    func imageWithColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext() as CGContext!
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0);
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context?.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension Date {
    func startOfDay() -> Date {
        let calendar = Calendar.current
        var components = (calendar as NSCalendar).components([.day , .month, .year], from: self)
        components.setValue(0, for: .hour)
        components.setValue(0, for: .minute)
        components.setValue(0, for: .second)
        return calendar.date(from: components)!
    }
    
    func endOfDay() -> Date {
        let calendar = Calendar.current
        var components = (calendar as NSCalendar).components([.day , .month, .year], from: self)
        components.setValue(23, for: .hour)
        components.setValue(59, for: .minute)
        components.setValue(59, for: .second)
        return calendar.date(from: components)!
    }
}
