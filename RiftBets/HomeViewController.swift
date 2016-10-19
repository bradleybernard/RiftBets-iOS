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

    @IBOutlet weak var matchLabel: UILabel!
    
    @IBAction func testButtonPressed(sender: AnyObject) {
        print(KeychainManager.sharedInstance.getLoggedIn())
        print(KeychainManager.sharedInstance.getToken())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func getData() {
        RemoteManager.sharedInstance.matchSchedule({ (json, error) -> Void in
            
            var matches = [ScheduleMatch]()
            
            for (key, subJson) : (String, JSON) in json {
                for (keyT, subJsonT) : (String, JSON) in subJson {
                    guard let name = subJsonT["name"].string else {
                        continue
                    }
                    
                    matches.append(ScheduleMatch(name: name))
                }
            }
            
            self.matchLabel.text = matches.last?.name
            
        })
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
     //   print("I can also switch here")
        
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
            
            (UIApplication.sharedApplication().delegate as! AppDelegate).mainTabbar()

        })
        
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
}