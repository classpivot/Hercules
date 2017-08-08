//
//  LoginVC.swift
//  Bloodhoof
//
//  Created by Xiao Yan on 7/29/17.
//  Copyright © 2017 Xiao Yan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: UIViewController {
    
    var loginInputView: UIView!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    
    let viewModel = LoginVM()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginInputViewInit()
        loginButtonInit()
        rxSetup()
    }
    
    
    
}

//MARK: UI setup
extension LoginVC {
    func loginInputViewInit() {
        loginInputView = UIView()
        loginInputView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginInputView)
        
        usernameTextField = UITextField()
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor.black.cgColor
        usernameTextField.placeholder = NSLocalizedString("Username", comment: "")
        usernameTextField.setLeftPaddingPoints(20)
        usernameTextField.clearButtonMode = .whileEditing
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        loginInputView.addSubview(usernameTextField)
        
        passwordTextField = UITextField()
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.placeholder = NSLocalizedString("Password", comment: "")
        passwordTextField.setLeftPaddingPoints(20)
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginInputView.addSubview(passwordTextField)
        
        //set constraints
        loginInputView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        loginInputView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        loginInputView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        loginInputView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        usernameTextField.topAnchor.constraint(equalTo: loginInputView.topAnchor, constant: 0).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: loginInputView.leadingAnchor, constant: 0).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: loginInputView.trailingAnchor, constant: 0).isActive = true
        usernameTextField.heightAnchor.constraint(equalTo: loginInputView.heightAnchor, multiplier: 0.5, constant: -5).isActive = true
        
        passwordTextField.bottomAnchor.constraint(equalTo: loginInputView.bottomAnchor, constant: 0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: loginInputView.leadingAnchor, constant: 0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: loginInputView.trailingAnchor, constant: 0).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: loginInputView.heightAnchor, multiplier: 0.5, constant: -5).isActive = true
        
    }
    
    func loginButtonInit() {
        loginButton = UIButton()
        loginButton.setTitle(NSLocalizedString("Login", comment: ""), for: .normal)
        loginButton.setTitleColor(Constants.Colors.darkGray, for: UIControlState())
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderColor = Constants.Colors.darkGray.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: UIControlEvents.touchUpInside)
        loginButton.isEnabled = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginButton)
        
        loginButton.topAnchor.constraint(equalTo: loginInputView.bottomAnchor, constant: 100).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6, constant: 0).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

//MARK: - Rx setup
extension LoginVC {
    fileprivate func rxSetup() {
        //bind usernameTextField with viewModel
        usernameTextField.rx.textInput.text.orEmpty
            .bindTo(viewModel.username)
            .addDisposableTo(disposeBag)
        
        //bind passwordTextField with viewModel
        passwordTextField.rx.textInput.text.orEmpty
            .bindTo(viewModel.password)
            .addDisposableTo(disposeBag)
        
        //bind viewModel isValid check with loginButton
        viewModel.isValid
            .map{valid in
                if valid {
                    self.loginButton.setTitleColor(Constants.Colors.darkGray, for: .normal)
                } else {
                    self.loginButton.setTitleColor(Constants.Colors.gray, for: .normal)
                }
                return valid
            }
            .bindTo(loginButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
        
        //do something when data in viewModel changed
        viewModel.username.asObservable()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - User Interaction
extension LoginVC {
    func loginButtonClicked() {
        self.performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
    }
}
