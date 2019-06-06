//
//  Service.swift
//  TableViewInPageViewInTableViewSample
//
//  Created by ClintJang on 05/06/2019.
//  Copyright © 2019 ClintJang. All rights reserved.
//

import UIKit

final class Service {
    static let shared = Service()
    private init() {}
    
    weak var firstTableView: UITableView? = nil
}
