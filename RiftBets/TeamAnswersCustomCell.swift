//
//  TeamAnswersCustomCell.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/22/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation


class TeamAnswersCustomCell : UICollectionViewCell{
    
    @IBOutlet weak var teamOneCheckBox: UIButton!
    
    @IBOutlet weak var teamOneLabel: UILabel!
    
    @IBOutlet weak var teamTwoCheckBox: UIButton!
    
    @IBOutlet weak var teamTwoLabel: UILabel!
    
    @IBAction func teamOneChecked(sender: AnyObject) {
        teamOneCheckBox.backgroundColor = UIColor.blueColor()
        
    }
    
    @IBAction func teamTwoChecked(sender: AnyObject) {
        teamTwoCheckBox.backgroundColor = UIColor.blueColor()
        
    }
    
    
    
    
}
