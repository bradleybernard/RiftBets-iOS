//
//  MatchDetail.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/4/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation

//All IDs are set to String because I figured it would be easier to send network requests.
struct MatchDetail{
    var gameDetail              = [GameDetail]()
    //var teams = [Teams]()
    //var players = [Players]()
    var api_Id_Long             : String?
    var name                    : String?
    var resource_Type           : String?
    var api_Resource_Id_One     : String?
    var api_Resource_Id_Two     : String?
    var score_One               : Int?
    var score_Two               : Int?
    var team_One_Api_Id_Long    : String?
    var team_One_Name           : String?
    var team_One_Photo_Url      : String?
    var team_One_Logo_Url       : String?
    var team_One_Acronym        : String?
    var team_One_Alt_Logo_Url   : String?
    var team_One_Slug           : String?
    var team_Two_Api_Id_Long    : String?
    var team_Two_Name           : String?
    var team_Two_Photo_Url      : String?
    var team_Two_Logo_Url       : String?
    var team_Two_Acronym        : String?
    var team_Two_Alt_Logo_Url   : String?
    var team_Two_Slug           : String?
    
    init(api_Id_Long            : String,
         name                   : String,
         resource_Type          : String,
         api_Resource_Id_One    : String,
         api_Resource_Id_Two    : String,
         score_One              : Int,
         score_Two              : Int,
         team_One_Api_Id_Long   : String,
         team_One_Name          : String,
         team_One_Photo_Url     : String,
         team_One_Logo_Url      : String,
         team_One_Acronym       : String,
         team_One_Alt_Logo_Url  : String,
         team_One_Slug          : String,
         team_Two_Api_Id_Long   : String,
         team_Two_Name          : String,
         team_Two_Photo_Url     : String,
         team_Two_Logo_Url      : String,
         team_Two_Acronym       : String,
         team_Two_Alt_Logo_Url  : String,
         team_Two_Slug          : String
        
    )
    {
        self.api_Id_Long            = api_Id_Long
        self.name                   = name
        self.resource_Type          = resource_Type
        self.api_Resource_Id_One    = api_Resource_Id_One
        self.api_Resource_Id_Two    = api_Resource_Id_Two
        self.score_One              = score_One
        self.score_Two              = score_Two
        self.team_One_Api_Id_Long   = team_One_Api_Id_Long
        self.team_One_Name          = team_One_Name
        self.team_One_Photo_Url     = team_One_Photo_Url
        self.team_One_Logo_Url      = team_One_Logo_Url
        self.team_One_Acronym       = team_One_Acronym
        self.team_One_Alt_Logo_Url  = team_One_Alt_Logo_Url
        self.team_One_Slug          = team_One_Slug
        self.team_Two_Api_Id_Long   = team_Two_Api_Id_Long
        self.team_Two_Name          = team_Two_Name
        self.team_Two_Photo_Url     = team_Two_Photo_Url
        self.team_Two_Logo_Url      = team_Two_Logo_Url
        self.team_Two_Acronym       = team_Two_Acronym
        self.team_Two_Alt_Logo_Url  = team_Two_Alt_Logo_Url
        self.team_Two_Slug          = team_Two_Slug
    }
    
}

struct GameDetail{
    var game_Name       : String?
    var game_Id         : String?
    var generated_Name  : String?
    var teams           = [Teams]()

    init(game_Name      : String,
         game_Id        : String,
         generated_Name : String
    )
    {
        self.game_Name      = game_Name
        self.game_Id        = game_Id
        self.generated_Name = generated_Name
    }
    
}

struct Teams{
    var team_Id             : String?
    var win                 : Int?
    var first_Blood         : Int?
    var first_Inhibitor     : Int?
    var first_Baron         : Int?
    var first_Dragon        : Int?
    var first_Rift_Herald   : Int?
    var tower_Kills         : Int?
    var inhibitor_Kills     : Int?
    var baron_Kills         : Int?
    var dragon_Kills        : Int?
    var rift_Herald_Kills   : Int?
    var ban_1               : String?
    var ban_2               : String?
    var ban_3               : String?
    var players             = [Players]()
    
    init(team_Id            : String,
         win: Int,
         first_Blood        : Int,
         first_Inhibitor    : Int,
         first_Baron        : Int,
         first_Dragon       : Int,
         first_Rift_Herald  : Int,
         tower_Kills        : Int,
         inhibitor_Kills    : Int,
         baron_Kills        : Int,
         dragon_Kills       : Int,
         rift_Herald_Kills  : Int,
         ban_1              : String,
         ban_2              : String,
         ban_3              : String
        )
    {
        self.team_Id            = team_Id
        self.win                = win
        self.first_Blood        = first_Blood
        self.first_Inhibitor    = first_Inhibitor
        self.first_Baron        = first_Baron
        self.first_Dragon       = first_Dragon
        self.first_Rift_Herald  = first_Rift_Herald
        self.tower_Kills        = tower_Kills
        self.inhibitor_Kills    = inhibitor_Kills
        self.baron_Kills        = baron_Kills
        self.dragon_Kills       = dragon_Kills
        self.rift_Herald_Kills  = rift_Herald_Kills
        self.ban_1              = ban_1
        self.ban_2              = ban_2
        self.ban_3              = ban_3
    }
    
}

struct Players{
    var participant_Id  : Int?
    var team_Id         : Int?
    var champion_Id     : String?
    var spell1_Id       : String?
    var spell2_Id       : String?
    var item_1          : String?
    var item_2          : String?
    var item_3          : String?
    var item_4          : String?
    var item_5          : String?
    var item_6          : String?
    var kills           : Int?
    var deaths          : Int?
    var assists         : Int?
    var gold_Earned     : Int?
    var minions_Killed  : Int?
    var champ_Level     : Int?
    var summoner_Name   : String?
    
    init( participant_Id    : Int,
          team_Id           : Int,
          champion_Id       : String,
          spell1_Id         : String,
          spell2_Id         : String,
          item_1            : String,
          item_2            : String,
          item_3            : String,
          item_4            : String,
          item_5            : String,
          item_6            : String,
          kills             : Int,
          deaths            : Int,
          assists           : Int,
          gold_Earned       : Int,
          minions_Killed    : Int,
          champ_Level       : Int,
          summoner_Name     : String
    )
    {
        self.participant_Id = participant_Id
        self.team_Id        = team_Id
        self.champion_Id    = champion_Id
        self.spell1_Id      = spell1_Id
        self.spell2_Id      = spell2_Id
        self.item_1         = item_1
        self.item_2         = item_2
        self.item_3         = item_3
        self.item_4         = item_4
        self.item_5         = item_5
        self.item_6         = item_6
        self.kills          = kills
        self.deaths         = deaths
        self.assists        = assists
        self.gold_Earned    = gold_Earned
        self.minions_Killed = minions_Killed
        self.champ_Level    = champ_Level
        self.summoner_Name  = summoner_Name
    }

}