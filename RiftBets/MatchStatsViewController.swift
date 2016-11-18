//
//  MatchStatsViewController.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/15/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation


class MatchStatsViewController: UIViewController{
    
    var matchDetails : MatchDetail?
    var gameNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.formatDetails()
    }
    
    func updateGameNumber(number: Int) {
        gameNumber = number
        self.formatDetails()
    }
    
    func formatDetails() {
        
//        teamOneName.text = matchDetails?.team_One_Name
//        teamTwoName.text = matchDetails?.team_Two_Name
//        
//        if let scoreOne : Int = matchDetails?.score_One {
//            score_One.text = String(scoreOne)
//        }
//        
//        if let scoreTwo : Int = matchDetails?.score_Two {
//            score_Two.text = String(scoreTwo)
//        }
//        
//        let teamOneUrl = NSURL(string: (matchDetails?.team_One_Logo_Url!)!)
//        let teamTwoUrl = NSURL(string: (matchDetails?.team_Two_Logo_Url!)!)
//        
//        teamOneLogo.af_setImageWithURL(teamOneUrl!)
//        teamTwoLogo.af_setImageWithURL(teamTwoUrl!)
//        
//        //picks and bans
//        pBTeamOne.text = matchDetails?.team_One_Acronym
//        pBTeamTwo.text = matchDetails?.team_Two_Acronym
//        
//        //match stats
//        mSTeamOne.text = matchDetails?.team_One_Acronym
//        mSTeamTwo.text = matchDetails?.team_Two_Acronym
//        
//        if let t1drag : Int = matchDetails?.gameDetail[gameNumber].teamOne?.dragon_Kills {
//            teamOneDragons.text = String(t1drag)
//        }
//        if let t2drag : Int = matchDetails?.gameDetail[gameNumber].teamTwo?.dragon_Kills {
//            teamTwoDragons.text = String(t2drag)
//        }
//        if let t1tower : Int = matchDetails?.gameDetail[gameNumber].teamOne?.tower_Kills {
//            teamOneTowers.text = String(t1tower)
//        }
//        if let t2tower : Int = matchDetails?.gameDetail[gameNumber].teamTwo?.tower_Kills {
//            teamTwoTowers.text = String(t2tower)
//        }
//        if let t1barons : Int = matchDetails?.gameDetail[gameNumber].teamOne?.baron_Kills {
//            teamOneBaron.text = String(t1barons)
//        }
//        if let t2barons : Int = matchDetails?.gameDetail[gameNumber].teamTwo?.baron_Kills {
//            teamTwoBaron.text = String(t2barons)
//        }
//        
//        var team1Kills : Int = 0
//        var team2Kills : Int = 0
//        var team1Gold : Int = 0
//        var team2Gold : Int = 0
//        
//        for index in 0...4 {
//            team1Kills = team1Kills + (matchDetails?.gameDetail[gameNumber].teamOne?.players[index].kills)!
//            team1Gold = team1Gold + (matchDetails?.gameDetail[gameNumber].teamOne?.players[index].gold_Earned)!
//            team2Kills = team2Kills + (matchDetails?.gameDetail[gameNumber].teamTwo?.players[index].kills)!
//            team2Gold = team2Gold + (matchDetails?.gameDetail[gameNumber].teamTwo?.players[index].gold_Earned)!
//        }
//        
//        teamOneGold.text = String(team1Gold)
//        teamOneKills.text = String(team1Kills)
//        teamTwoKills.text = String(team2Kills)
//        teamTwoGold.text = String(team2Gold)
//        
//        let teamOneBan_1Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamOne?.ban_1)!)
//        let teamOneBan_2Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamOne?.ban_2)!)
//        let teamOneBan_3Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamOne?.ban_3)!)
//        let teamTwoBan_1Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamTwo?.ban_1)!)
//        let teamTwoBan_2Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamTwo?.ban_2)!)
//        let teamTwoBan_3Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamTwo?.ban_3)!)
//        
//        teamOneBanOne.af_setImageWithURL(teamOneBan_1Url!)
//        teamOneBanTwo.af_setImageWithURL(teamOneBan_2Url!)
//        teamOneBanThree.af_setImageWithURL(teamOneBan_3Url!)
//        teamTwoBanOne.af_setImageWithURL(teamTwoBan_1Url!)
//        teamTwoBanTwo.af_setImageWithURL(teamTwoBan_2Url!)
//        teamTwoBanThree.af_setImageWithURL(teamTwoBan_3Url!)
    }
    
}
