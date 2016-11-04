//
//  ScheduleMatch.swift
//  RiftBets
//
//  Created by Sushil Patel on 10/18/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation

struct ScheduleMatch {
    var name                    : String? 
    var date                    : NSDate?
    var state                   : String? 
    var block_Prefix            : String? 
    var block_Label             : String? 
    var sub_Block_Prefix        : String? 
    var sub_Block_Label         : String? 
    var api_Resource_Id_One     : String? 
    var api_Resource_Id_Two     : String? 
    var resource_Type           : String?
    var score_One               : Int?
    var score_Two               : Int?
    var match_Identifier        : String?
    var match_Best_Of           : Int?
    var api_Id_Long             : String?
    var team_One_Api_Id_Long    : String?
    var team_One_Name           : String? 
    var team_One_Team_Photo_Url : String? 
    var team_One_Logo_Url       : String? 
    var team_One_Acronym        : String? 
    var team_One_Alt_Logo_Url   : String? 
    var team_One_Slug           : String? 
    var team_Two_Api_Id_Long    : String?
    var team_Two_Name           : String? 
    var team_Two_Team_Photo_Url : String? 
    var team_Two_Logo_Url       : String? 
    var team_Two_Acronym        : String?
    var team_Two_Alt_Logo_Url   : String?
    var team_Two_Slug           : String?
    
    init(name: String,
         date: String,
         state: String,
         block_Prefix: String,
         block_Label: String,
         sub_Block_Prefix: String,
         sub_Block_Label: String,
         api_Resource_Id_One: String,
         api_Resource_Id_Two: String,
         resource_Type: String,
         score_One: Int,
         score_Two: Int,
         match_Identifier: String,
         match_Best_Of: Int,
         api_Id_Long: String,
         team_One_Api_Id_Long: String,
         team_One_Name: String,
         team_One_Team_Photo_Url: String,
         team_One_Logo_Url: String,
         team_One_Acronym: String,
         team_One_Alt_Logo_Url: String,
         team_One_Slug: String,
         team_Two_Api_Id_Long: String,
         team_Two_Name: String,
         team_Two_Team_Photo_Url: String,
         team_Two_Logo_Url: String,
         team_Two_Acronym: String,
         team_Two_Alt_Logo_Url: String,
         team_Two_Slug: String
    )
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.name                       = name
        self.date                       = dateFormatter.dateFromString(date)
        self.state                      = state
        self.block_Prefix               = block_Prefix
        self.block_Label                = block_Label
        self.sub_Block_Prefix           = sub_Block_Prefix
        self.sub_Block_Label            = sub_Block_Label
        self.api_Resource_Id_One        = api_Resource_Id_One
        self.api_Resource_Id_Two        = api_Resource_Id_Two
        self.resource_Type              = resource_Type
        self.score_One                  = score_One
        self.score_Two                  = score_Two
        self.match_Identifier           = match_Identifier
        self.match_Best_Of              = match_Best_Of
        self.api_Id_Long                = api_Id_Long
        self.team_One_Api_Id_Long       = team_One_Api_Id_Long
        self.team_One_Name              = team_One_Name
        self.team_One_Team_Photo_Url    = team_One_Team_Photo_Url
        self.team_One_Logo_Url          = team_One_Logo_Url
        self.team_One_Acronym           = team_One_Acronym
        self.team_One_Alt_Logo_Url      = team_One_Alt_Logo_Url
        self.team_One_Slug              = team_One_Slug
        self.team_Two_Api_Id_Long       = team_Two_Api_Id_Long
        self.team_Two_Name              = team_Two_Name
        self.team_Two_Team_Photo_Url    = team_Two_Team_Photo_Url
        self.team_Two_Logo_Url          = team_Two_Logo_Url
        self.team_Two_Acronym           = team_Two_Acronym
        self.team_Two_Alt_Logo_Url      = team_Two_Alt_Logo_Url
        self.team_Two_Slug              = team_Two_Slug
    }

}
