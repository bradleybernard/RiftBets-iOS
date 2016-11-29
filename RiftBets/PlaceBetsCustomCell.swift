//
//  PlaceBetsCustomCell.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/21/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation
import UIKit

// Class used to customize the question collectionView cell 
class PlaceBetsCustomCell: UICollectionViewCell{
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var wagerText: UITextField!
    @IBOutlet weak var possibleWin: UILabel!
    var betQuestion : BetQuestion?
    
    // Function returns the wagered amount entered by the user. 
    func getWager() -> Int{
       return Int(wagerText.text!)!
    }
    
    func formatCell(){
        
    }
}
