//===----------------------------------------------------------------------===//
//
//  HNSearchManagerTableViewAdapter.swift
//  HNSearch
//
//  Created by Girish Kolari on 12/12/15.
//  Copyright © 2015 Girish Kolari. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
//      HNSearchManagerTableViewAdapter.swift - Table delegate
//
//===----------------------------------------------------------------------===//

import Foundation
import UIKit
//


class HNSearchManagerTableViewAdapter<CellType: UITableViewCell>: NSObject, UITableViewDataSource, HNSearchManagerUpdate { //, UpcomingTaskDataManagerDelegate
    private let tableView: UITableView
    private let upcomingHNSearchManager: HNSearchManager
    private let cellReuseIdentifier: String
    private let cellConfigurationHandler: (CellType, HNItem) -> ()
    private let didChangeHandler: () -> Void

    
    init(tableView: UITableView, upcomingTaskDataManager: HNSearchManager, cellReuseIdentifier: String, cellConfigurationHandler: (CellType, HNItem) -> (), didChangeHandler: () -> Void) {
        self.tableView = tableView
        self.upcomingHNSearchManager = upcomingTaskDataManager
        self.cellReuseIdentifier = cellReuseIdentifier
        self.cellConfigurationHandler = cellConfigurationHandler
        self.didChangeHandler = didChangeHandler
        
        
        
        super.init()
        

    }

    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //upcomingTaskDataManager.deleteTask(upcomingTaskDataManager.taskSections[indexPath.section].items[indexPath.row])
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Girish"//upcomingHNSearchManager.taskSections[section].title
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingHNSearchManager.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = upcomingHNSearchManager.items[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! CellType
        cellConfigurationHandler(cell, item)
        return cell
    }
    
    
    func willChangeContent(dataManager: HNSearchManager) {

    }
    
    func didChangeContent(dataManager: HNSearchManager) {
        print(dataManager.items)
        tableView.reloadData()
        didChangeHandler()

    }

}