//
//  PageViewController.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/17/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation

class GameStatsPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var matchDetails: MatchDetail?
    var gameNumber : Int = 0
    
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.delegate = self
//        self.dataSource = self
        
        let playerStatsVC : PlayerStatsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PlayerStatsViewController") as! PlayerStatsViewController
        let matchStatsVC : MatchStatsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MatchStatsViewController") as! MatchStatsViewController
        
        playerStatsVC.matchDetails = matchDetails
        matchStatsVC.matchDetails = matchDetails
        
        playerStatsVC.gameNumber = gameNumber
        matchStatsVC.gameNumber = gameNumber

        pages.append(playerStatsVC)
        pages.append(matchStatsVC)
    }
    
    func updateGameNumber(game: Int) {
        (pages[0] as! PlayerStatsViewController).gameNumber = game
        (pages[1] as! MatchStatsViewController).gameNumber = game
    }
    
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
