//
//  FirstViewController.swift
//  RiftBets
//
//  Created by Brad Bernard on 10/8/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
    }
}

extension HomeViewController: FBSDKLoginButtonDelegate {

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if error != nil || result.isCancelled {
            print("ERROR"); return
        }
        
        guard result.token != nil else {
            print("Error"); return
        }
        
        KeychainManager.sharedInstance.setFacebookToken(result.token.tokenString!)
        RemoteManager.sharedInstance.facebook({ (json, error) in
            if error != nil {
                print("Errror")
            }
        })
        
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
}