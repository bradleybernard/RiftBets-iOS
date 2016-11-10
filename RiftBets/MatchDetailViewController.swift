//
//  MatchDetailViewController.swift
//  RiftBets
//
//  Created by Sushil Patel on 10/18/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation
import UIKit

class MatchDetailViewController: UIViewController {
    

    @IBOutlet weak var teamTwoName: UILabel!
    @IBOutlet weak var teamOneName: UILabel!
    var match : ScheduleMatch?
    internal var matchDetails : MatchDetail?
    
    //var teamOneN : String = "didnt fucking work"
    
    @IBOutlet weak var team_one_logo: UIImageView!
    @IBOutlet weak var team_two_logo: UIImageView!

    @IBOutlet weak var team_one_stats: UITableView!
    @IBOutlet weak var team_two_stats: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func formatDetails(matchDetail: MatchDetail){
        //these values are ok for overall match purposes but for individual game not so much
        teamOneName.text = matchDetail.team_One_Name
        teamTwoName.text = matchDetail.team_Two_Name
        
        
    }
    
}