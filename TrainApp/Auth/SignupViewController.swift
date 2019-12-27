//
//  SignupViewController.swift
//  TrainApp
//
//  Created by Ashok, Raja Vignesh (Cognizant) on 26/12/2019.
//  Copyright © 2019 Ashok, Raja Vignesh (Cognizant). All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: SigninViewController {
    
    override var submitButtonTitle: String {
        return "Signup"
    }

    override func signin() {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            print(strongSelf)
            if let err = error {
                print(err)
            } else {
                print("success Sign up")
                print(authResult!)
                if let appDelegate = UIApplication.shared.delegate{
                    appDelegate.window??.rootViewController =        UINavigationController(rootViewController: HomeViewController())
                }
            }
        }
    }
}
