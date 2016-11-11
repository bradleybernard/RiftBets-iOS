//
//  MatchDateCustomCell.swift
//  RiftBets
//
//  Created by Sushil Patel on 10/23/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation
import UIKit

class MatchDateCustomCell: UITableViewCell {
    
    @IBOutlet weak var team_two_score: UILabel!
    @IBOutlet weak var team_one_score: UILabel!
    
    @IBOutlet weak var matchName: UILabel!
    @IBOutlet weak var matchDate: UILabel!
   
    
    @IBOutlet weak var team_one_short: UILabel!
    @IBOutlet weak var team_two_short: UILabel!
    
    @IBOutlet weak var team_one_logo: UIImageView!
    @IBOutlet weak var team_two_logo: UIImageView!
    
    func formatCell(match_schedule: ScheduleMatch) {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .NoStyle
        formatter.timeStyle = .ShortStyle
        
        matchDate.text = formatter.stringFromDate(match_schedule.date!)
        
        
        if(match_schedule.match_Best_Of > 1) {
            if let best_of = match_schedule.match_Best_Of{
                matchName.text = "Best of " + String(best_of)
            }
            
        }
        
        team_one_short.text = match_schedule.team_One_Acronym
        team_two_short.text = match_schedule.team_Two_Acronym
        
        if(match_schedule.state == "resolved"){
            if let score = match_schedule.score_One{
                let score2 = match_schedule.score_Two
                if(score > score2){
                    team_one_score.text = "Victory"
                    team_two_score.text = "Defeat"
                }else if(score < score2){
                    team_one_score.text = "Defeat"
                    team_two_score.text = "Victory"
                }
            }
        }
        
        let team_one_url = NSURL(string: match_schedule.team_One_Logo_Url!)
        let team_two_url = NSURL(string: match_schedule.team_Two_Logo_Url!)
        
        team_one_logo.af_setImageWithURL(team_one_url!)
        team_two_logo.af_setImageWithURL(team_two_url!)
    }
    
}