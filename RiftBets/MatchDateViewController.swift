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

class MatchDateViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    
    
    
    @IBOutlet weak var dateTable: UITableView!
    
    @IBOutlet weak var segment: HMSegmentedControl!
    var matches = [ScheduleMatch]()
    
    var segmentedControl: HMSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControl()
        getData()
        
    }
    
    @IBAction func Refresh(sender: AnyObject) {
        getData()
    }
    
    func getData() {
        
        matches.removeAll()
        
        RemoteManager.sharedInstance.matchSchedule({ (json, error) -> Void in
            
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
                            match_Best_Of           :matchJson["match_best_of"].intValue,
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
                    ))
                    
                }
                
            }
            
            self.dateTable.reloadData()
   
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return matches.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell : MatchDateCustomCell = tableView.dequeueReusableCellWithIdentifier("MatchDateCustomCell") as! MatchDateCustomCell
        let match_schedule = matches[indexPath.item]
        
        cell.formatCell(match_schedule)
        
        return cell
    }
    func setupSegmentedControl() {
        self.segmentedControl = HMSegmentedControl(sectionTitles: ["Login", "Register"])
         // segmentedControl.addTarget(self, action: "segmentedControlChangedValue:", forControlEvents: .AllEvents)
        self.segmentedControl.frame = CGRectMake(0, view.frame.height - 55, view.frame.width, 55)
        segmentedControl.selectionIndicatorHeight = 5.0
        segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(), NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 20)!]
        segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0,10,0,10)
        // segmentedControl.selectionIndicatorColor = UIColor(red: 253.0/255.0, green: 81.0/255.0, blue: 116.0/255.0, alpha: 0.8)
        segmentedControl.selectionIndicatorColor = UIColor(red: 0.141, green: 0.165, blue: 0.224, alpha: 0.8)
        //segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe
        //segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationUp
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor(red: 74.0/255.0, green: 106.0/255.0, blue: 145.0/255.0, alpha: 0.3)
        
        self.segment = segmentedControl
        
        self.view.addSubview(segment)
        self.view.bringSubviewToFront(segment)
    }

}