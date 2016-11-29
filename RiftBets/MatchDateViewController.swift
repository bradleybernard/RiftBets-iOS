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
// This view controller manages the match schedule screen in the app
class MatchDateViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateTable: UITableView!
    
    var matches = [ScheduleMatch]()
    var filteredMatches = [ScheduleMatch]()
    var segmentedControl: HMSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateTable.backgroundColor = UIColor(red: 0.0627, green: 0.0627, blue: 0.0627, alpha: 1)
        self.title = "Schedule"
        
        self.setupSegmentedControl()
        self.fetchSchedule()
    }
    //function detects when the date is changed on the selector and calls of the appropriate matches to be shown
    @IBAction func segmentedControlChangedValue(segment: HMSegmentedControl) {
        segment.setSelectedSegmentIndex(UInt(segment.selectedSegmentIndex), animated: true)
        filterMatches(getDateFromSegment())
    }
    //funtion splits the time and date recieved in the JSON
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
    // Function makes a JSON request and populates the matches variable
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
    // Function formats tableView rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMatches.count
    }
    // Function formats tableView cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell : MatchDateCustomCell = tableView.dequeueReusableCellWithIdentifier("MatchDateCustomCell") as! MatchDateCustomCell
        let match_schedule = filteredMatches[indexPath.item]
        
        cell.formatCell(match_schedule)
        
        return cell
    }
    // Function for the selected a cell an JSON request is made for the match details for the match displayed on the selected cell, matchDetail variable is populated
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let match_Detail = filteredMatches[indexPath.row]
        
        RemoteManager.sharedInstance.matchDetail(match_Detail.api_Id_Long!, completion: { (json, error) -> Void in

            if error != nil {
                print("Error: " + error!.description)
                return
            }
            
            var playerNum : String = " "
            var game : String = " "
            var current_game = 1
            
            var matchDetail = MatchDetail(
                api_Id_Long: json["api_id_long"].stringValue,
                name: json["name"].stringValue,
                resource_Type: json["resource_type"].stringValue,
                api_Resource_Id_One: json["api_resource_id_one"].stringValue,
                api_Resource_Id_Two: json["api_resource_id_two"].stringValue,
                score_One: json["score_one"].intValue,
                score_Two: json["score_two"].intValue,
                team_One_Api_Id_Long: json["resources"]["one"]["api_id_long"].stringValue,
                team_One_Name: json["resources"]["one"]["name"].stringValue,
                team_One_Photo_Url: json["resources"]["one"]["team_photo_url"].stringValue,
                team_One_Logo_Url: json["resources"]["one"]["logo_url"].stringValue,
                team_One_Acronym: json["resources"]["one"]["acronym"].stringValue,
                team_One_Alt_Logo_Url: json["resources"]["one"]["alt_logo_url"].stringValue,
                team_One_Slug: json["resources"]["one"]["slug"].stringValue,
                team_Two_Api_Id_Long: json["resources"]["two"]["api_id_long"].stringValue,
                team_Two_Name: json["resources"]["two"]["name"].stringValue,
                team_Two_Photo_Url: json["resources"]["team_photo_url"].stringValue,
                team_Two_Logo_Url: json["resources"]["two"]["logo_url"].stringValue,
                team_Two_Acronym: json["resources"]["two"]["acronym"].stringValue,
                team_Two_Alt_Logo_Url: json["resources"]["two"]["alt_logo_url"].stringValue,
                team_Two_Slug: json["resources"]["two"]["slug"].stringValue
            )
            
                       
            for current_game in 1...5 {
                
                if(current_game == 1) {
                    game = "game_one"
                } else if(current_game == 2) {
                    game = "game_two"
                } else if(current_game == 3) {
                    game = "game_three"
                } else if(current_game == 4) {
                    game = "game_four"
                } else if(current_game == 5) {
                    game = "game_five"
                }
                
                if(json[game] != nil) {
                    matchDetail.gameDetail.append(
                        GameDetail(
                            game_Name: json[game]["game_name"].stringValue,
                            game_Id: json[game]["game_id"].stringValue,
                            generated_Name: json[game]["generated_name"].stringValue,
                            teamOne : TeamOne(
                                team_Id: json[game]["team_one"]["team_id"].stringValue,
                                win: json[game]["team_one"]["win"].intValue,
                                first_Blood: json[game]["team_one"]["first_blood"].intValue,
                                first_Inhibitor: json[game]["team_one"]["first_inhibitor"].intValue,
                                first_Baron: json[game]["team_one"]["first_baron"].intValue,
                                first_Dragon: json[game]["team_one"]["first_dragon"].intValue,
                                first_Rift_Herald: json[game]["team_one"]["first_rift_herald"].intValue,
                                tower_Kills: json[game]["team_one"]["tower_kills"].intValue,
                                inhibitor_Kills: json[game]["team_one"]["inhibitor_kills"].intValue,
                                baron_Kills: json[game]["team_one"]["baron_kills"].intValue,
                                dragon_Kills: json[game]["team_one"]["dragon_kills"].intValue,
                                rift_Herald_Kills: json[game]["team_one"]["rift_herald_kills"].intValue,
                                ban_1: json[game]["team_one"]["ban_1"]["image_url"].stringValue,
                                ban_2: json[game]["team_one"]["ban_2"]["image_url"].stringValue,
                                ban_3: json[game]["team_one"]["ban_3"]["image_url"].stringValue
                                
                            ),
                            
                            teamTwo : TeamTwo(
                                team_Id: json[game]["team_two"]["team_id"].stringValue,
                                win: json[game]["team_two"]["win"].intValue,
                                first_Blood: json[game]["team_two"]["first_blood"].intValue,
                                first_Inhibitor: json[game]["team_two"]["first_inhibitor"].intValue,
                                first_Baron: json[game]["team_two"]["first_baron"].intValue,
                                first_Dragon: json[game]["team_two"]["first_dragon"].intValue,
                                first_Rift_Herald: json[game]["team_two"]["first_rift_herald"].intValue,
                                tower_Kills: json[game]["team_two"]["tower_kills"].intValue,
                                inhibitor_Kills: json[game]["team_two"]["inhibitor_kills"].intValue,
                                baron_Kills: json[game]["team_two"]["baron_kills"].intValue,
                                dragon_Kills: json[game]["team_two"]["dragon_kills"].intValue,
                                rift_Herald_Kills: json[game]["team_two"]["rift_herald_kills"].intValue,
                                ban_1: json[game]["team_two"]["ban_1"]["image_url"].stringValue,
                                ban_2: json[game]["team_two"]["ban_2"]["image_url"].stringValue,
                                ban_3: json[game]["team_two"]["ban_3"]["image_url"].stringValue
                            )
                        
                        )
                        
                    )
                    for(_,vidJson) in json[game]["videos"]{
                        matchDetail.gameDetail[current_game-1].locale.append(vidJson["locale"].stringValue)
                        matchDetail.gameDetail[current_game-1].vidLink.append(vidJson["source"].stringValue)
                    }
                    for playerNumber in 1...10 {
                        
                        if(playerNumber == 1) {
                            playerNum = "1"
                        } else if(playerNumber == 2) {
                            playerNum = "2"
                        } else if(playerNumber == 3) {
                            playerNum = "3"
                        } else if(playerNumber == 4) {
                            playerNum = "4"
                        } else if(playerNumber == 5) {
                            playerNum = "5"
                        } else if(playerNumber == 6) {
                            playerNum = "6"
                        } else if(playerNumber == 7) {
                            playerNum = "7"
                        } else if(playerNumber == 8) {
                            playerNum = "8"
                        } else if(playerNumber == 9) {
                            playerNum = "9"
                        } else if(playerNumber == 10) {
                            playerNum = "10"
                        }
                        
                        if(playerNumber < 6) {
                            matchDetail.gameDetail[current_game-1].teamOne?.players.append(
                                Players(
                                    participant_Id: json[game]["team_one"]["player_stats"][playerNum]["participant_id"].intValue,
                                    team_Id: json[game]["team_one"]["player_stats"][playerNum]["team_id"].intValue,
                                    champion_Id: json[game]["team_one"]["player_stats"][playerNum]["champion"]["image_url"].stringValue,
                                    spell1_Id: json[game]["team_one"]["player_stats"][playerNum]["spell_1"]["image_url"].stringValue,
                                    spell2_Id: json[game]["team_one"]["player_stats"][playerNum]["spell_2"]["image_url"].stringValue,
                                    item_1: json[game]["team_one"]["player_stats"][playerNum]["item_1"]["image_url"].stringValue,
                                    item_2: json[game]["team_one"]["player_stats"][playerNum]["item_2"]["image_url"].stringValue,
                                    item_3: json[game]["team_one"]["player_stats"][playerNum]["item_3"]["image_url"].stringValue,
                                    item_4: json[game]["team_one"]["player_stats"][playerNum]["item_4"]["image_url"].stringValue,
                                    item_5: json[game]["team_one"]["player_stats"][playerNum]["item_5"]["image_url"].stringValue,
                                    item_6: json[game]["team_one"]["player_stats"][playerNum]["item_6"]["image_url"].stringValue,
                                    kills: json[game]["team_one"]["player_stats"][playerNum]["kills"].intValue,
                                    deaths: json[game]["team_one"]["player_stats"][playerNum]["deaths"].intValue,
                                    assists: json[game]["team_one"]["player_stats"][playerNum]["assists"].intValue,
                                    gold_Earned: json[game]["team_one"]["player_stats"][playerNum]["gold_earned"].intValue,
                                    minions_Killed: json[game]["team_one"]["player_stats"][playerNum]["minions_killed"].intValue,
                                    champ_Level: json[game]["team_one"]["player_stats"][playerNum]["champ_level"].intValue,
                                    summoner_Name: json[game]["team_one"]["player_stats"][playerNum]["summoner_name"].stringValue
                                )
                            )
                            
                        } else if(playerNumber > 5) {
                            
                            matchDetail.gameDetail[current_game-1].teamTwo?.players.append(
                                Players(
                                    participant_Id: json[game]["team_two"]["players_stats"][playerNum]["participant_id"].intValue,
                                    team_Id: json[game]["team_two"]["players_stats"][playerNum]["team_id"].intValue,
                                    champion_Id: json[game]["team_two"]["players_stats"][playerNum]["champion"]["image_url"].stringValue,
                                    spell1_Id: json[game]["team_two"]["players_stats"][playerNum]["spell_1"]["image_url"].stringValue,
                                    spell2_Id: json[game]["team_two"]["players_stats"][playerNum]["spell_2"]["image_url"].stringValue,
                                    item_1: json[game]["team_two"]["players_stats"][playerNum]["item_1"]["image_url"].stringValue,
                                    item_2: json[game]["team_two"]["players_stats"][playerNum]["item_2"]["image_url"].stringValue,
                                    item_3: json[game]["team_two"]["players_stats"][playerNum]["item_3"]["image_url"].stringValue,
                                    item_4: json[game]["team_two"]["players_stats"][playerNum]["item_4"]["image_url"].stringValue,
                                    item_5: json[game]["team_two"]["players_stats"][playerNum]["item_5"]["image_url"].stringValue,
                                    item_6: json[game]["team_two"]["players_stats"][playerNum]["item_6"]["image_url"].stringValue,
                                    kills: json[game]["team_two"]["players_stats"][playerNum]["kills"].intValue,
                                    deaths: json[game]["team_two"]["players_stats"][playerNum]["deaths"].intValue,
                                    assists: json[game]["team_two"]["players_stats"][playerNum]["assists"].intValue,
                                    gold_Earned: json[game]["team_two"]["players_stats"][playerNum]["gold_earned"].intValue,
                                    minions_Killed: json[game]["team_two"]["players_stats"][playerNum]["minions_killed"].intValue,
                                    champ_Level: json[game]["team_two"]["players_stats"][playerNum]["champ_level"].intValue,
                                    summoner_Name: json[game]["team_two"]["players_stats"][playerNum]["summoner_name"].stringValue
                                )
                            )
                            
                        }
                    }
                    
                }
            }
            
            current_game = current_game + 1
            
            let matchDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MatchDetailViewController") as! MatchDetailViewController
            matchDetailVC.matchDetails = matchDetail
            
            self.navigationController?.pushViewController(matchDetailVC, animated: true)
        })

    }
    // Function sets up the segemented dates controller
    func setSegmentDates() {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM d"
        
        var dates : [String] = []
        
        for match in matches.sort({ $0.date!.compare($1.date!) == NSComparisonResult.OrderedAscending }) {
            if let date = match.date {
                let dateString = formatter.stringFromDate(date)
                if !dates.contains(dateString) {
                    dates.append(dateString)
                }
            }
        }
        
        segmentedControl.sectionTitles = dates
        // FIX: Needs to select the one closest to todays date instead of last one
        segmentedControl.setSelectedSegmentIndex(UInt(dates.count - 1), animated: true)
    }
    // Function filters matches based on date
    func filterMatches(date: NSDate = NSDate()) {
        
        filteredMatches = [ScheduleMatch]()
        
        for match in matches {
            if NSCalendar.currentCalendar().isDate(date, inSameDayAsDate: match.date!) {
                filteredMatches.append(match)
            }
        }
        
        self.dateTable.reloadData()
    }
    // Function sets up the segmented controller
    func setupSegmentedControl() {
        
        segmentedControl = HMSegmentedControl(sectionTitles: ["DatesList"])
        segmentedControl.addTarget(self, action: #selector(MatchDateViewController.segmentedControlChangedValue(_:)), forControlEvents: .AllEvents)
        segmentedControl.frame = CGRectMake(0, 0, view.frame.width, 60)
        segmentedControl.selectionIndicatorHeight = 5.0
        segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(), NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 17)!]
        segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0,10,0,10)
        segmentedControl.selectionIndicatorColor = UIColor(red: 253.0/255.0, green: 81.0/255.0, blue: 116.0/255.0, alpha: 0.8)
        segmentedControl.selectionStyle = .FullWidthStripe
        segmentedControl.selectionIndicatorLocation = .Down
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor(red: 74.0/255.0, green: 106.0/255.0, blue: 145.0/255.0, alpha: 0.3)
        segmentedControl.hidden = true
        segmentedControl.shouldAnimateUserSelection = true
        
        self.view.addSubview(segmentedControl)
        self.constraintsSegment()
        self.constraintsTableView()
    }
    // Function adds constraints to tableView
    func constraintsTableView() {
        dateTable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(segmentedControl.snp_top)
            make.left.equalTo(view)
            make.bottom.equalTo(view)
            make.right.equalTo(view)
        }
    }
    // Function adds contraints to segemented controller
    func constraintsSegment() {
        segmentedControl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(self.navigationController!.navigationBar.frame.height + (segmentedControl.frame.height/2) - 10)
            make.left.equalTo(view)
            make.bottom.equalTo(view.snp_top).offset(self.navigationController!.navigationBar.frame.height  + segmentedControl.frame.height)
            make.right.equalTo(view)
        }
    }

}
