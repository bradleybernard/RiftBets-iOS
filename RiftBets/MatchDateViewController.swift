//
//  MatchDateViewController.swift
//  RiftBets
//
//  Created by Sushil Patel on 10/20/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import SwiftyJSON
import UIKit
import Alamofire
import AlamofireImage
import HMSegmentedControl
import SnapKit
import EasyAnimation

class MatchDateViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateTable: UITableView!
    
    var matches = [ScheduleMatch]()
    var filteredMatches = [ScheduleMatch]()
    var segmentedControl: HMSegmentedControl!
    var matchDetail : MatchDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControl()
        fetchSchedule()
    }
    
    @IBAction func segmentedControlChangedValue(segment: HMSegmentedControl) {
        filterMatches(getDateFromSegment())
    }
    
    func getDateFromSegment() -> NSDate {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM d"
        
        var date = formatter.dateFromString(segmentedControl.sectionTitles[segmentedControl.selectedSegmentIndex] as! String)!
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: date)
        
        components.year = 2016
        date = calendar.dateFromComponents(components)!
        
        return date
    }
    
    func fetchSchedule() {
        
        RemoteManager.sharedInstance.matchSchedule({ (json, error) -> Void in
            
            if error != nil {
                print("Error: " + error!.description)
                return
            }
            
            self.matches = [ScheduleMatch]()
            self.filteredMatches = [ScheduleMatch]()
            
            for (_, subJson) : (String, JSON) in json {

                for (_, matchJson) : (String, JSON) in subJson {
                    
                    guard let name = matchJson["name"].string else {
                        continue
                    }
                    
                    self.matches.append(
                        ScheduleMatch(
                            name                    : name,
                            date                    : matchJson["scheduled_time"].stringValue,
                            state                   : matchJson["state"].stringValue,
                            block_Prefix            : matchJson["block_prefix"].stringValue,
                            block_Label             : matchJson["block_label"].stringValue,
                            sub_Block_Prefix        : matchJson["sub_block_prefix"].stringValue,
                            sub_Block_Label         : matchJson["sub_block_label"].stringValue,
                            api_Resource_Id_One     : matchJson["api_resource_id_one"].stringValue,
                            api_Resource_Id_Two     : matchJson["api_resource_id_two"].stringValue,
                            resource_Type           : matchJson["resource_type"].stringValue,
                            score_One               : matchJson["score_one"].intValue,
                            score_Two               : matchJson["score_two"].intValue,
                            match_Identifier        : matchJson["match_identifier"].stringValue,
                            match_Best_Of           : matchJson["match_best_of"].intValue,
                            api_Id_Long             : matchJson["api_id_long"].stringValue,
                            team_One_Api_Id_Long    : matchJson["resources"]["one"]["api_id_long"].stringValue,
                            team_One_Name           : matchJson["resources"]["one"]["name"].stringValue,
                            team_One_Team_Photo_Url : matchJson["resources"]["one"]["team_photo_url"].stringValue,
                            team_One_Logo_Url       : matchJson["resources"]["one"]["logo_url"].stringValue,
                            team_One_Acronym        : matchJson["resources"]["one"]["acronym"].stringValue,
                            team_One_Alt_Logo_Url   : matchJson["resources"]["one"]["alt_logo_url"].stringValue,
                            team_One_Slug           : matchJson["resources"]["one"]["slug"].stringValue,
                            team_Two_Api_Id_Long    : matchJson["resources"]["two"]["api_id_long"].stringValue,
                            team_Two_Name           : matchJson["resources"]["two"]["name"].stringValue,
                            team_Two_Team_Photo_Url : matchJson["resources"]["two"]["team_photo_url"].stringValue,
                            team_Two_Logo_Url       : matchJson["resources"]["two"]["logo_url"].stringValue,
                            team_Two_Acronym        : matchJson["resources"]["two"]["acronym"].stringValue,
                            team_Two_Alt_Logo_Url   : matchJson["resources"]["two"]["alt_logo_url"].stringValue,
                            team_Two_Slug           : matchJson["resources"]["two"]["slug"].stringValue
                        )
                    )
                }
            }
            
            self.setSegmentDates()
            self.filterMatches(self.getDateFromSegment())
            
            self.segmentedControl.hidden = false
            self.dateTable.reloadData()
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMatches.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell : MatchDateCustomCell = tableView.dequeueReusableCellWithIdentifier("MatchDateCustomCell") as! MatchDateCustomCell
        let match_schedule = filteredMatches[indexPath.item]
        
        cell.formatCell(match_schedule)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       // print("didSelect")
        
        let match_Detail = filteredMatches[indexPath.row]
        let matchDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MatchDetailViewController") as! MatchDetailViewController
        
        RemoteManager.sharedInstance.matchDetail(match_Detail.api_Id_Long!, completion: { (json, error) -> Void in
           // print(json)
            

            var playerNum : String = " "
            var game : String = " "
            var current_game = 1
            
            for(_,detailJson) : (String, JSON) in json{
                self.matchDetail = MatchDetail(
                    api_Id_Long: detailJson["api_id_long"].stringValue,
                    name: detailJson["name"].stringValue,
                    resource_Type: detailJson["resource_type"].stringValue,
                    api_Resource_Id_One: detailJson["api_resource_id_one"].stringValue,
                    api_Resource_Id_Two: detailJson["api_resource_id_two"].stringValue,
                    score_One: detailJson["score_one"].intValue,
                    score_Two: detailJson["score_two"].intValue,
                    team_One_Api_Id_Long: detailJson["resources"]["one"]["api_id_long"].stringValue,
                    team_One_Name: detailJson["resources"]["one"]["name"].stringValue,
                    team_One_Photo_Url: detailJson["resources"]["one"]["team_photo_url"].stringValue,
                    team_One_Logo_Url: detailJson["resources"]["one"]["logo_url"].stringValue,
                    team_One_Acronym: detailJson["resources"]["one"]["acronym"].stringValue,
                    team_One_Alt_Logo_Url: detailJson["resources"]["one"]["alt_logo_url"].stringValue,
                    team_One_Slug: detailJson["resources"]["one"]["slug"].stringValue,
                    team_Two_Api_Id_Long: detailJson["resources"]["two"]["api_id_long"].stringValue,
                    team_Two_Name: detailJson["resources"]["two"]["name"].stringValue,
                    team_Two_Photo_Url: detailJson["resources"]["team_photo_url"].stringValue,
                    team_Two_Logo_Url: detailJson["resources"]["two"]["logo_url"].stringValue,
                    team_Two_Acronym: detailJson["resources"]["two"]["acronym"].stringValue,
                    team_Two_Alt_Logo_Url: detailJson["resources"]["two"]["alt_logo_url"].stringValue,
                    team_Two_Slug: detailJson["resources"]["two"]["slug"].stringValue
                )
                
                
                //let total_games = (matchDetail?.score_One)! + (matchDetail?.score_Two)!
                
                
               
                for current_game in 1...5 {
                    
                    if(current_game == 1){
                        game = "game_one"
                    }else if(current_game == 2){
                        game = "game_two"
                    }else if(current_game == 3){
                        game = "game_three"
                    }else if(current_game == 4){
                        game = "game_four"
                    }else if(current_game == 5){
                        game = "game_five"
                    }
                    if(detailJson[game] != nil){
                        self.matchDetail?.gameDetail.append(
                            GameDetail(
                                game_Name: detailJson[game]["game_name"].stringValue,
                                game_Id: detailJson[game]["game_id"].stringValue,
                                generated_Name: detailJson[game]["generated_name"].stringValue,
                                teamOne : TeamOne(
                                    team_Id: detailJson[game]["team_one"]["team_id"].stringValue,
                                    win: detailJson[game]["team_one"]["win"].intValue,
                                    first_Blood: detailJson[game]["team_one"]["first_blood"].intValue,
                                    first_Inhibitor: detailJson[game]["team_one"]["first_inhibitor"].intValue,
                                    first_Baron: detailJson[game]["team_one"]["first_baron"].intValue,
                                    first_Dragon: detailJson[game]["team_one"]["first_dragon"].intValue,
                                    first_Rift_Herald: detailJson[game]["team_one"]["first_rift_herald"].intValue,
                                    tower_Kills: detailJson[game]["team_one"]["tower_kills"].intValue,
                                    inhibitor_Kills: detailJson[game]["team_one"]["inhibitor_kills"].intValue,
                                    baron_Kills: detailJson[game]["team_one"]["baron_kills"].intValue,
                                    dragon_Kills: detailJson[game]["team_one"]["dragon_kills"].intValue,
                                    rift_Herald_Kills: detailJson[game]["team_one"]["rift_herald_kills"].intValue,
                                    ban_1: detailJson[game]["team_one"]["ban_1"]["image_url"].stringValue,
                                    ban_2: detailJson[game]["team_one"]["ban_2"]["image_url"].stringValue,
                                    ban_3: detailJson[game]["team_one"]["ban_3"]["image_url"].stringValue
                                    
                                ),
                                
                                teamTwo : TeamTwo(
                                    team_Id: detailJson[game]["team_two"]["team_id"].stringValue,
                                    win: detailJson[game]["team_two"]["win"].intValue,
                                    first_Blood: detailJson[game]["team_two"]["first_blood"].intValue,
                                    first_Inhibitor: detailJson[game]["team_two"]["first_inhibitor"].intValue,
                                    first_Baron: detailJson[game]["team_two"]["first_baron"].intValue,
                                    first_Dragon: detailJson[game]["team_two"]["first_dragon"].intValue,
                                    first_Rift_Herald: detailJson[game]["team_two"]["first_rift_herald"].intValue,
                                    tower_Kills: detailJson[game]["team_two"]["tower_kills"].intValue,
                                    inhibitor_Kills: detailJson[game]["team_two"]["inhibitor_kills"].intValue,
                                    baron_Kills: detailJson[game]["team_two"]["baron_kills"].intValue,
                                    dragon_Kills: detailJson[game]["team_two"]["dragon_kills"].intValue,
                                    rift_Herald_Kills: detailJson[game]["team_two"]["rift_herald_kills"].intValue,
                                    ban_1: detailJson[game]["team_two"]["ban_1"]["image_url"].stringValue,
                                    ban_2: detailJson[game]["team_two"]["ban_2"]["image_url"].stringValue,
                                    ban_3: detailJson[game]["team_two"]["ban_3"]["image_url"].stringValue
                                )
                            )
                            
                        )
            
                        for playerNumber in 1...10{
                            // print(playerNum)
                            if(playerNumber == 1){
                                playerNum = "1"
                            }else if(playerNumber == 2){
                                playerNum = "2"
                            }else if(playerNumber == 3){
                                playerNum = "3"
                            }else if(playerNumber == 4){
                                playerNum = "4"
                            }else if(playerNumber == 5){
                                playerNum = "5"
                            }else if(playerNumber == 6){
                                playerNum = "6"
                            }else if(playerNumber == 7){
                                playerNum = "7"
                            }else if(playerNumber == 8){
                                playerNum = "8"
                            }else if(playerNumber == 9){
                                playerNum = "9"
                            }else if(playerNumber == 10){
                                playerNum = "10"
                            }
                            if( playerNumber < 6){
                                self.matchDetail?.gameDetail[current_game-1].teamOne?.players.append(Players(
                                    participant_Id: detailJson[game]["team_one"]["player_stats"][playerNum]["participant_id"].intValue,
                                    team_Id: detailJson[game]["team_one"]["player_stats"][playerNum]["team_id"].intValue,
                                    champion_Id: detailJson[game]["team_one"]["player_stats"][playerNum]["champion"]["image_url"].stringValue,
                                    spell1_Id: detailJson[game]["team_one"]["player_stats"][playerNum]["spell_1"]["image_url"].stringValue,
                                    spell2_Id: detailJson[game]["team_one"]["player_stats"][playerNum]["spell_2"]["image_url"].stringValue,
                                    item_1: detailJson[game]["team_one"]["player_stats"][playerNum]["item_1"]["image_url"].stringValue,
                                    item_2: detailJson[game]["team_one"]["player_stats"][playerNum]["item_2"]["image_url"].stringValue,
                                    item_3: detailJson[game]["team_one"]["player_stats"][playerNum]["item_3"]["image_url"].stringValue,
                                    item_4: detailJson[game]["team_one"]["player_stats"][playerNum]["item_4"]["image_url"].stringValue,
                                    item_5: detailJson[game]["team_one"]["player_stats"][playerNum]["item_5"]["image_url"].stringValue,
                                    item_6: detailJson[game]["team_one"]["player_stats"][playerNum]["item_6"]["image_url"].stringValue,
                                    kills: detailJson[game]["team_one"]["player_stats"][playerNum]["kills"].intValue,
                                    deaths: detailJson[game]["team_one"]["player_stats"][playerNum]["deaths"].intValue,
                                    assists: detailJson[game]["team_one"]["player_stats"][playerNum]["assists"].intValue,
                                    gold_Earned: detailJson[game]["team_one"]["player_stats"][playerNum]["gold_earned"].intValue,
                                    minions_Killed: detailJson[game]["team_one"]["player_stats"][playerNum]["minions_killed"].intValue,
                                    champ_Level: detailJson[game]["team_one"]["player_stats"][playerNum]["champ_level"].intValue,
                                    summoner_Name: detailJson[game]["team_one"]["player_stats"][playerNum]["summoner_name"].stringValue
                                    )
                                )
                                
                            }
                            else if( playerNumber > 5 ){
                                
                                self.matchDetail?.gameDetail[current_game-1].teamTwo?.players.append(Players(
                                    participant_Id: detailJson[game]["team_two"]["players_stats"][playerNum]["participant_id"].intValue,
                                    team_Id: detailJson[game]["team_two"]["players_stats"][playerNum]["team_id"].intValue,
                                    champion_Id: detailJson[game]["team_two"]["players_stats"][playerNum]["champion"]["image_url"].stringValue,
                                    spell1_Id: detailJson[game]["team_two"]["players_stats"][playerNum]["spell_1"]["image_url"].stringValue,
                                    spell2_Id: detailJson[game]["team_two"]["players_stats"][playerNum]["spell_2"]["image_url"].stringValue,
                                    item_1: detailJson[game]["team_two"]["players_stats"][playerNum]["item_1"]["image_url"].stringValue,
                                    item_2: detailJson[game]["team_two"]["players_stats"][playerNum]["item_2"]["image_url"].stringValue,
                                    item_3: detailJson[game]["team_two"]["players_stats"][playerNum]["item_3"]["image_url"].stringValue,
                                    item_4: detailJson[game]["team_two"]["players_stats"][playerNum]["item_4"]["image_url"].stringValue,
                                    item_5: detailJson[game]["team_two"]["players_stats"][playerNum]["item_5"]["image_url"].stringValue,
                                    item_6: detailJson[game]["team_two"]["players_stats"][playerNum]["item_6"]["image_url"].stringValue,
                                    kills: detailJson[game]["team_two"]["players_stats"][playerNum]["kills"].intValue,
                                    deaths: detailJson[game]["team_two"]["players_stats"][playerNum]["deaths"].intValue,
                                    assists: detailJson[game]["team_two"]["players_stats"][playerNum]["assists"].intValue,
                                    gold_Earned: detailJson[game]["team_two"]["players_stats"][playerNum]["gold_earned"].intValue,
                                    minions_Killed: detailJson[game]["team_two"]["players_stats"][playerNum]["minions_killed"].intValue,
                                    champ_Level: detailJson[game]["team_two"]["players_stats"][playerNum]["champ_level"].intValue,
                                    summoner_Name: detailJson[game]["team_two"]["players_stats"][playerNum]["summoner_name"].stringValue
                                    )
                                )
                                
                            }
                        }
                        
                    }
                }
                current_game = current_game + 1
            }

            if let matchDets : MatchDetail = self.matchDetail {
                matchDetailVC.formatDetails(matchDets)
            }
           //print(matchDetail?.gameDetail[0].teamTwo?.players[1].summoner_Name)
            
        })

       self.navigationController?.pushViewController(matchDetailVC, animated: true)
    }
    
    func setSegmentDates() {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM d"
        
        var dates : [String] = []
        
        for match in matches.sort({ $0.date!.compare($1.date!) == NSComparisonResult.OrderedAscending }) {
            if let date = match.date {
                let dateString = formatter.stringFromDate(date)
                print(dateString)
                if !dates.contains(dateString) {
                    dates.append(dateString)
                }
            }
        }
        
        segmentedControl.sectionTitles = dates
        // FIX: Needs to select the one closest to todays date instead of last one
        segmentedControl.setSelectedSegmentIndex(UInt(dates.count - 1), animated: true)
    }
    
    func filterMatches(date: NSDate = NSDate()) {
        
        filteredMatches = [ScheduleMatch]()
        
        for match in matches {
            print("MatchDate: \(match.date!)  Date: \(date)")
            if NSCalendar.currentCalendar().isDate(date, inSameDayAsDate: match.date!) {
                filteredMatches.append(match)
            }
        }
        
        self.dateTable.reloadData()
    }
    
    func setupSegmentedControl() {
        
        segmentedControl = HMSegmentedControl(sectionTitles: ["DatesList"])
        segmentedControl.addTarget(self, action: #selector(MatchDateViewController.segmentedControlChangedValue(_:)), forControlEvents: .AllEvents)
        segmentedControl.frame = CGRectMake(0, 0, view.frame.width, 55)
        segmentedControl.selectionIndicatorHeight = 5.0
        segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(), NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 20)!]
        segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0,10,0,10)
        segmentedControl.selectionIndicatorColor = UIColor(red: 253.0/255.0, green: 81.0/255.0, blue: 116.0/255.0, alpha: 0.8)
        segmentedControl.selectionIndicatorColor = UIColor.redColor()
        segmentedControl.selectionStyle = .FullWidthStripe
        segmentedControl.selectionIndicatorLocation = .Down
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor(red: 74.0/255.0, green: 106.0/255.0, blue: 145.0/255.0, alpha: 0.3)
        segmentedControl.hidden = true
        
        self.view.addSubview(segmentedControl)
        self.view.bringSubviewToFront(segmentedControl)
        self.constraintsSegment()
        self.constraintsTableView()
    }
    
    func constraintsTableView() {
        dateTable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(segmentedControl.snp_bottom)
            make.left.equalTo(view)
            make.bottom.equalTo(view)
            make.right.equalTo(view)
        }
    }
    
    func constraintsSegment() {
        segmentedControl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(self.navigationController!.navigationBar.frame.height + segmentedControl.frame.height/2)
            make.left.equalTo(view)
            make.bottom.equalTo(view.snp_top).offset(self.navigationController!.navigationBar.frame.height  + segmentedControl.frame.height)
            make.right.equalTo(view)
        }
    }

}