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

class MatchDateViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBAction func Refresh(sender: AnyObject) {
        getData()
        reload()
    }
    
    @IBOutlet weak var dateTable: UITableView!
    

    
    var matches = [ScheduleMatch]()
    
    var dates = [String]()
    
    var team_one_s = [Int]()
    
    var team_two_s = [Int]()
    
    var best = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        //reload()

    }
    
    
    
    func getData() {
        
        RemoteManager.sharedInstance.matchSchedule({ (json, error) -> Void in
            
           
            
            for (key, subJson) : (String, JSON) in json {

                for (keyT, subJsonT) : (String, JSON) in subJson {
                    guard let name = subJsonT["name"].string else {
                        continue
                    }
                    //print(subJsonT["scheduled_time"].stringValue)(
                    self.matches.append(
                        ScheduleMatch(
                            name                    : name,
                            date                    : subJsonT["scheduled_time"].stringValue,
                            state                   : subJsonT["state"].stringValue,
                            block_Prefix            : subJsonT["block_prefix"].stringValue,
                            block_Label             : subJsonT["block_label"].stringValue,
                            sub_Block_Prefix        : subJsonT["sub_block_prefix"].stringValue,
                            sub_Block_Label         : subJsonT["sub_block_label"].stringValue,
                            api_Resource_Id_One     : subJsonT["api_resource_id_one"].stringValue,
                            api_Resource_Id_Two     : subJsonT["api_resource_id_two"].stringValue,
                            resource_Type           : subJsonT["resource_type"].stringValue,
                            score_One               : subJsonT["score_one"].intValue,
                            score_Two               : subJsonT["score_two"].intValue,
                            match_Identifier        : subJsonT["match_identifier"].stringValue,
                            match_Best_Of           :subJsonT["match_best_of"].intValue,
                            team_One_Api_Id_Long    : subJsonT["resources"]["one"]["api_id_long"].stringValue,
                            team_One_Name           : subJsonT["resources"]["one"]["name"].stringValue,
                            team_One_Team_Photo_Url : subJsonT["resources"]["one"]["team_photo_url"].stringValue,
                            team_One_Logo_Url       : subJsonT["resources"]["one"]["logo_url"].stringValue,
                            team_One_Acronym        : subJsonT["resources"]["one"]["acronym"].stringValue,
                            team_One_Alt_Logo_Url   : subJsonT["resources"]["one"]["alt_logo_url"].stringValue,
                            team_One_Slug           : subJsonT["resources"]["one"]["slug"].stringValue,
                            team_Two_Api_Id_Long    : subJsonT["resources"]["two"]["api_id_long"].stringValue,
                            team_Two_Name           : subJsonT["resources"]["two"]["name"].stringValue,
                            team_Two_Team_Photo_Url : subJsonT["resources"]["two"]["team_photo_url"].stringValue,
                            team_Two_Logo_Url       : subJsonT["resources"]["two"]["logo_url"].stringValue,
                            team_Two_Acronym        : subJsonT["resources"]["two"]["acronym"].stringValue,
                            team_Two_Alt_Logo_Url   : subJsonT["resources"]["two"]["alt_logo_url"].stringValue,
                            team_Two_Slug           : subJsonT["resources"]["two"]["slug"].stringValue
                    ))
                    self.dates.append(subJsonT["scheduled_time"].stringValue)
                    self.team_one_s.append(subJsonT["score_one"].intValue)
                    self.team_two_s.append(subJsonT["score_two"].intValue)
                    self.best.append(subJsonT["match_best_of"].intValue)
                    print(subJsonT["name"].stringValue)
                    print(subJsonT["match_best_of"].intValue)
                }
                
            }
            self.reload()
   
        })
        
    }

    


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dates.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell:MatchDateCustomCell = tableView.dequeueReusableCellWithIdentifier("customcell") as! MatchDateCustomCell
        let match_schedule = matches[indexPath.item]
        
        let dateArr = dates[indexPath.item].componentsSeparatedByString(" ")
        
        let date: String = dateArr[0]
        
        
        
        
        
        
        
        let formatter = NSDateFormatter()
        
       // let usDateFormat = NSDateFormatter.dateFormatFromTemplate("YYYY-MM-DD", options: 0, locale: NSLocale(localeIdentifier: "en-US"))
        
        formatter.dateStyle = .NoStyle
        formatter.timeStyle = .ShortStyle
        
        cell.matchDate.text = formatter.stringFromDate(match_schedule.date!)
        
        
        if(match_schedule.match_Best_Of > 1){
            if let best_of = match_schedule.match_Best_Of{
                cell.matchName.text = "Best of " + String(best_of)
            }
            
        }
        
        cell.team_one_short.text = match_schedule.team_One_Acronym
        
        cell.team_two_short.text = match_schedule.team_Two_Acronym
        
        if(match_schedule.state == "resolved"){
            if let score = match_schedule.score_One{
                if(score == 1){
                    cell.team_one_score.text = "Victory"
                    cell.team_two_score.text = "Defeat"
                }else if(score == 0){
                    cell.team_one_score.text = "Defeat"
                    cell.team_two_score.text = "Victory"
                }
            }
        }
        let team_one_url = NSURL(string: match_schedule.team_One_Logo_Url!)
        let team_two_url = NSURL(string: match_schedule.team_Two_Logo_Url!)
        
        cell.team_one_logo.af_setImageWithURL(team_one_url!)
        cell.team_two_logo.af_setImageWithURL(team_two_url!)
        return cell
    }
    func reload(){
        
        dateTable.reloadData()
    }

}