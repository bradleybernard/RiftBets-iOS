//
//  PlaceBetsViewController.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/21/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation
import UIKit

// Class used to manage the place bets screen
class PlaceBetsViewController: UIViewController {
    
    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var game: UILabel!
    @IBOutlet weak var rerollButton: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    var betQuestions: [BetQuestion] = []
    var matchTitle : String?
    var gameNumber : Int = 0
    var targetTime = NSDate()
    var rerollCount : Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func betPlacePressed(sender: AnyObject) {
        
    }
    // Fucntion cancels the place bets and returns to match details screen 
    @IBAction func cancelPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    // Function if the reroll button is pressed the count will decrease.
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
    // Function sets up the all of the page excluding the collectionView
    func setup() {
        
        if let navTitle = matchTitle {
            print(navTitle)
            self.navBar.topItem!.title = navTitle
        }
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(PlaceBetsViewController.timerUpdate), userInfo: nil, repeats: true)
        let gNum = gameNumber + 1
        game.text = "Game " + String(gNum)
        
        rerollButton.setTitle("Reroll (" + String(rerollCount) + ")", forState: .Normal)
    }
    
    func timerUpdate(){
        var diff : NSTimeInterval = targetTime.timeIntervalSinceNow
        if(diff > 0){
            timerLabel.text = String(diff)
        }
    }
}
// Collection has question and answers cell, depending on what type of question a corresponding answer type is selected and displayed.
extension PlaceBetsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.betQuestions.count * 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if(indexPath.item % 2 == 0) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PlaceBetsCustomCell", forIndexPath: indexPath) as! PlaceBetsCustomCell
            cell.question.text = self.betQuestions[(indexPath.item/2)].description
            return cell
        } else {
            if(indexPath.item - 1 < 0) {
                print("Something is wrong")
            }
            let q = self.betQuestions[(indexPath.item - 1)/2]
            if(q.type == "integer" || q.type == "time_duration" || q.type == "champion_id") {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StandardAnswerCustomCell", forIndexPath: indexPath) as! StandardAnswerCustomCell
                return cell
            } else if(q.type == "team_id") {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TeamAnswersCustomCell", forIndexPath: indexPath) as! TeamAnswersCustomCell
                cell.teamOneLabel.text = "Team 1"
                cell.teamTwoLabel.text = "Team 2"
                return cell
            } else if(q.type == "boolean") {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("YesNoCustomCell", forIndexPath: indexPath) as! YesNoCustomCell
                return cell
            } else if(q.type == "champion_id_list_3") {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BanAnswersCustomCell", forIndexPath: indexPath) as! BanAnswersCustomCell
                return cell
            } else if(q.type == "item_id_list") {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemBuildAnswerCustomCell", forIndexPath: indexPath) as! ItemBuildAnswerCustomCell
                return cell
            } else if(q.type == "champion_id_list_5") {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PicksAnswersCustomCell", forIndexPath: indexPath) as! PicksAnswersCustomCell
                return cell
            } else if(q.type == "summoner_id_list") {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SummonerSkillsAnswerCustomCell", forIndexPath: indexPath) as! SummonerSkillsAnswerCustomCell
                return cell
            }
        }
        
        var ret = collectionView.dequeueReusableCellWithReuseIdentifier("PlaceBetsCustomCell", forIndexPath: indexPath) as! PlaceBetsCustomCell
        ret.question.text = "Not the right type"
        
        return ret
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //print("You selected cell #\(indexPath.item)!")
    }
}
