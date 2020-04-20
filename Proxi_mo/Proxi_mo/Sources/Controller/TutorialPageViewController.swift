//
//  TutorialPageViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 08/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

final class TutorialPageViewController: UIPageViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newPageViewController(label: "Welcome"),
                self.newPageViewController(label: "ServicesList"),
                self.newPageViewController(label: "LocationPermission")]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configurePageControl()
        self.view.backgroundColor = UIColor.white
        self.dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    private func configurePageControl() {
        let controlAppearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        controlAppearance.backgroundColor = UIColor.white
        controlAppearance.pageIndicatorTintColor = UIColor.init(red: 156/255, green: 176/255, blue: 245/255,
                                                                alpha: 1.0)
        controlAppearance.currentPageIndicatorTintColor = UIColor.init(red: 70/255, green: 57/255, blue: 171/255,
                                                                       alpha: 1.0)
    }
    
    private func newPageViewController(label: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(label)ViewController")
    }
    
    
}

extension TutorialPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController:
        UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController:
        UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        if nextIndex == orderedViewControllersCount
        {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.firstIndex(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}

