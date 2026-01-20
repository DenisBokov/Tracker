//
//  ViewController.swift
//  Tracker
//
//  Created by Denis Bokov on 18.01.2026.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let trackerViewController = TrackerViewController()
        trackerViewController.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(resource: .trackerTabBarLogo),
            selectedImage: nil
        )
        
        let statisticViewController = StatisticViewController()
        statisticViewController.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(resource: .statisticTabBarLogo),
            selectedImage: nil
        )
        
        viewControllers = [trackerViewController, statisticViewController]
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .brown
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}

