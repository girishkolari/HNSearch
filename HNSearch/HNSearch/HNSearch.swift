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

enum Search: String {
    case SearchByDate = "search_by_date"
    case Search = "search"
}

enum HNSearchParams: String {
    case Query = "query"
    case Tags = "tags"
    case NumericFilters = "numericFilters"
    case Page = "page"
}


///
///
public struct HNSearch: HTTPURL {
    let url: String
    var searchBy: Search = .SearchByDate
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
            switch param {
            case .Query:
                return search.value
            case .Tags:
                return tag.value
            case .NumericFilters:
                return filters.value
            case .Page:
                return pageNumber.value
            }

        }
        set(newValue) {
            //set new value for the param
            switch param {
            case .Query:
                search.value = newValue
            case .Tags:
                tag.value = newValue
            case .NumericFilters:
                filters.value = newValue
            case .Page:
                pageNumber.value = newValue
            }

        }
    }
}



///
///
enum Tags: DataValue, CustomStringConvertible {
    case Story
    case Comment
    case Poll
    case Pollopt
    case ShowHN
    case AskHN
    case FrontPage
    case Author(String)//:USERNAME
    case StoryID(String)//:ID
    private enum HNTags: String {
        case Story = "story"
        case Comment = "comment"
        case Poll = "poll"
        case Pollopt = "pollopt"
        case ShowHN = "show_hn"
        case AskHN = "ask_hn"
        case FrontPage = "front_page"
        case Author = "author_"
        case StoryID = "story_"

        static var tags: [HNTags] {
            return [.Story,
                .Comment,
                .Poll,
                .Pollopt,
                .Pollopt,
                .AskHN,
                .FrontPage,
                .Author,
                .StoryID]
        }
    }
    func dataValue() -> String {
        switch self {
        case .Author(let userName):
            return HNTags.Author.rawValue + userName
        case .StoryID(let id):
            return HNTags.StoryID.rawValue + id
        default:
            let strVal: [Tags] = [.Story, .Comment, .Poll, .Pollopt, .ShowHN, .AskHN, .FrontPage]
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

func == (lhs: Tags, rhs: Tags) -> Bool {
    switch (lhs, rhs) {
    case (.Story, .Story),
    (.Comment, .Comment),
    (.Poll, .Poll),
    (.Pollopt, .Pollopt),
    (.ShowHN, .ShowHN),
    (.AskHN, .AskHN),
    (.FrontPage, .FrontPage):
        return true
    case (let .StoryID(idLHS), let .StoryID(isRHS)):
        return idLHS == isRHS
    case (let .Author(userNameLHS), let .Author(userNameRHS)):
        return userNameLHS == userNameRHS
    default:
        return false
    }
}





struct NumericFilters: DataValue, CustomStringConvertible {
    enum Numerical: String {
        case CreatedAt = "created_at_i"
        case Points = "points"
        case NumComments = "num_comments"
    }
    var filters: NumericFilters.Numerical
    enum Condition: String {
        case Less = "<"
        case LessAndEqual = "<="
        case Greater = ">"
        case GreaterAndEqual = ">="
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

//let t = NumericFilters(filters: .created_at_i, cond: NumericFilters.Condition.less, value: 0)



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
