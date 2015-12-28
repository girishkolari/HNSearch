//===----------------------------------------------------------------------===//
//
//  HNSearchManager.swift
//  HNSearch
//
//  Created by Girish Kolari on 12/12/15.
//  Copyright © 2015 Girish Kolari. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
//      HNSearchManager.swift - Object to handle the model layer
//
//===----------------------------------------------------------------------===//

import Foundation
import Alamofire
import SwiftyJSON

class HNSearchManager: NSObject, SearchControllerUpdate {
    var items: [HNItem] = []
    var delegate: HNSearchManagerUpdate?
    private func parse(data: NSData) {
        let json = JSON(data: data)
        if let items = json["hits"].array {
            //print(items)
            delegate?.willChangeContent(self)

            self.items = items.map() { item in
                print(item)
                return HNItem(jsonItem: item)
            }
            delegate?.didChangeContent(self)

        } else {
            print(data.description)
        }
    }

    func search(searchStr: String, tag: Tags? = nil) {
        var hn = HNSearch()
        hn[.Query] = searchStr
        if let tag = tag {
            hn[.Tags] = tag
        }
        print(hn.requestURL)
        print(hn.params)
        // as of now I will do this logic in this calss context as
        //it become complecated I need to think of abstracting
        //let url = "http://hn.algolia.com/api/v1/search_by_date?query=Swift"
        //search_by_date //search
        Alamofire.request(.GET, hn.requestURL, parameters:hn.params)
            .response { request, response, data, error in
                if let data = data {
                    self.parse(data)
                }
                if let error = error {
                    print(error)
                }
                //FIX: what to do with error
            }

    }
}

protocol HNSearchManagerUpdate {
    func willChangeContent(dataManager: HNSearchManager)
    func didChangeContent(dataManager: HNSearchManager)
}
