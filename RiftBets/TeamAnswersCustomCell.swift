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
    
    var teamOnePressed : Bool = false
    var teamTwoPressed : Bool = false
    
    @IBAction func teamOneChecked(sender: AnyObject) {
        teamOneCheckBox.backgroundColor = UIColor.blueColor()
        teamOnePressed = true
        
    }
    
    @IBAction func teamTwoChecked(sender: AnyObject) {
        teamTwoCheckBox.backgroundColor = UIColor.blueColor()
        teamTwoPressed = true
        
    }
    
    func getAnswer()->String{
        if(teamOnePressed){
            return "100"
        }
        if(teamTwoPressed){
            return "200"
        }
        else{
            return "error"
        }
    }
    
    
    
}
