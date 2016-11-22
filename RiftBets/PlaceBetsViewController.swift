//
//  PlaceBetsViewController.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/21/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation
import UIKit

class PlaceBetsViewController: UIViewController{
    
    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var game: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var matchTitle : String?
    var gameNumber : Int = 0
    
    @IBAction func cancelPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navTitle = matchTitle {
            self.navigationItem.title = navTitle
        }
        
        game.text = "Game " + String(gameNumber)
    }
}
