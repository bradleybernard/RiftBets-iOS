//
//  StandardAnswerCustomCell.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/22/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation

// Class used to customize a single answer collectionView cell
class StandardAnswerCustomCell : UICollectionViewCell{
    
    
    @IBOutlet weak var answerText: UITextField!
    
    func getAnswer()->String{
        return answerText.text!
    }
}
