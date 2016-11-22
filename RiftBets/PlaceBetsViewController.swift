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

    @IBOutlet weak var timerLabel: UILabel!
    
    var matchTitle : String?
    var gameNumber : Int = 0
    //var targetTime = NSDate()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navTitle = matchTitle {
            self.navigationItem.title = navTitle
        }
       // var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(PlaceBetsViewController.timerUpdate), userInfo: nil, repeats: true)
        
        game.text = "Game " + String(gameNumber)
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func timerUpdate(){
      //  var diff : NSTimeInterval = targetTime.timeIntervalSinceNow
       // if(diff > 0){
       //     timerLabel.text = String(diff)
        //}
    }
    

}
