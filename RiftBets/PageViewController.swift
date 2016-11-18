//
//  PageViewController.swift
//  RiftBets
//
//  Created by Sushil Patel on 11/17/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import Foundation

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    var matchDetails: MatchDetail?
    var gameNumber : Int = 0
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let page1 : PlayerStatsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PlayerStatsViewController") as! PlayerStatsViewController
        let page2 : MatchStatsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MatchStatsViewController") as! MatchStatsViewController
        
        page1.matchDetails = matchDetails
        page1.gameNumber = gameNumber
        
        page2.matchDetails = matchDetails
        page2.gameNumber = gameNumber

        pages.append(page1)
        pages.append(page2)
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
