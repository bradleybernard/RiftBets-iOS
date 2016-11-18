//
//  MatchDetailViewController.swift
//  RiftBets
//
//  Created by Sushil Patel on 10/18/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation
import UIKit
import HMSegmentedControl

class MatchDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var match : ScheduleMatch?
    var matchDetails : MatchDetail?
    var gameNumber: Int = 0
    
    var segmentedControl: HMSegmentedControl!
    
    var pageViewController : UIPageViewController!
    var pages = [UIViewController]()
    
    //overall match stats
    @IBOutlet weak var teamTwoName: UILabel!
    @IBOutlet weak var teamOneName: UILabel!
    @IBOutlet weak var score_One: UILabel!
    @IBOutlet weak var score_Two: UILabel!
    @IBOutlet weak var teamOneLogo: UIImageView!
    @IBOutlet weak var teamTwoLogo: UIImageView!
    
    //picks and bans vars
    @IBOutlet weak var pBTeamTwo: UILabel!
    @IBOutlet weak var pBTeamOne: UILabel!
    @IBOutlet weak var teamOneBanOne: UIImageView!
    @IBOutlet weak var teamOneBanTwo: UIImageView!
    @IBOutlet weak var teamOneBanThree: UIImageView!
    @IBOutlet weak var teamTwoBanOne: UIImageView!
    @IBOutlet weak var teamTwoBanTwo: UIImageView!
    @IBOutlet weak var teamTwoBanThree: UIImageView!
    
    //match stats vars -done
    @IBOutlet weak var mSTeamOne: UILabel!
    @IBOutlet weak var mSTeamTwo: UILabel!
    @IBOutlet weak var teamOneKills: UILabel!
    @IBOutlet weak var teamTwoKills: UILabel!
    @IBOutlet weak var teamOneGold: UILabel!
    @IBOutlet weak var teamTwoGold: UILabel!
    @IBOutlet weak var teamOneDragons: UILabel!
    @IBOutlet weak var teamTwoDragons: UILabel!
    @IBOutlet weak var teamOneBaron: UILabel!
    @IBOutlet weak var teamTwoBaron: UILabel!
    @IBOutlet weak var teamOneTowers: UILabel!
    @IBOutlet weak var teamTwoTowers: UILabel!

    //player stats
    @IBOutlet weak var player_stats: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = (matchDetails?.team_One_Acronym)! + " vs " + (matchDetails?.team_Two_Acronym)!
        self.navigationController?.navigationBar.backItem?.title = "Back"
        
        self.formatDetails()
        self.setupSegmentedControl()
        self.setupPageVC()
    }
    
    // Segment pressed
    @IBAction func segmentedControlChangedValue(segment: HMSegmentedControl) {
        gameNumber = segment.selectedSegmentIndex
        self.updateGameNumber(gameNumber)
        formatDetails()
    }
    
    func setupPageVC() {
        
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController.dataSource = self
        
        let playerStatsVC : PlayerStatsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PlayerStatsViewController") as! PlayerStatsViewController
        let matchStatsVC : MatchStatsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MatchStatsViewController") as! MatchStatsViewController
        
        playerStatsVC.matchDetails = matchDetails
        matchStatsVC.matchDetails = matchDetails
        
        playerStatsVC.gameNumber = gameNumber
        matchStatsVC.gameNumber = gameNumber
        
        pages.append(playerStatsVC)
        pages.append(matchStatsVC)
        
        self.pageViewController.setViewControllers([playerStatsVC], direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func updateGameNumber(game: Int) {
        (pages[0] as! PlayerStatsViewController).updateGameNumber(game)
        (pages[1] as! MatchStatsViewController).updateGameNumber(game)
    }
    
    //formats page for game_one haven't figured out the switch bar at the top
    func formatDetails() {

        teamOneName.text = matchDetails?.team_One_Name
        teamTwoName.text = matchDetails?.team_Two_Name
        
        if let scoreOne : Int = matchDetails?.score_One {
            score_One.text = String(scoreOne)
        }
        
        if let scoreTwo : Int = matchDetails?.score_Two {
            score_Two.text = String(scoreTwo)
        }
        
        let teamOneUrl = NSURL(string: (matchDetails?.team_One_Logo_Url!)!)
        let teamTwoUrl = NSURL(string: (matchDetails?.team_Two_Logo_Url!)!)
        
        teamOneLogo.af_setImageWithURL(teamOneUrl!)
        teamTwoLogo.af_setImageWithURL(teamTwoUrl!)
        
        //picks and bans
        pBTeamOne.text = matchDetails?.team_One_Acronym
        pBTeamTwo.text = matchDetails?.team_Two_Acronym
        
        //match stats
        mSTeamOne.text = matchDetails?.team_One_Acronym
        mSTeamTwo.text = matchDetails?.team_Two_Acronym
        
        if let t1drag : Int = matchDetails?.gameDetail[gameNumber].teamOne?.dragon_Kills {
            teamOneDragons.text = String(t1drag)
        }
        if let t2drag : Int = matchDetails?.gameDetail[gameNumber].teamTwo?.dragon_Kills {
            teamTwoDragons.text = String(t2drag)
        }
        if let t1tower : Int = matchDetails?.gameDetail[gameNumber].teamOne?.tower_Kills {
            teamOneTowers.text = String(t1tower)
        }
        if let t2tower : Int = matchDetails?.gameDetail[gameNumber].teamTwo?.tower_Kills {
            teamTwoTowers.text = String(t2tower)
        }
        if let t1barons : Int = matchDetails?.gameDetail[gameNumber].teamOne?.baron_Kills {
            teamOneBaron.text = String(t1barons)
        }
        if let t2barons : Int = matchDetails?.gameDetail[gameNumber].teamTwo?.baron_Kills {
            teamTwoBaron.text = String(t2barons)
        }
        
        var team1Kills : Int = 0
        var team2Kills : Int = 0
        var team1Gold : Int = 0
        var team2Gold : Int = 0
 
        for index in 0...4 {
            team1Kills = team1Kills + (matchDetails?.gameDetail[gameNumber].teamOne?.players[index].kills)!
            team1Gold = team1Gold + (matchDetails?.gameDetail[gameNumber].teamOne?.players[index].gold_Earned)!
            team2Kills = team2Kills + (matchDetails?.gameDetail[gameNumber].teamTwo?.players[index].kills)!
            team2Gold = team2Gold + (matchDetails?.gameDetail[gameNumber].teamTwo?.players[index].gold_Earned)!
        }
        
        teamOneGold.text = String(team1Gold)
        teamOneKills.text = String(team1Kills)
        teamTwoKills.text = String(team2Kills)
        teamTwoGold.text = String(team2Gold)
        
        let teamOneBan_1Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamOne?.ban_1)!)
        let teamOneBan_2Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamOne?.ban_2)!)
        let teamOneBan_3Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamOne?.ban_3)!)
        let teamTwoBan_1Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamTwo?.ban_1)!)
        let teamTwoBan_2Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamTwo?.ban_2)!)
        let teamTwoBan_3Url = NSURL(string: (matchDetails?.gameDetail[gameNumber].teamTwo?.ban_3)!)
        
        teamOneBanOne.af_setImageWithURL(teamOneBan_1Url!)
        teamOneBanTwo.af_setImageWithURL(teamOneBan_2Url!)
        teamOneBanThree.af_setImageWithURL(teamOneBan_3Url!)
        teamTwoBanOne.af_setImageWithURL(teamTwoBan_1Url!)
        teamTwoBanTwo.af_setImageWithURL(teamTwoBan_2Url!)
        teamTwoBanThree.af_setImageWithURL(teamTwoBan_3Url!)
        
        player_stats.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : PlayerStatsCustomCell = tableView.dequeueReusableCellWithIdentifier("PlayerStatsCustomCell") as! PlayerStatsCustomCell
        
        if let t1player : Players = matchDetails?.gameDetail[gameNumber].teamOne?.players[indexPath.item] {
            
            cell.teamOnePlayerName.text = t1player.summoner_Name
            
            if let kills : Int = t1player.kills {
                if let deaths : Int = t1player.deaths {
                    if let assists : Int = t1player.assists {
                        cell.teamOnePlayerKills.text = String(kills) + "/" + String(deaths) + "/" + String(assists)
                    }
                }
            }
           
            let champUrl = NSURL(string: t1player.champion_Id!)
            cell.teamOnePlayerChamp.af_setImageWithURL(champUrl!)
            
            if(t1player.item_1 != nil) {
                let item1Url = NSURL(string: t1player.item_1!)
                cell.teamOnePlayerItem1.af_setImageWithURL(item1Url!)
            }
            if(t1player.item_2 != nil) {
                let item2Url = NSURL(string: t1player.item_2!)
                cell.teamOnePlayerItem2.af_setImageWithURL(item2Url!)
            }
            if(t1player.item_3 != nil) {
                let item3Url = NSURL(string: t1player.item_3!)
                cell.teamOnePlayerItem3.af_setImageWithURL(item3Url!)
            }
            if(t1player.item_4 != nil) {
                let item4Url = NSURL(string: t1player.item_4!)
                cell.teamOnePlayerItem4.af_setImageWithURL(item4Url!)
            }
            if(t1player.item_5 != nil) {
                let item5Url = NSURL(string: t1player.item_5!)
                cell.teamOnePlayerItem5.af_setImageWithURL(item5Url!)
            }
            if(t1player.item_6 != nil) {
                let item6Url = NSURL(string: t1player.item_6!)
                cell.teamOnePlayerItem6.af_setImageWithURL(item6Url!)
            }
            
            let teamOneSS1Url = NSURL(string: t1player.spell1_Id!)
            let teamOneSS2Url = NSURL(string: t1player.spell2_Id!)
            
            cell.teamOnePlayerSS1.af_setImageWithURL(teamOneSS1Url!)
            cell.teamOnePlayerSS2.af_setImageWithURL(teamOneSS2Url!)
        }
        
        if let t2player : Players = matchDetails?.gameDetail[gameNumber].teamTwo?.players[indexPath.item] {
            
            cell.teamTwoPlayerName.text = t2player.summoner_Name
            
            if let kills : Int = t2player.kills {
                if let deaths : Int = t2player.deaths {
                    if let assists : Int = t2player.assists {
                        cell.teamTwoPlayerKills.text = String(kills) + "/" + String(deaths) + "/" + String(assists)
                    }
                }
            }
            
            let champUrl = NSURL(string: t2player.champion_Id!)
            cell.teamTwoPlayerChamp.af_setImageWithURL(champUrl!)
            
            if(t2player.item_1 != nil) {
                let item1Url = NSURL(string: t2player.item_1!)
                cell.teamTwoPlayerItem1.af_setImageWithURL(item1Url!)
            }
            if(t2player.item_2 != nil) {
                let item2Url = NSURL(string: t2player.item_2!)
                cell.teamTwoPlayerItem2.af_setImageWithURL(item2Url!)
            }
            if(t2player.item_3 != nil) {
                let item3Url = NSURL(string: t2player.item_3!)
                cell.teamTwoPlayerItem3.af_setImageWithURL(item3Url!)
            }
            if(t2player.item_4 != nil) {
                let item4Url = NSURL(string: t2player.item_4!)
                cell.teamTwoPlayerItem4.af_setImageWithURL(item4Url!)
            }
            if(t2player.item_5 != nil) {
                let item5Url = NSURL(string: t2player.item_5!)
                cell.teamTwoPlayerItem5.af_setImageWithURL(item5Url!)
            }
            if(t2player.item_6 != nil) {
                let item6Url = NSURL(string: t2player.item_6!)
                cell.teamTwoPlayerItem6.af_setImageWithURL(item6Url!)
            }
            
            let teamTwoSS1Url = NSURL(string: t2player.spell1_Id!)
            let teamTwoSS2Url = NSURL(string: t2player.spell2_Id!)
            
            cell.teamTwoPlayerSS1.af_setImageWithURL(teamTwoSS1Url!)
            cell.teamTwoPlayerSS2.af_setImageWithURL(teamTwoSS2Url!)
        }
        
        return cell
    }
    
    func setupSegmentedControl() {
        
        var tiles : [String] = []
        for game in (matchDetails?.gameDetail)! {
            tiles.append(game.game_Name!)
        }
        
        segmentedControl = HMSegmentedControl(sectionTitles: tiles)
        segmentedControl.addTarget(self, action: #selector(MatchDetailViewController.segmentedControlChangedValue(_:)), forControlEvents: .AllEvents)
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
        segmentedControl.hidden = false
        
        self.view.addSubview(segmentedControl)
        self.view.bringSubviewToFront(segmentedControl)
        self.constraintsSegment()
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

extension MatchDetailViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
