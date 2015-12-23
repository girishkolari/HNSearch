//===----------------------------------------------------------------------===//
//
//  HNSearchController.swift
//  HNSearch
//
//  Created by Girish Kolari on 12/12/15.
//  Copyright © 2015 Girish Kolari. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
//      HNSearchController.swift - Controller to handle search request
//
//===----------------------------------------------------------------------===//

import UIKit
///
class HNSearchController: UITableViewController, SegueHandlerType {
    //
    private let searchDataManager = HNSearchManager()
    private var searchDataManagerTableViewAdapter: HNSearchManagerTableViewAdapter<UITableViewCell>!
    private var search:HNSearchControllerAdapter?
    override func viewDidLoad() {
        searchDataManagerTableViewAdapter = HNSearchManagerTableViewAdapter(tableView: tableView, upcomingTaskDataManager: searchDataManager, cellReuseIdentifier: "Cell", cellConfigurationHandler: { cell, item in
            cell.textLabel?.text = item.title ?? item.story_title
            
            cell.detailTextLabel?.text = item.comment_text ?? ""
            }, didChangeHandler: {
                
        })
        searchDataManager.delegate = searchDataManagerTableViewAdapter
        searchDataManager.search("Swift")
        
        tableView.dataSource = searchDataManagerTableViewAdapter


        search = HNSearchControllerAdapter(){ searchBar in
            self.tableView.tableHeaderView = searchBar
            searchBar.scopeButtonTitles = ["All", "story", "comment", "ask_hn"]

        }
        
        search?.delegate =  searchDataManager

    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let item = searchDataManager.items[indexPath.section]
        print(item)

        return indexPath
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = searchDataManager.items[indexPath.section]
        print(item)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if case .TheHNDetail = segueIdentifierForSegue(segue) {
            if let detail = segue.destinationViewController as? DetailedController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let item = searchDataManager.items[indexPath.section]
                    detail.hnItem = item
                }
                    
            }

        }
        
        
//        switch segueIdentifierForSegue(segue) {
//        case .TheHNDetail:
        
    }

    enum SegueIdentifier: String {
        case TheHNDetail = "HNDetail"
    }

}

