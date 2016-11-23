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

    @IBOutlet weak var rerollButton: UIButton!
    
    @IBOutlet weak var navBar: UINavigationBar!

    @IBOutlet weak var timerLabel: UILabel!
    
    var matchTitle : String?
    var gameNumber : Int = 0
    var targetTime = NSDate()
    var rerollCount : Int = 3
    
    @IBAction func betPlacePressed(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navTitle = matchTitle {
            print(navTitle)
            self.navBar.topItem!.title = navTitle
        }
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(PlaceBetsViewController.timerUpdate), userInfo: nil, repeats: true)
        let gNum = gameNumber + 1
        game.text = "Game " + String(gNum)
        
        rerollButton.setTitle("Reroll (" + String(rerollCount) + ")", forState: .Normal)
        
        
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
        @IBAction func rerollPressed(sender: AnyObject) {
            if(rerollCount>0){
                rerollCount -= 1
                sender.setTitle("Reroll (" + String(rerollCount) + ")", forState: .Normal)
                //send new request
            }
            if(rerollCount == 0 ){
                rerollButton.userInteractionEnabled = false
            }
    }
    func timerUpdate(){
        var diff : NSTimeInterval = targetTime.timeIntervalSinceNow
        if(diff > 0){
            timerLabel.text = String(diff)
        }
    }
    

}
