//
//  MatchDetailViewController.swift
//  RiftBets
//
//  Created by Sushil Patel on 10/18/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation
import UIKit

class MatchDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let itemURL : String = "http://ddragon.leagueoflegends.com/cdn/6.21.1/img/item/"
    let championURL : String = "http://ddragon.leagueoflegends.com/cdn/6.21.1/img/champion/"
    let summonerspellURL : String = "http://ddragon.leagueoflegends.com/cdn/6.21.1/img/spell/"
    
    //overall match stats
    @IBOutlet weak var teamTwoName: UILabel!
    @IBOutlet weak var teamOneName: UILabel!
    @IBOutlet weak var score_One: UILabel!
    @IBOutlet weak var score_Two: UILabel!
    @IBOutlet weak var teamOneLogo: UIImageView!
    @IBOutlet weak var teamTwoLogo: UIImageView!
    
    var match : ScheduleMatch?
    
    internal var matchDetails : MatchDetail?
    
    
    //picks and bans vars
    @IBOutlet weak var pBTeamTwo: UILabel!
    @IBOutlet weak var pBTeamOne: UILabel!
    @IBOutlet weak var teamOneBanOne: UIImageView!
    @IBOutlet weak var teamOneBanTwo: UIImageView!
    @IBOutlet weak var teamOneBanThree: UIImageView!
    @IBOutlet weak var teamTwoBanOne: UIImageView!
    @IBOutlet weak var teamTwoBanTwo: UIImageView!
    @IBOutlet weak var teamTwoBanThree: UIImageView!

    
    //match stats vars -done
    
    @IBOutlet weak var mSTeamOne: UILabel!
    @IBOutlet weak var mSTeamTwo: UILabel!
    @IBOutlet weak var teamOneKills: UILabel!
    @IBOutlet weak var teamTwoKills: UILabel!
    @IBOutlet weak var teamOneGold: UILabel!
    @IBOutlet weak var teamTwoGold: UILabel!
    @IBOutlet weak var teamOneDragons: UILabel!
    @IBOutlet weak var teamTwoDragons: UILabel!
    @IBOutlet weak var teamOneBaron: UILabel!
    @IBOutlet weak var teamTwoBaron: UILabel!
    @IBOutlet weak var teamOneTowers: UILabel!
    @IBOutlet weak var teamTwoTowers: UILabel!

    
    //player stats
    @IBOutlet weak var player_stats: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //formats page for game_one haven't figured out the switch bar at the top
    func formatDetails(matchDetail: MatchDetail){
        matchDetails = matchDetail
        self.player_stats.reloadData()
        //overall
        teamOneName.text = matchDetail.team_One_Name
        teamTwoName.text = matchDetail.team_Two_Name
        if let scoreOne : Int = matchDetail.score_One{
            score_One.text = String(scoreOne)
        }
        if let scoreTwo : Int = matchDetail.score_Two{
            score_Two.text = String(scoreTwo)
        }
        let teamOneUrl = NSURL(string: matchDetail.team_One_Logo_Url!)
        let teamTwoUrl = NSURL(string: matchDetail.team_Two_Logo_Url!)
        teamOneLogo.af_setImageWithURL(teamOneUrl!)
        teamTwoLogo.af_setImageWithURL(teamTwoUrl!)
        
        //picks and bans
        pBTeamOne.text = matchDetail.team_One_Acronym
        pBTeamTwo.text = matchDetail.team_Two_Acronym
        
        //match stats
        mSTeamOne.text = matchDetail.team_One_Acronym
        mSTeamTwo.text = matchDetail.team_Two_Acronym
        if let t1drag : Int = matchDetail.gameDetail[0].teamOne?.dragon_Kills{
            teamOneDragons.text = String(t1drag)
        }
        if let t2drag : Int = matchDetail.gameDetail[0].teamTwo?.dragon_Kills{
            teamTwoDragons.text = String(t2drag)
        }
        if let t1tower : Int = matchDetail.gameDetail[0].teamOne?.tower_Kills{
            teamOneTowers.text = String(t1tower)
        }
        if let t2tower : Int = matchDetail.gameDetail[0].teamTwo?.tower_Kills{
            teamTwoTowers.text = String(t2tower)
        }
        if let t1barons : Int = matchDetail.gameDetail[0].teamOne?.baron_Kills{
            teamOneBaron.text = String(t1barons)
        }
        if let t2barons : Int = matchDetail.gameDetail[0].teamTwo?.baron_Kills{
            teamTwoBaron.text = String(t2barons)
        }
        var team1Kills : Int = 0
        var team2Kills : Int = 0
        var team1Gold : Int = 0
        var team2Gold : Int = 0
 
        for index in 0...4{
            team1Kills = team1Kills + (matchDetail.gameDetail[0].teamOne?.players[index].kills)!
            team1Gold = team1Gold + (matchDetail.gameDetail[0].teamOne?.players[index].gold_Earned)!
            team2Kills = team2Kills + (matchDetail.gameDetail[0].teamTwo?.players[index].kills)!
            team2Gold = team2Gold + (matchDetail.gameDetail[0].teamTwo?.players[index].gold_Earned)!

        }
        teamOneGold.text = String(team1Gold)
        teamOneKills.text = String(team1Kills)
        teamTwoKills.text = String(team2Kills)
        teamTwoGold.text = String(team2Gold)
        
        let teamOneBan_1Url = NSURL(string: (matchDetail.gameDetail[0].teamOne?.ban_1)!)
        let teamOneBan_2Url = NSURL(string: (matchDetail.gameDetail[0].teamOne?.ban_2)!)
        let teamOneBan_3Url = NSURL(string: (matchDetail.gameDetail[0].teamOne?.ban_3)!)
        let teamTwoBan_1Url = NSURL(string: (matchDetail.gameDetail[0].teamTwo?.ban_1)!)
        let teamTwoBan_2Url = NSURL(string: (matchDetail.gameDetail[0].teamTwo?.ban_2)!)
        let teamTwoBan_3Url = NSURL(string: (matchDetail.gameDetail[0].teamTwo?.ban_3)!)
        teamOneBanOne.af_setImageWithURL(teamOneBan_1Url!)
        teamOneBanTwo.af_setImageWithURL(teamOneBan_2Url!)
        teamOneBanThree.af_setImageWithURL(teamOneBan_3Url!)
        teamTwoBanOne.af_setImageWithURL(teamTwoBan_1Url!)
        teamTwoBanTwo.af_setImageWithURL(teamTwoBan_2Url!)
        teamTwoBanThree.af_setImageWithURL(teamTwoBan_3Url!)
        

        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : PlayerStatsCustomCell = tableView.dequeueReusableCellWithIdentifier("PlayerStatsCustomCell") as! PlayerStatsCustomCell
        if let t1player : Players = matchDetails?.gameDetail[0].teamOne?.players[indexPath.item]{
            cell.teamOnePlayerName.text = t1player.summoner_Name
            if let kills : Int = t1player.kills{
                if let deaths : Int = t1player.deaths{
                    if let assists : Int = t1player.assists{
                        cell.teamOnePlayerKills.text = String(kills) + "/" + String(deaths) + "/" + String(assists)
                    }
                }
            }
          
           
            let champUrl = NSURL(string: t1player.champion_Id!)
            cell.teamOnePlayerChamp.af_setImageWithURL(champUrl!)
            
            if(t1player.item_1 != nil){
                let item1Url = NSURL(string: t1player.item_1!)
                cell.teamOnePlayerItem1.af_setImageWithURL(item1Url!)
            }
            if(t1player.item_2 != nil){
                let item2Url = NSURL(string: t1player.item_2!)
                cell.teamOnePlayerItem2.af_setImageWithURL(item2Url!)
            }
            if(t1player.item_3 != nil){
                let item3Url = NSURL(string: t1player.item_3!)
                cell.teamOnePlayerItem3.af_setImageWithURL(item3Url!)
            }
            if(t1player.item_4 != nil){
                let item4Url = NSURL(string: t1player.item_4!)
                cell.teamOnePlayerItem4.af_setImageWithURL(item4Url!)
            }
            if(t1player.item_5 != nil){
                let item5Url = NSURL(string: t1player.item_5!)
                cell.teamOnePlayerItem5.af_setImageWithURL(item5Url!)
            }
            if(t1player.item_6 != nil){
                let item6Url = NSURL(string: t1player.item_6!)
                cell.teamOnePlayerItem6.af_setImageWithURL(item6Url!)
            }
            let teamOneSS1Url = NSURL(string: t1player.spell1_Id!)
            let teamOneSS2Url = NSURL(string: t1player.spell2_Id!)
            cell.teamOnePlayerSS1.af_setImageWithURL(teamOneSS1Url!)
            cell.teamOnePlayerSS2.af_setImageWithURL(teamOneSS2Url!)
        }
        
        if let t2player : Players = matchDetails?.gameDetail[0].teamTwo?.players[indexPath.item]{
            cell.teamTwoPlayerName.text = t2player.summoner_Name
            if let kills : Int = t2player.kills{
                if let deaths : Int = t2player.deaths{
                    if let assists : Int = t2player.assists{
                        cell.teamTwoPlayerKills.text = String(kills) + "/" + String(deaths) + "/" + String(assists)
                    }
                }
            }
            let champUrl = NSURL(string: t2player.champion_Id!)
            cell.teamTwoPlayerChamp.af_setImageWithURL(champUrl!)
            
            if(t2player.item_1 != nil){
                let item1Url = NSURL(string: t2player.item_1!)
                cell.teamTwoPlayerItem1.af_setImageWithURL(item1Url!)
            }
            if(t2player.item_2 != nil){
                let item2Url = NSURL(string: t2player.item_2!)
                cell.teamTwoPlayerItem2.af_setImageWithURL(item2Url!)
            }
            if(t2player.item_3 != nil){
                let item3Url = NSURL(string: t2player.item_3!)
                cell.teamTwoPlayerItem3.af_setImageWithURL(item3Url!)
            }
            if(t2player.item_4 != nil){
                let item4Url = NSURL(string: t2player.item_4!)
                cell.teamTwoPlayerItem4.af_setImageWithURL(item4Url!)
            }
            if(t2player.item_5 != nil){
                let item5Url = NSURL(string: t2player.item_5!)
                cell.teamTwoPlayerItem5.af_setImageWithURL(item5Url!)
            }
            if(t2player.item_6 != nil){
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