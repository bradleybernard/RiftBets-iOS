//
//  QuestionAnswer.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/22/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation

struct QuestionAnswer{
    var answer : String = ""
    var wager : Int = 0
    
    init(answer: String, wager: Int){
        self.answer = answer
        self.wager = wager
    }
}
