//
//  WelcomeVC.swift
//  Hercules
//
//  Created by Xiao Yan on 8/27/17.
//  Copyright © 2017 Class Pivot. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        UIApplication.shared.statusBarStyle = .default
        
        skipButtonInit()
        iconImageViewInit()
        buttonsInit()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    deinit {
        print("WelcomeVC is destroyed.")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("WelcomeVC: Meory Warning!")
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - draw UI
extension WelcomeVC {
    fileprivate func skipButtonInit() {
        let skipButton = UIButton(frame: CGRect(x: 10, y: 30, width: 50, height: 30))
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(UIColor.black, for: .normal)
        skipButton.addTarget(self, action: #selector(self.skipButtonClicked), for: .touchUpInside)
        self.view.addSubview(skipButton)
        
    }
    
    fileprivate func iconImageViewInit() {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "gymnote_icon_white_raw_414x414")
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(iconImageView)
        
        let appNameLabel = UILabel()
        appNameLabel.text = "GYMNOTE"
        appNameLabel.textColor = Constants.Colors.icon_navyblue
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 35)
        appNameLabel.textAlignment = .center
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(appNameLabel)
        
        iconImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -device_height*0.15).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1).isActive = true
        
        appNameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 0).isActive = true
        appNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    fileprivate func buttonsInit() {
        let buttonWidth = device_width*0.7, buttonHeight = buttonWidth*0.15
        let fbLoginButton = UIButton()
        fbLoginButton.setTitle("Facebook", for: .normal)
        fbLoginButton.setTitleColor(UIColor.black, for: .normal)
        fbLoginButton.addTarget(self, action: #selector(self.skipButtonClicked), for: .touchUpInside)
        fbLoginButton.backgroundColor = UIColor.red
        fbLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fbLoginButton)
        
        let signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(UIColor.black, for: .normal)
        signUpButton.addTarget(self, action: #selector(self.skipButtonClicked), for: .touchUpInside)
        signUpButton.backgroundColor = UIColor.blue
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signUpButton)
        
        let haveAccountLabel = UILabel()
        haveAccountLabel.text = NSLocalizedString("Already have an account?", comment: "")
        haveAccountLabel.textAlignment = .center
        haveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(haveAccountLabel)
        
        let loginButton = UIButton()
        loginButton.setTitle("LOG IN", for: .normal)
        loginButton.setTitleColor(Constants.Colors.icon_navyblue, for: .normal)
        loginButton.addTarget(self, action: #selector(self.skipButtonClicked), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginButton)
        
        fbLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        fbLoginButton.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(buttonHeight*3+90)).isActive = true
        fbLoginButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        fbLoginButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        signUpButton.topAnchor.constraint(equalTo: fbLoginButton.bottomAnchor, constant: 30).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        haveAccountLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -35).isActive = true
        haveAccountLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20).isActive = true
        
        loginButton.centerYAnchor.constraint(equalTo: haveAccountLabel.centerYAnchor, constant: 0).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: haveAccountLabel.trailingAnchor, constant: 10).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}

//MARK: - User Interactions
extension WelcomeVC {
    @objc fileprivate func skipButtonClicked() {
        self.performSegue(withIdentifier: "WelcomeToMainSegue", sender: nil)
    }
}
