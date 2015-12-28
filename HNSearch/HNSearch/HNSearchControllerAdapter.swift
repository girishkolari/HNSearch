//===----------------------------------------------------------------------===//
//
//  HNSearchControllerAdapter.swift
//  HNSearch
//
//  Created by Girish Kolari on 12/19/15.
//  Copyright © 2015 Girish Kolari. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
//      HNSearchControllerAdapter.swift - Search controle handling
//
//===----------------------------------------------------------------------===//

import UIKit

protocol SearchControllerUpdate {
    func search(searchText: String, tag: Tags?)
}

class HNSearchControllerAdapter: NSObject, UISearchResultsUpdating, UISearchBarDelegate {
    let searchController = UISearchController(searchResultsController: nil)
    var delegate: SearchControllerUpdate?
    init(updateSearchBar: (UISearchBar) -> Void) {
        super.init()
        //This is useful if you are using another view controller for searchResultsController.
        //let searchController = UISearchController(searchResultsController: nil)
        //searchResultsUpdater is a property on UISearchController that conforms to
        //the new protocol UISearchResultsUpdating. This protocol allows your class
        //to be informed as text changes within the UISearchBar. You’ll make the class
        //conform to the protocol in a short while.
        searchController.searchResultsUpdater = self
        //By default, UISearchController will dim the view it is presented over.
        searchController.dimsBackgroundDuringPresentation = false
        //By setting definesPresentationContext on your view controller to true, you
        //ensure that the search bar does not remain on the screen if the user
        //navigates to another view controller while the UISearchController is active.
        //definesPresentationContext = true
        searchController.searchBar.delegate = self

        updateSearchBar(searchController.searchBar)
        //you add the searchBar to your table view’s tableHeaderView.

    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        if let searchText = searchController.searchBar.text {
//            //searchDataManager.search(searchText)
//        }
    }
    private func search(text: String?, index: Int) {
        if let searchText = text, delegate = delegate {
            let options: [Tags?] = [nil, Tags.Story, Tags.Comment, Tags.AskHN]
            let optionSelected = options[index]
            delegate.search(searchText, tag: optionSelected)
        }

    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) { // called when text ends editing
        search(searchBar.text, index: searchBar.selectedScopeButtonIndex)
    }
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        search(searchBar.text, index: selectedScope)
    }

}
