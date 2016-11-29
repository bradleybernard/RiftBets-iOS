//
//  PlayerStatsViewController.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/15/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation

// Class  used to manage the player stats per game
class PlayerStatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var matchDetails: MatchDetail?
    var gameNumber: Int = 0
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateGameNumber(number: Int) {
        gameNumber = number
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchDetails!.gameDetail[0].teamOne!.players.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : PlayerStatsCustomCell = tableView.dequeueReusableCellWithIdentifier("PlayerStatsCustomCell") as! PlayerStatsCustomCell
    
        if let t1player : Players = matchDetails?.gameDetail[gameNumber].teamOne?.players[indexPath.item] {
        
            cell.teamOnePlayerName.text = t1player.summoner_Name
            cell.teamOnePlayerCS.text = String(t1player.minions_Killed!)
            
            if let kills : Int = t1player.kills {
                if let deaths : Int = t1player.deaths {
                    if let assists : Int = t1player.assists {
                        cell.teamOnePlayerKills.text = String(kills) + "/" + String(deaths) + "/" + String(assists)
                    }
                }
            }
            
            let champUrl = NSURL(string: t1player.champion_Id!)
            cell.teamOnePlayerChamp.af_setImageWithURL(champUrl!)
            
            if(t1player.item_1 != nil) {
                let item1Url = NSURL(string: t1player.item_1!)
                cell.teamOnePlayerItem1.af_setImageWithURL(item1Url!)
            }
            if(t1player.item_2 != nil) {
                let item2Url = NSURL(string: t1player.item_2!)
                cell.teamOnePlayerItem2.af_setImageWithURL(item2Url!)
            }
            if(t1player.item_3 != nil) {
                let item3Url = NSURL(string: t1player.item_3!)
                cell.teamOnePlayerItem3.af_setImageWithURL(item3Url!)
            }
            if(t1player.item_4 != nil) {
                let item4Url = NSURL(string: t1player.item_4!)
                cell.teamOnePlayerItem4.af_setImageWithURL(item4Url!)
            }
            if(t1player.item_5 != nil) {
                let item5Url = NSURL(string: t1player.item_5!)
                cell.teamOnePlayerItem5.af_setImageWithURL(item5Url!)
            }
            if(t1player.item_6 != nil) {
                let item6Url = NSURL(string: t1player.item_6!)
                cell.teamOnePlayerItem6.af_setImageWithURL(item6Url!)
            }
            
            let teamOneSS1Url = NSURL(string: t1player.spell1_Id!)
            let teamOneSS2Url = NSURL(string: t1player.spell2_Id!)
            
            cell.teamOnePlayerSS1.af_setImageWithURL(teamOneSS1Url!)
            cell.teamOnePlayerSS2.af_setImageWithURL(teamOneSS2Url!)
        }
        
        if let t2player : Players = matchDetails?.gameDetail[gameNumber].teamTwo?.players[indexPath.item] {
            
            cell.teamTwoPlayerName.text = t2player.summoner_Name
            cell.teamTwoPlayerCS.text = String(t2player.minions_Killed!)
            
            if let kills : Int = t2player.kills {
                if let deaths : Int = t2player.deaths {
                    if let assists : Int = t2player.assists {
                        cell.teamTwoPlayerKills.text = String(kills) + "/" + String(deaths) + "/" + String(assists)
                    }
                }
            }
            
            let champUrl = NSURL(string: t2player.champion_Id!)
            cell.teamTwoPlayerChamp.af_setImageWithURL(champUrl!)
            
            if(t2player.item_1 != nil) {
                let item1Url = NSURL(string: t2player.item_1!)
                cell.teamTwoPlayerItem1.af_setImageWithURL(item1Url!)
            }
            if(t2player.item_2 != nil) {
                let item2Url = NSURL(string: t2player.item_2!)
                cell.teamTwoPlayerItem2.af_setImageWithURL(item2Url!)
            }
            if(t2player.item_3 != nil) {
                let item3Url = NSURL(string: t2player.item_3!)
                cell.teamTwoPlayerItem3.af_setImageWithURL(item3Url!)
            }
            if(t2player.item_4 != nil) {
                let item4Url = NSURL(string: t2player.item_4!)
                cell.teamTwoPlayerItem4.af_setImageWithURL(item4Url!)
            }
            if(t2player.item_5 != nil) {
                let item5Url = NSURL(string: t2player.item_5!)
                cell.teamTwoPlayerItem5.af_setImageWithURL(item5Url!)
            }
            if(t2player.item_6 != nil) {
                let item6Url = NSURL(string: t2player.item_6!)
                cell.teamTwoPlayerItem6.af_setImageWithURL(item6Url!)
            }
            
            let teamTwoSS1Url = NSURL(string: t2player.spell1_Id!)
            let teamTwoSS2Url = NSURL(string: t2player.spell2_Id!)
            
            cell.teamTwoPlayerSS1.af_setImageWithURL(teamTwoSS1Url!)
            cell.teamTwoPlayerSS2.af_setImageWithURL(teamTwoSS2Url!)
        }
        
        return cell
   }
}
