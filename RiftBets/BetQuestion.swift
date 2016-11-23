//
//  BetQuestion.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/22/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation


struct BetQuestion {
    
    //    "question_id": 2,
    //    "slug": "team_win",
    //    "difficulty": "easy",
    //    "multiplier": "1.00",
    //    "type": "team_id",
    //    "description": "Which team will win?"
    
    var questionId : Int = 0
    var slug : String = ""
    var difficulty : String = ""
    var multiplier : Double = 1.0
    var type : String = ""
    var description : String = ""
    
    init(questionId: String, slug: String, difficulty: String, multiplier: String, type: String, description: String) {
        self.questionId = Int(questionId)!
        self.slug = slug
        self.difficulty = difficulty
        self.multiplier = Double(multiplier)!
        self.type = type
        self.description = description
    }
    
}
