//
//  WelcomeVC.swift
//  Hercules
//
//  Created by Xiao Yan on 8/27/17.
//  Copyright © 2017 Class Pivot. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftyJSON
import Firebase

class WelcomeVC: UIViewController {
    
    var email = ""
    var password = ""
    var alertView:UIAlertController?
    let userDefaults = UserDefaults.standard
    var fbResult: JSON? = nil
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
                
        UIApplication.shared.statusBarStyle = .default
        self.navigationController?.navigationBar.isHidden = true
        
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
        fbLoginButton.setTitleColor(UIColor.black, for: .normal)
        fbLoginButton.addTarget(self, action: #selector(self.fbLoginbuttonClicked), for: .touchUpInside)
        fbLoginButton.setBackgroundImage(UIImage(named: "fb_login_button_414x56"), for: .normal)
        fbLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fbLoginButton)
        
        let signUpButton = UIButton()
        signUpButton.setTitleColor(UIColor.black, for: .normal)
        signUpButton.addTarget(self, action: #selector(self.skipButtonClicked), for: .touchUpInside)
        signUpButton.setBackgroundImage(UIImage(named: "signup_button_414x56"), for: .normal)
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
        loginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
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
    
    @objc fileprivate func fbLoginbuttonClicked() {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) { [weak self] (result, error) -> Void in
            guard error == nil else {
                return
            }
            let fbLoginResult = result
            if (fbLoginResult?.grantedPermissions.contains("email"))! {
                self?.loginWithFB()
            }
        }
    }
    
    @objc fileprivate func loginButtonClicked() {
        appDelegate.processToMainPage()
    }
}

//MARK: - Helper functions
extension WelcomeVC {
    fileprivate func loginWithFB(){
        guard (FBSDKAccessToken.current()) != nil else {
            return
        }
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "gender, id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
            guard error == nil else {
                print(error!.localizedDescription)
                let alert = UIAlertController(title: "Facebook login failed!", message: "Please signup your own account and try again.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.fbResult = JSON(result!)
            if let fbEmail = self.fbResult!["email"].string {
                self.userDefaults.setValue(fbEmail, forKey: Constants.UserDefaults.KEY_FB_EMAIL)
                self.password = self.getRandomSecurePassword()
                Auth.auth().createUser(withEmail: fbEmail, password: self.password) { [weak self] (user, error) in
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    guard error == nil else {
                        print(error!.localizedDescription)
                        Auth.auth().signIn(with: credential) { (user, error) in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                let alert = UIAlertController(title: "Facebook login failed!", message: "Please signup your own account and try again.", preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:nil))
                                self?.present(alert, animated: true, completion: nil)
                                return
                            }
                            self?.saveFbData()
                            self?.appDelegate.processToMainPage()
                        }
                        return
                    }
                    self?.userDefaults.set(fbEmail, forKey: Constants.UserDefaults.KEY_EMAIL)
                    self?.userDefaults.set(self?.password, forKey: Constants.UserDefaults.KEY_PASSWORD)
                    user!.link(with: credential) { (user, error) in
                        guard error == nil else {
                            print(error!.localizedDescription)
                            self?.saveFbData()
                            return
                        }
                        print("Connect account with FB!")
                        let changeRequest = user!.createProfileChangeRequest()
                        if let fbName = self?.fbResult!["name"].string {
                            self?.userDefaults.setValue(fbName, forKey: Constants.UserDefaults.KEY_NICKNAME)
                            changeRequest.displayName = fbName
                        }
                        if let fbPictureUrl = self?.fbResult!["picture"]["data"]["url"].string {
                            self?.userDefaults.setValue(fbPictureUrl, forKey: Constants.UserDefaults.KEY_PORTRAIT_URL)
                            //changeRequest.photoURL = fbPictureUrl
                        }
                        changeRequest.commitChanges { error in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                            // Profile updated.
                        }
                    }
                    //                        self.saveFbData()
                    //                        self.appDelegate.processToMainPage()
                }
            }
            print("only return once")
        })
        
    }
    
    func saveFbData() {
        if let fbId = self.fbResult!["id"].string {
            self.userDefaults.setValue(fbId, forKey: Constants.UserDefaults.KEY_FB_ID)
            //            self.databaseRef.child("user_info").child((FIRAuth.auth()?.currentUser?.uid)!).setValue(["fb_id" : fbId])
        }
        if let fbGender = self.fbResult!["gender"].string {
            self.userDefaults.setValue(fbGender, forKey: Constants.UserDefaults.KEY_GENDER)
            //            self.databaseRef.child("user_info").child((FIRAuth.auth()?.currentUser?.uid)!).setValue(["gender" : fbGender])
        }
        if let fbFirstName = self.fbResult!["first_name"].string {
            self.userDefaults.setValue(fbFirstName, forKey: Constants.UserDefaults.KEY_FIRST_NAME)
        }
        if let fbLastName = self.fbResult!["last_name"].string {
            self.userDefaults.setValue(fbLastName, forKey: Constants.UserDefaults.KEY_LAST_NAME)
        }
        if let fbPictureUrl = self.fbResult!["picture"]["data"]["url"].string {
            self.userDefaults.setValue(fbPictureUrl, forKey: Constants.UserDefaults.KEY_PORTRAIT_URL)
        }
        
    }
    
    func getRandomSecurePassword() -> String {
        return "123456"
        //TODO: create random password
    }
}
