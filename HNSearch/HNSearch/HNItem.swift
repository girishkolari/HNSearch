//===----------------------------------------------------------------------===//
//
//  HNItem.swift
//  HNSearch
//
//  Created by Girish Kolari on 12/12/15.
//  Copyright © 2015 Girish Kolari. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
//      HNItem.swift - Hacker News search result
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftyJSON


struct HNItem : CustomStringConvertible{
    var objectID: String
    var created_at_i: Int
    var parent_id: Int?
    var points: Int
    var title: String?
    var story_title: String?
    var comment_text: String?
    var url: String?
    
    var description: String {
        var returnString = "objectID: " + String(objectID) + " created_at_i: " + String(created_at_i) + " points: " + String(points)
        
        
        if let parent_id = parent_id {
            returnString += " parent_id: " + String(parent_id)
        }
        
        if let title = title {
            returnString += " title: " + title
        }
        
        if let story_title = story_title {
            returnString += " story_title: " + story_title
        }
        
        if let comment_text = comment_text {
            returnString += " comment_text: " + comment_text
        }
        
        if let url = url {
            returnString += " url: " + url
        }
        
        
        return  returnString + "\n\n"
    }
}


extension HNItem{
    init(jsonItem: JSON) {
        self.title = jsonItem["title"].string
        self.story_title = jsonItem["story_title"].string
        self.objectID = jsonItem["objectID"].string ?? "0"
        self.created_at_i = jsonItem["created_at_i"].int ?? 0
        self.parent_id = jsonItem["parent_id"].int
        self.comment_text = jsonItem["comment_text"].string
        self.points = jsonItem["points"].int ?? 0
        self.url = jsonItem["url"].string
        
        
    }
}



