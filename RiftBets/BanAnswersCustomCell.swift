//
//  BanAnswersCustomCell.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/22/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit

// Class used to customize the bans answer collectioView cell

class BanAnswersCustomCell: UICollectionViewCell {
    
    
    @IBOutlet weak var banOne: UITextField!
    
    @IBOutlet weak var banTwo: UITextField!
    
    @IBOutlet weak var banThree: UITextField!
    
    func getAnswer()->String{
        return banOne.text! + "," + banTwo.text! + "," + banThree.text!
    }

    
}
