//
//  ViewController.swift
//  TableViewInPageViewInTableViewSample
//
//  Created by ClintJang on 05/06/2019.
//  Copyright © 2019 ClintJang. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    weak var pageViewController: UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize()
    }
}

private extension ViewController {
    /// initial setting
    func initialize() { initializeLayout() }
    
    /// Layout initial settings
    func initializeLayout() {
        Service.shared.firstTableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UINib(nibName: "TestATableViewCell", bundle: nil), forCellReuseIdentifier: "TestATableViewCell")

    }
}

// MARK: -
// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt::indexPath.row : \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestASectionTableViewCell") as! TestASectionTableViewCell
        return cell
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("Set TableView 1 YOffset:\(scrollView.contentOffset.y)")
//    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    func numberOfSections(in tableView: UITableView) -> Int { return 2 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestBTableViewCell", for: indexPath) as! TestBTableViewCell
            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "TestPageViewController") as? TestPageViewController {
                cell.pageViewController = pageViewController
                self.addChild(pageViewController)
                cell.contentView.addSubview(pageViewController.view)
                cell.pageViewController?.didMove(toParent: self)
                
                cell.pageViewController?.view.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.topAnchor.constraint(equalTo: pageViewController.view.topAnchor).isActive = true
                cell.contentView.widthAnchor.constraint(equalTo: pageViewController.view.widthAnchor).isActive = true
                cell.contentView.heightAnchor.constraint(equalTo: pageViewController.view.heightAnchor).isActive = true
                cell.contentView.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor).isActive = true
            }
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TestATableViewCell", for: indexPath) as! TestATableViewCell
            return cell
        }
    }
}
// MARK: -

