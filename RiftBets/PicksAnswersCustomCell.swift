//
//  PicksAnswersCustomCell.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/22/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit

// Class used to customize the picks answer collectionView cell

class PicksAnswersCustomCell: UICollectionViewCell {
    
    
    @IBOutlet weak var topPick: UITextField!
    
    @IBOutlet weak var junglePick: UITextField!
    
    @IBOutlet weak var midPick: UITextField!
    
    @IBOutlet weak var adcPick: UITextField!
    
    @IBOutlet weak var supportPick: UITextField!
    
    func getAnswer()->String{
        return topPick.text! + ",'" + junglePick.text! + "," + midPick.text! + "," + adcPick.text! + "," + supportPick.text!
    }
    
}
