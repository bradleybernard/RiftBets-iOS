//
//  YesNoCustomCell.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/22/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit

// Class used to customize a yes/no answer collectionView cell

class YesNoCustomCell: UICollectionViewCell {
    
    
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var noButton: UIButton!
    
    var yes: Bool = false
    var no: Bool = false
    
    @IBAction func yesPressed(sender: AnyObject) {
        yesButton.backgroundColor = UIColor.blueColor()
        yes = true
    }
    

    @IBAction func noPressed(sender: AnyObject) {
        noButton.backgroundColor = UIColor.blueColor()
        no = true
    }
    
    func getAnswers()->String{
        if(yes){
            return "yes"
        }
        if(no){
            return "no"
        }
        else{
            return "error"
        }
        
    }
    
}
