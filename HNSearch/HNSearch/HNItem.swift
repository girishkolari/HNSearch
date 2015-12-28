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


struct HNItem: CustomStringConvertible {
    var objectID: String
    var createdAt: Int
    var parentID: Int?
    var points: Int
    var title: String?
    var storyTitle: String?
    var commentText: String?
    var url: String?
    var description: String {
        var returnString = "objectID: " +
            String(objectID) +
            " created_at_i: " +
            String(createdAt) +
            " points: " +
            String(points)
        if let parent_id = parentID {
            returnString += " parent_id: " + String(parent_id)
        }
        if let title = title {
            returnString += " title: " + title
        }
        if let story_title = storyTitle {
            returnString += " story_title: " + story_title
        }
        if let comment_text = commentText {
            returnString += " comment_text: " + comment_text
        }
        if let url = url {
            returnString += " url: " + url
        }
        return  returnString + "\n\n"
    }
}


extension HNItem {
    init(jsonItem: JSON) {
        self.title = jsonItem["title"].string
        self.storyTitle = jsonItem["story_title"].string
        self.objectID = jsonItem["objectID"].string ?? "0"
        self.createdAt = jsonItem["created_at_i"].int ?? 0
        self.parentID = jsonItem["parent_id"].int
        self.commentText = jsonItem["comment_text"].string
        self.points = jsonItem["points"].int ?? 0
        self.url = jsonItem["url"].string
    }
}
