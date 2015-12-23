//===----------------------------------------------------------------------===//
//
//  Param.swift
//  HNSearch
//
//  Created by Girish Kolari on 12/17/15.
//  Copyright © 2015 Girish Kolari. All rights reserved.
//
//===----------------------------------------------------------------------===//
//
//      Param.swift - url parameter representation class
//
//===----------------------------------------------------------------------===//

import Foundation

///
///
public struct Param  {
    let key: String
    var value: DataValue?
    
    init(_ key: String) {
        self.key = key
    }
    
    var paramValue: [String:String]? {
        if let value = value {
            return [key:value.dataValue()]
        }
        return nil
    }
}