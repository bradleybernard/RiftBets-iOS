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
        print("didSelect")
        let match_Detail = filteredMatches[indexPath.row]
        RemoteManager.sharedInstance.matchDetail(match_Detail.api_Id_Long!, completion: { (json, error) -> Void in
            print(json)
            
        })
       // let matchDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MatchDetailViewController") as! MatchDetailViewController
        //matchDetailVC.match = match_Detail
        
       // self.navigationController?.pushViewController(matchDetailVC, animated: true)
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