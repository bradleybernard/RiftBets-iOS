//
//  ItemBuildAnswerCustomCell.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/22/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation

class ItemBuildAnswerCustomCell: UICollectionViewCell{
    
    
    @IBOutlet weak var item1Answer: UITextField!
    
    @IBOutlet weak var item2Answer: UITextField!
    
    @IBOutlet weak var item3Answer: UITextField!
    
    @IBOutlet weak var item4Answer: UITextField!
    
    @IBOutlet weak var item5Answer: UITextField!
    
    @IBOutlet weak var item6Answer: UITextField!
    
    
    func getAnswer()->String{
        return item1Answer.text! + "," + item2Answer.text! + "," + item3Answer.text! + "," + item4Answer.text! + "," + item5Answer.text! + "," + item6Answer.text!
    }
    
}
