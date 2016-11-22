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
    
    
    //overall match stats
    @IBOutlet weak var teamTwoName: UILabel!
    @IBOutlet weak var teamOneName: UILabel!
    //@IBOutlet weak var score_One: UILabel!
    //@IBOutlet weak var score_Two: UILabel!
    //@IBOutlet weak var teamOneLogo: UIImageView!
    //@IBOutlet weak var teamTwoLogo: UIImageView!
    
    //picks and bans vars
    //@IBOutlet weak var pBTeamTwo: UILabel!
    //@IBOutlet weak var pBTeamOne: UILabel!
    @IBOutlet weak var teamOneBanOne: UIImageView!
    @IBOutlet weak var teamOneBanTwo: UIImageView!
    @IBOutlet weak var teamOneBanThree: UIImageView!
    @IBOutlet weak var teamTwoBanOne: UIImageView!
    @IBOutlet weak var teamTwoBanTwo: UIImageView!
    @IBOutlet weak var teamTwoBanThree: UIImageView!
    
    //match stats vars -done
    //@IBOutlet weak var mSTeamOne: UILabel!
    //@IBOutlet weak var mSTeamTwo: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.formatDetails()
    }
    
    func updateGameNumber(number: Int) {
        gameNumber = number
        self.formatDetails()
    }
    
    func formatDetails() {
        
        guard teamOneName != nil else {
           return
        }

        teamOneName.text = matchDetails!.team_One_Name!
        teamTwoName.text = matchDetails!.team_Two_Name!
        
        if let t1drag : Int = matchDetails?.gameDetail[gameNumber].teamOne?.dragon_Kills {
            teamOneDragons.text = String(t1drag)
        }
        if let t2drag : Int = matchDetails?.gameDetail[gameNumber].teamTwo?.dragon_Kills {
            teamTwoDragons.text = String(t2drag)
        }
        if let t1tower : Int = matchDetails?.gameDetail[gameNumber].teamOne?.tower_Kills {
            teamOneTowers.text = String(t1tower)
        }
        if let t2tower : Int = matchDetails?.gameDetail[gameNumber].teamTwo?.tower_Kills {
            teamTwoTowers.text = String(t2tower)
        }
        if let t1barons : Int = matchDetails?.gameDetail[gameNumber].teamOne?.baron_Kills {
            teamOneBaron.text = String(t1barons)
        }
        if let t2barons : Int = matchDetails?.gameDetail[gameNumber].teamTwo?.baron_Kills {
            teamTwoBaron.text = String(t2barons)
        }
        
        var team1Kills : Int = 0
        var team2Kills : Int = 0
        var team1Gold : Int = 0
        var team2Gold : Int = 0
        
        for index in 0...4 {
            team1Kills = team1Kills + (matchDetails?.gameDetail[gameNumber].teamOne?.players[index].kills)!
            team1Gold = team1Gold + (matchDetails?.gameDetail[gameNumber].teamOne?.players[index].gold_Earned)!
            team2Kills = team2Kills + (matchDetails?.gameDetail[gameNumber].teamTwo?.players[index].kills)!
            team2Gold = team2Gold + (matchDetails?.gameDetail[gameNumber].teamTwo?.players[index].gold_Earned)!
        }
        
        teamOneGold.text = String(team1Gold)
        teamOneKills.text = String(team1Kills)
        teamTwoKills.text = String(team2Kills)
        teamTwoGold.text = String(team2Gold)
        
        let teamOneBan_1Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamOne?.ban_1)!)
        let teamOneBan_2Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamOne?.ban_2)!)
        let teamOneBan_3Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamOne?.ban_3)!)
        let teamTwoBan_1Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamTwo?.ban_1)!)
        let teamTwoBan_2Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamTwo?.ban_2)!)
        let teamTwoBan_3Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamTwo?.ban_3)!)
        
        teamOneBanOne.af_setImageWithURL(teamOneBan_1Url!)
        teamOneBanTwo.af_setImageWithURL(teamOneBan_2Url!)
        teamOneBanThree.af_setImageWithURL(teamOneBan_3Url!)
        teamTwoBanOne.af_setImageWithURL(teamTwoBan_1Url!)
        teamTwoBanTwo.af_setImageWithURL(teamTwoBan_2Url!)
        teamTwoBanThree.af_setImageWithURL(teamTwoBan_3Url!)
    }
    
}
