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

class MatchDetailViewController: UIViewController {
    
    var match : ScheduleMatch?
    var matchDetails : MatchDetail?
    var gameNumber: Int = 0
    
    var segmentedControl: HMSegmentedControl!
    
    var pageViewController : UIPageViewController!
    var pages = [UIViewController]()
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var gameOverView: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = (matchDetails?.team_One_Acronym)! + " vs " + (matchDetails?.team_Two_Acronym)!
        
        self.navigationController!.navigationItem.backBarButtonItem?.title = "WTF"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Place Bet", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MatchDetailViewController.betTapped))
        self.setupSegmentedControl()
        self.setupPageVC()
        
        self.vidPlayer(gameNumber)
        self.whoWon()
    }
    
    func betTapped(item: UIBarButtonItem){
        let betsVC = self.storyboard?.instantiateViewControllerWithIdentifier("PlaceBets")as! PlaceBetsViewController
        
        betsVC.matchTitle = (matchDetails?.team_One_Acronym)! + " vs " + (matchDetails?.team_Two_Acronym)!
        print(gameNumber)
        betsVC.gameNumber = gameNumber
        
        self.presentViewController(betsVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func segmentedControlChangedValue(segment: HMSegmentedControl) {
        gameNumber = segment.selectedSegmentIndex
        self.vidPlayer(gameNumber)
        self.updateGameNumber(gameNumber)
    }
    
    func test(index: Int) {
        gameNumber = index
        self.vidPlayer(gameNumber)
        self.updateGameNumber(gameNumber)
    }
    
    func whoWon() {
        if(matchDetails?.score_One > matchDetails?.score_Two) {
            gameOverView.text = (matchDetails?.team_One_Name)! + " Won"
        } else if(matchDetails?.score_One == matchDetails?.score_Two) {
            gameOverView.text = "Draw"
        } else {
            gameOverView.text = (matchDetails?.team_Two_Name)! + " Won"
        }
        
        
        if(matchDetails?.gameDetail.count > 1) {
            let maxScore : Int = max((matchDetails?.score_One!)!, (matchDetails?.score_Two!)!)
            let minScore : Int = min((matchDetails?.score_One!)!, (matchDetails?.score_Two!)!)
            
            gameOverView.text = gameOverView.text! + " (" + String(maxScore) + "-" + String(minScore) + ")"
        }
    }
    
    func vidPlayer(game: Int) {
        
        var youtubeLink : String = " "
        for index in 0 ... 3 {
            if(matchDetails?.gameDetail[game].locale[index] == "en") {
                if let link : String = matchDetails?.gameDetail[game].vidLink[index] {
                    youtubeLink = link
                }
            }
        }
        
        self.webView.hidden = true
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: youtubeLink)!))
        self.webView.scrollView.scrollEnabled = false
        self.webView.scrollView.bounces = false
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
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, 20)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        
        self.pageViewController.didMoveToParentViewController(self)
        self.constraintsPageVC()
    }
    
    func updateGameNumber(game: Int) {
        (pages[0] as! PlayerStatsViewController).updateGameNumber(game)
        (pages[1] as! MatchStatsViewController).updateGameNumber(game)
    }
    
    func setupSegmentedControl() {
        
        var tiles : [String] = []
        for game in (matchDetails?.gameDetail)! {
            tiles.append(game.game_Name!)
        }
        
        segmentedControl = HMSegmentedControl(sectionTitles: tiles)
        segmentedControl.addTarget(self, action: #selector(MatchDetailViewController.segmentedControlChangedValue(_:)), forControlEvents: .AllEvents)
        segmentedControl.frame = CGRectMake(0, 0, view.frame.width, 60)
        segmentedControl.selectionIndicatorHeight = 5.0
        segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.grayColor(), NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 17)!]
        segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0,10,0,10)
        segmentedControl.selectionIndicatorColor = UIColor(red: 253.0/255.0, green: 81.0/255.0, blue: 116.0/255.0, alpha: 0.8)
        segmentedControl.selectionStyle = .FullWidthStripe
        segmentedControl.selectionIndicatorLocation = .Down
        segmentedControl.backgroundColor = UIColor(red: 74.0/255.0, green: 106.0/255.0, blue: 145.0/255.0, alpha: 0.3)

        if(tiles.count == 1) {
            segmentedControl.hidden = true
        }
        
        self.view.addSubview(segmentedControl)
        self.constraintsSegment()
    }
    
    func constraintsSegment() {
        segmentedControl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(self.navigationController!.navigationBar.frame.height + (segmentedControl.frame.height/2) - 10)
            make.left.equalTo(view)
            make.bottom.equalTo(view.snp_top).offset(self.navigationController!.navigationBar.frame.height  + segmentedControl.frame.height)
            make.right.equalTo(view)
        }
    }
    
    func constraintsPageVC() {
        pageViewController.view.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(self.view.frame.height/2)
            make.left.equalTo(view)
            make.bottom.equalTo(view).inset(self.tabBarController!.tabBar.frame.height)
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

extension MatchDetailViewController: UIWebViewDelegate {
    func webViewDidStartLoad(webView : UIWebView) {
//        println("AA")
    }
    
    func webViewDidFinishLoad(webView : UIWebView) {
        webView.hidden = false
    }
}
