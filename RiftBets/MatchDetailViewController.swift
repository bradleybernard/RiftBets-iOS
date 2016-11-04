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
    
    internal var matchName : String = " "
    var match : ScheduleMatch?
    
    @IBOutlet weak var matchTitle: UILabel!
    
    @IBOutlet weak var team_one_logo: UIImageView!
    @IBOutlet weak var team_two_logo: UIImageView!

    @IBOutlet weak var team_one_stats: UITableView!
    @IBOutlet weak var team_two_stats: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchTitle.text = matchName
    }
    
}