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


class ViewController: UIViewController,GIDSignInDelegate {
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
        print("credential")
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

    
    @IBOutlet weak var sigin: GIDSignInButton!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    
    @IBAction func siginGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
    }
    



}


