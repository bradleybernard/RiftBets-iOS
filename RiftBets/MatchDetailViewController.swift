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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = (matchDetails?.team_One_Acronym)! + " vs " + (matchDetails?.team_Two_Acronym)!
        self.navigationController?.navigationBar.backItem?.title = "Back"
        
        self.setupSegmentedControl()
        self.setupPageVC()
    }
    
    @IBAction func segmentedControlChangedValue(segment: HMSegmentedControl) {
        gameNumber = segment.selectedSegmentIndex
        self.updateGameNumber(gameNumber)
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
