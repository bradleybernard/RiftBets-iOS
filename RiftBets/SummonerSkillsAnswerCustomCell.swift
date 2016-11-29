//
//  SummonerSkillsAnswerCustomCell.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/22/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation

// Class used to customize a two answer collectioView cell
class SummonerSkillsAnswerCustomCell: UICollectionViewCell{
    
    
    @IBOutlet weak var summonerSkill1Answer: UITextField!
    
    
    @IBOutlet weak var summonerSkill2Answer: UITextField!
    
    // Fucntion returns the summoner skills the user entered.
    func getAnswer()->String{
        return summonerSkill1Answer.text! + "," + summonerSkill2Answer.text!
    }

    
}
