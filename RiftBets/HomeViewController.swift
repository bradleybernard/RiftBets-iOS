//
//  FirstViewController.swift
//  RiftBets
//
//  Created by Brad Bernard on 10/8/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftyJSON

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
       
        // User logged into Facebook
        
        if error != nil || result.isCancelled {
            print(error); return
        }
        
        guard result.token != nil else {
            print("Error: Facebook token nil"); return
        }
        
        KeychainManager.sharedInstance.setFacebookToken(result.token.tokenString!)
        
        RemoteManager.sharedInstance.facebook({ (json, error) in
            
            if error != nil {
                print(error); return
            }
            
            (UIApplication.sharedApplication().delegate as! AppDelegate).mainTabbar()

        })
        
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        // User logged out of Facebook
    }
}
