//
//  TestPageViewController.swift
//  TableViewInPageViewInTableViewSample
//
//  Created by ClintJang on 04/06/2019.
//  Copyright © 2019 ClintJang. All rights reserved.
//

import UIKit

final class TestPageViewController: UIPageViewController {
    private lazy var pages = [UIViewController]()
    
    enum Constants { static let pageCounts = 3...5 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
}

private extension TestPageViewController {
    /// Initial setting
    func initialize() { initializeLayout() }
    
    /// Layout initial settings
    func initializeLayout() {
        // Setting Delegate
        dataSource = self
        delegate = self
        
        // ETC Controllers
        pages = Constants.pageCounts.map { number in
            let labelString = "Page \(number)"
            let controller = UIViewController()
            controller.title = labelString
            // Background Color
            controller.view.backgroundColor = number % 2 == 0 ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) : #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            
            // Add Label
            let label = UILabel()
            label.text = labelString
            label.textAlignment = NSTextAlignment.center
            label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            label.font = UIFont.systemFont(ofSize: 32)
            controller.view.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            controller.view.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
            controller.view.widthAnchor.constraint(equalTo: label.widthAnchor).isActive = true
            controller.view.heightAnchor.constraint(equalTo: label.heightAnchor).isActive = true
            controller.view.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
            
            return controller
        }
        // For Test Second TableView
        pages.insert(storyboard?.instantiateViewController(withIdentifier: "TestAViewViewController") as! TestAViewViewController, at: 0)
        pages.insert(storyboard?.instantiateViewController(withIdentifier: "TestBViewViewController") as! TestBViewViewController, at: 1)

        setViewControllers([pages[0]], direction: UIPageViewController.NavigationDirection.forward, animated: false) { _ in }
    }
}

// MARK: -
// MARK: UIPageViewControllerDataSource
extension TestPageViewController: UIPageViewControllerDataSource {
    // Left
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        return pages[previousIndex]
    }
    
    // Right
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return nil }
        return pages[nextIndex]
    }
}

// MARK: UIPageViewControllerDelegate
extension TestPageViewController: UIPageViewControllerDelegate {
    /// Get Current Page
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let pageContentViewController = pageViewController.viewControllers?[0], let index = pages.firstIndex(of: pageContentViewController) else { return }
            print(">> index: \(index)")
        }
    }
}
