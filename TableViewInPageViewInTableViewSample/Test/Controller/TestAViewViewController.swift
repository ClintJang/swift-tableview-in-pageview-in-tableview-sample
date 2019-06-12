//
//  TestAViewViewController.swift
//  TableViewInPageViewInTableViewSample
//
//  Created by ClintJang on 04/06/2019.
//  Copyright © 2019 ClintJang. All rights reserved.
//

import UIKit

final class TestAViewViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    /// Check Drapping.
    private var isDrapping: Bool = false
    /// Previous YOffset value
    private var beforeYOffset: CGFloat = 0.0
    
    enum Constants {
        /// Cell Count Value
        static let sampleCellCount = 50
        static let sampleCellLabelBackgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        static let sampleCellLabelTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        /// Font correction value
        static let sampleCellLabelFontCorrectionValue = 8
        
        static let minFirstTableViewContentOffsetY: CGFloat = 0.0
        static let maxFirstTableViewContentOffsetY: CGFloat = 52.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension TestAViewViewController {
    /// initial setting
    func initialize() { initializeLayout() }
    
    /// Layout initial settings
    func initializeLayout() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        //        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.register(UINib(nibName: "TestCTableViewCell", bundle: nil), forCellReuseIdentifier: "TestCTableViewCell")
    }
}

// MARK: -
// MARK: UITableViewDelegate
extension TestAViewViewController: UITableViewDelegate {
    /// Check Drapping.
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) { isDrapping = true }
    /// Check Drapping.
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) { isDrapping = false }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        guard let tableView = Service.shared.firstTableView,
            (yOffset >= Constants.minFirstTableViewContentOffsetY || tableView.contentOffset.y > 0.0),
            isDrapping == true else {
            beforeYOffset = yOffset
            return
        }

        let gap: CGFloat =  yOffset - beforeYOffset
        var reviseGap = tableView.contentOffset.y + gap
        if reviseGap > Constants.maxFirstTableViewContentOffsetY { reviseGap = Constants.maxFirstTableViewContentOffsetY }
        else if reviseGap < Constants.minFirstTableViewContentOffsetY { reviseGap = Constants.minFirstTableViewContentOffsetY }
        
        if gap > 0 {
            if tableView.contentOffset.y < Constants.maxFirstTableViewContentOffsetY { tableView.contentOffset.y = reviseGap }
        } else {
            if tableView.contentOffset.y > Constants.minFirstTableViewContentOffsetY { tableView.contentOffset.y = reviseGap }
        }
        beforeYOffset = yOffset
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("didSelectRowAt::indexPath.row : \(indexPath.row)")
//    }
}

// MARK: UITableViewDelegate
extension TestAViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.sampleCellCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCTableViewCell", for: indexPath) as! TestCTableViewCell
        cell.testLabel?.text = "\(indexPath.row+1). TestCTableViewCell "
        cell.testLabel?.font = UIFont.systemFont(ofSize: CGFloat(indexPath.row + Constants.sampleCellLabelFontCorrectionValue))
        cell.testLabel?.backgroundColor = Constants.sampleCellLabelBackgroundColor
        cell.testLabel?.textColor = Constants.sampleCellLabelTextColor
        return cell
    }
}
// MARK: -
