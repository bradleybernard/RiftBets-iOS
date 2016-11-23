//
//  PlaceBetsCustomCell.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/21/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation
import UIKit

class PlaceBetsCustomCell: UICollectionViewCell{
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var wagerText: UITextField!
    @IBOutlet weak var possibleWin: UILabel!
    var betQuestion : BetQuestion?
    
    func getWager() -> Int{
       return Int(wagerText.text!)!
    }
    
    func formatCell(){
        
    }
}
