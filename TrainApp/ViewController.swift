//
//  ViewController.swift
//  TrainApp
//
//  Created by Ashok, Raja Vignesh (Cognizant) on 12/12/2019.
//  Copyright © 2019 Ashok, Raja Vignesh (Cognizant). All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class ViewController: UIViewController,GIDSignInDelegate,LoginButtonDelegate {
  
    

    
    
    @IBOutlet weak var fbLoginButton: FBLoginButton!
    
    
    
    
    

    // MARK: Facebook
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            // ...
            print("fb error")
            print(error)
            return
          }
          print("fb success" )
        }

        print("Login FB success")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")

    }
    
    
    //Custom button
    @IBAction func facebookLogin(sender: AnyObject) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            // Perform login by calling Firebase APIs
            
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
            // self.performSegue(withIdentifier: self.signInSegue, sender: nil)
        }
    }
    
    
    
    // MARK: Google sign in

    
    @IBOutlet weak var sigin: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
// commented code button with FB logo
//        let loginButton = FBLoginButton()
//        loginButton.delegate = self
//        loginButton.setTitle("Facebook login", for: .normal)
//        loginButton.center = self.view.center
//        self.view.addSubview(loginButton)
    }
    
    @IBAction func siginGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("=================")
        if let error = error {
            // ...
            print(error)
            return
        }
        print("No error:")
        guard let authentication = user.authentication else { return }
        
    
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        print(credential)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                 print("FAILED")
                 print(error.localizedDescription)
                return
            } else {
                print("Login successfull")
            }
            
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

}


