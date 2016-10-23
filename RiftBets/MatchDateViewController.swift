//
//  MatchDateViewController.swift
//  RiftBets
//
//  Created by Sushil Patel on 10/20/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//


import SwiftyJSON
import UIKit

class MatchDateViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBAction func Refresh(sender: AnyObject) {
        getData()
        reload()
    }
    
    @IBOutlet weak var dateTable: UITableView!
    
     var matches = [ScheduleMatch]()
    
    var dates = [String]()

    
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
                    
                    print(subJsonT["name"].stringValue)
                }
                
            }
            self.reload()
   
        })
        
    }

    


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dates.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath)
        let match_schedule = matches[indexPath.row]
        
        cell.textLabel?.text = dates[indexPath.row] // not sure how to convert NSDate type to string
        
        cell.detailTextLabel?.text = match_schedule.name
        
        return cell
    }
    func reload(){
        
        dateTable.reloadData()
    }

}