//
//  EmailViewController.swift
//  TrainApp
//
//  Created by Ashok, Raja Vignesh (Cognizant) on 25/12/2019.
//  Copyright © 2019 Ashok, Raja Vignesh (Cognizant). All rights reserved.
//

import UIKit
import Firebase

class SigninViewController: UIViewController {
    
    // MARK: UIElements
    
    var stackView:UIStackView?
    var outerStack:UIStackView?
    
    var email:String {
        return emailTextField.text ?? ""
    }
    
    var password:String {
        return passwordTextField.text ?? ""
    }
    
    var submitButtonTitle: String {
        return "Signin"
    }
    
    private lazy var emailTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 4.0
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private lazy var passwordTextField:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 4.0
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private lazy var emailLabel:UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Email :"
        return lbl
    }()
    
    private lazy var passwordLabel:UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Password :"
        return lbl
    }()
    
    private lazy var submitButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(submitButtonTitle, for: .normal)
        btn.addTarget(self, action: #selector(signin), for: .touchUpInside)
        return btn
    }()
    
    @objc func signin() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            print(strongSelf)
            if let err = error {
                print(err)
            } else {
                print("success login")
                print(authResult!)
                if let appDelegate = UIApplication.shared.delegate{
                    appDelegate.window??.rootViewController =        UINavigationController(rootViewController: HomeViewController())

                        
                }
            }
            // ...
        }
    }
    
    func setupUI() {
        stackView = UIStackView(arrangedSubviews: [emailLabel,emailTextField,passwordLabel,passwordTextField])
        guard let stackView = stackView else {return}
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        outerStack = UIStackView(arrangedSubviews: [stackView,submitButton])
        guard let outerStack = outerStack else {return}
        outerStack.axis = .vertical
        outerStack.spacing = 5
        outerStack.translatesAutoresizingMaskIntoConstraints = false
        outerStack.alignment = .trailing
        self.view.addSubview(outerStack)
        
        outerStack.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        outerStack.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        //outerStack.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
  
    }
    
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        setupUI()
    }
    
    
    
    
    
    
    
}
