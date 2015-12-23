//===--- HNSearchAPI.swift - Hacker News search request ----------------===//
//
//  HNSearchAPI.swift
//  HNSearch
//
//  Created by Girish Kolari on 12/12/15.
//  Copyright © 2015 Girish Kolari. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
//      HNSearchAPI.swift - Hacker News search request
//
//===----------------------------------------------------------------------===//

import Foundation

enum Search : String{
    case search_by_date = "search_by_date"
    case search = "search"
    
}

enum HNSearchParams: String {
    case query = "query"
    case tags = "tags"
    case numericFilters = "numericFilters"
    case page = "page"
}


///
///
public struct HNSearch: HTTPURL {
    
    let url: String
    var searchBy: Search = .search_by_date
    var search = Param("query")
    var tag = Param("tags")
    var filters = Param("numericFilters")
    var pageNumber = Param("page")
    
    init() {
        self.url = "http://hn.algolia.com/api/v1/"
    }
    
    var webURL: String {    return requestURL   }
    var paramList: [Param] {   return  [search, tag, filters, pageNumber]  }
    var headder: [String:String]? { return nil  }

    
    
    
    var requestURL: String {
        return url + searchBy.rawValue
    }


    subscript(param: HNSearchParams) -> DataValue? {
        get {
            //return value for the param
            switch(param) {
            case .query:
                return search.value;
            case .tags:
                return tag.value
            case .numericFilters:
                return filters.value
            case .page:
                return pageNumber.value
            }

        }
        set(newValue) {
            //set new value for the param
            switch(param) {
            case .query:
                search.value = newValue
            case .tags:
                tag.value = newValue
            case .numericFilters:
                filters.value = newValue
            case .page:
                pageNumber.value = newValue
            }

        }
    }
}



///
///
enum Tags: DataValue , CustomStringConvertible{
    
    case story
    case comment
    case poll
    case pollopt
    case show_hn
    case ask_hn
    case front_page
    case author_(String)//:USERNAME
    case story_(String)//:ID
    
    private enum HNTags : String {
        case _story = "story"
        case _comment = "comment"
        case _poll = "poll"
        case _pollopt = "pollopt"
        case _show_hn = "show_hn"
        case _ask_hn = "ask_hn"
        case _front_page = "front_page"
        case _author_ = "author_"
        case _story_ = "story_"

        static var tags: [HNTags] {
            return [._story,._comment,._poll,._pollopt,._show_hn,._ask_hn,._front_page,._author_,._story_]
        }
    
    }
    
    func dataValue() -> String {
        
        switch(self) {
        case .author_(let userName):
            return HNTags._author_.rawValue + userName
        case .story_(let id):
            return HNTags._story_.rawValue + id
        default:
            let strVal:[Tags] = [.story,.comment,.poll,.pollopt,.show_hn,.ask_hn,.front_page]
            
            for (i, value) in strVal.enumerate() {
                if value == self {
                    return HNTags.tags[i].rawValue
                }
            }
            
        }
        
        return ""
        
    }
    
    var description: String {
        return dataValue()
    }

}

extension Tags: Equatable {}

func ==(lhs: Tags, rhs: Tags) -> Bool {
    switch (lhs, rhs) {
        
    case (.story, .story),
    (.comment, .comment),
    (.poll, .poll),
    (.pollopt, .pollopt),
    (.show_hn, .show_hn),
    (.ask_hn, .ask_hn),
    (.front_page, .front_page):
        return true
    case (let .story_(idLHS), let .story_(isRHS)):
        return idLHS == isRHS
    case (let .author_(userNameLHS), let .author_(userNameRHS)):
        return userNameLHS == userNameRHS
    default:
        return false
    }
}





struct NumericFilters : DataValue , CustomStringConvertible {
    enum Numerical: String {
        case created_at_i = "created_at_i"
        case points = "points"
        case num_comments = "num_comments"
    }
    
    var filters: NumericFilters.Numerical
    
    enum Condition: String {
        case less = "<"
        case lessAndEqual = "<="
        case greater = ">"
        case greaterAndEqual = ">="
    }
    var cond: NumericFilters.Condition
    var value: Int
    
    
    func dataValue() -> String {
        return filters.rawValue + cond.rawValue + String(value)
    }
    
    var description: String {
        return dataValue()
    }

}

let t = NumericFilters(filters: .created_at_i, cond: NumericFilters.Condition.less, value: 0)



//public func ==<Datatype: Equatable>(lhs: Param<Datatype>, rhs: Param<Datatype>) -> Bool {
//    return lhs.key == rhs.key //&& lhs.value == rhs.value
//}


/*
numericFilters=	filter on a specific numerical condition (<, <=, =, > or >=).
Available numerical fields:
created_at_i
points
num_comments
*/

//https://hn.algolia.com/api
//https://github.com/HackerNews/API